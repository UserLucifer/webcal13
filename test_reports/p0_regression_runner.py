import hashlib
import json
import os
import subprocess
import sys
import traceback
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime
from decimal import Decimal


BASE = "http://localhost:8080"
MYSQL = r"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
DB_ARGS = [MYSQL, "-uroot", "-proot", "-D", "compute_rental", "-N", "-B", "--raw"]
REPORT_DIR = r"E:\WebCal13\test_reports"


class RegressionRun:
    def __init__(self):
        self.run_id = datetime.now().strftime("%Y%m%d%H%M%S")
        self.parent_email = f"p0_parent_{self.run_id}@example.com"
        self.child_email = f"p0_child_{self.run_id}@example.com"
        self.password = "P0test123456!"
        self.signup_code = "135790"
        self.withdraw_code = "246810"
        self.parent_token = None
        self.child_token = None
        self.admin_token = None
        self.parent_user_id = None
        self.child_user_id = None
        self.admin_log_start = None
        self.scheduler_log_start = None
        self.recharge_no = None
        self.withdraw_no = None
        self.order_no = None
        self.settlement_no = None
        self.result_path = os.path.join(REPORT_DIR, f"p0_regression_api_{self.run_id}.json")
        self.state = {
            "runId": self.run_id,
            "startedAt": datetime.now().isoformat(timespec="seconds"),
            "baseUrl": BASE,
            "parentEmail": self.parent_email,
            "childEmail": self.child_email,
            "created": {},
            "steps": [],
            "checks": [],
            "cleanup": {},
            "errors": [],
        }

    def step(self, name, detail=None):
        item = {"name": name, "at": datetime.now().isoformat(timespec="seconds")}
        if detail is not None:
            item["detail"] = detail
        self.state["steps"].append(item)
        print(f"[STEP] {name}")

    def check(self, name, ok, detail=None):
        item = {"name": name, "ok": bool(ok), "at": datetime.now().isoformat(timespec="seconds")}
        if detail is not None:
            item["detail"] = detail
        self.state["checks"].append(item)
        if not ok:
            raise AssertionError(f"check failed: {name}: {detail}")

    @staticmethod
    def dec(value):
        if value is None:
            return Decimal("0")
        return Decimal(str(value))

    @staticmethod
    def quote(value):
        if value is None:
            return "NULL"
        return "'" + str(value).replace("\\", "\\\\").replace("'", "''") + "'"

    def sql(self, query, expect_rows=True):
        proc = subprocess.run(
            DB_ARGS + ["-e", query],
            text=True,
            capture_output=True,
            encoding="utf-8",
            errors="replace",
        )
        if proc.returncode != 0:
            raise RuntimeError(f"MySQL failed: {proc.stderr.strip()}\nSQL: {query}")
        out = proc.stdout.strip("\n")
        if not expect_rows or not out.strip():
            return []
        return [line.split("\t") for line in out.splitlines()]

    def scalar(self, query, default=None):
        rows = self.sql(query)
        if not rows or not rows[0]:
            return default
        return rows[0][0]

    def api(self, method, path, body=None, token=None, params=None):
        url = BASE + path
        if params:
            url += "?" + urllib.parse.urlencode(params)
        data = None
        headers = {"Accept": "application/json", "Accept-Language": "zh-CN"}
        if body is not None:
            data = json.dumps(body, ensure_ascii=False).encode("utf-8")
            headers["Content-Type"] = "application/json; charset=utf-8"
        if token:
            headers["Authorization"] = "Bearer " + token
        req = urllib.request.Request(url, data=data, headers=headers, method=method)
        try:
            with urllib.request.urlopen(req, timeout=45) as resp:
                text = resp.read().decode("utf-8")
        except urllib.error.HTTPError as exc:
            text = exc.read().decode("utf-8", errors="replace")
            raise RuntimeError(f"HTTP {exc.code} {method} {path}: {text}")
        if not text:
            return None
        payload = json.loads(text)
        if isinstance(payload, dict) and "code" in payload:
            if payload.get("code") != 0:
                raise RuntimeError(
                    f"API business error {method} {path}: "
                    f"code={payload.get('code')} message={payload.get('message')}"
                )
            return payload.get("data")
        return payload

    def insert_code(self, email, scene, code):
        normalized = email.strip().lower()
        code_hash = hashlib.sha256(f"{normalized}:{scene}:{code}".encode("utf-8")).hexdigest()
        self.sql(
            "INSERT INTO email_verify_code "
            "(email, scene, code_hash, send_ip, expire_at, status, created_at) "
            f"VALUES ({self.quote(normalized)}, {self.quote(scene)}, {self.quote(code_hash)}, "
            "'127.0.0.1', DATE_ADD(NOW(), INTERVAL 30 MINUTE), 0, NOW())",
            expect_rows=False,
        )

    def get_user_row(self, email):
        rows = self.sql(
            "SELECT u.id, COALESCE(r.invite_code, '') "
            "FROM app_user u LEFT JOIN user_referral_relation r ON r.user_id = u.id "
            f"WHERE u.email = {self.quote(email.strip().lower())} LIMIT 1"
        )
        if not rows:
            raise RuntimeError(f"user not found: {email}")
        return int(rows[0][0]), rows[0][1]

    def login_user(self, email):
        data = self.api("POST", "/api/auth/login", {"email": email, "password": self.password})
        return data["accessToken"]

    def cleanup(self):
        cleanup_info = {"startedAt": datetime.now().isoformat(timespec="seconds")}
        try:
            ids = [str(x) for x in (self.parent_user_id, self.child_user_id) if x]
            emails = [self.parent_email, self.child_email]
            if ids:
                id_csv = ",".join(ids)
                biz_nos = []
                for query in (
                    f"SELECT recharge_no FROM recharge_order WHERE user_id IN ({id_csv})",
                    f"SELECT withdraw_no FROM withdraw_order WHERE user_id IN ({id_csv})",
                ):
                    biz_nos.extend(row[0] for row in self.sql(query) if row and row[0])
                biz_csv = ",".join(self.quote(x) for x in biz_nos) if biz_nos else "''"
                self.sql(
                    f"""
SET FOREIGN_KEY_CHECKS=0;
DELETE r FROM admin_todo_notice_read r JOIN admin_todo_notice n ON r.notice_id = n.id WHERE n.user_id IN ({id_csv}) OR n.biz_no IN ({biz_csv});
DELETE FROM admin_todo_notice WHERE user_id IN ({id_csv}) OR biz_no IN ({biz_csv});
DELETE FROM commission_record WHERE benefit_user_id IN ({id_csv}) OR source_user_id IN ({id_csv}) OR source_order_id IN (SELECT id FROM rental_order WHERE user_id IN ({id_csv})) OR source_profit_id IN (SELECT id FROM rental_profit_record WHERE user_id IN ({id_csv}));
DELETE FROM rental_profit_record WHERE user_id IN ({id_csv}) OR rental_order_id IN (SELECT id FROM rental_order WHERE user_id IN ({id_csv}));
DELETE FROM rental_settlement_order WHERE user_id IN ({id_csv}) OR rental_order_id IN (SELECT id FROM rental_order WHERE user_id IN ({id_csv}));
DELETE FROM api_deploy_order WHERE user_id IN ({id_csv}) OR rental_order_id IN (SELECT id FROM rental_order WHERE user_id IN ({id_csv}));
DELETE FROM api_credential WHERE user_id IN ({id_csv}) OR rental_order_id IN (SELECT id FROM rental_order WHERE user_id IN ({id_csv}));
DELETE FROM rental_order_run_segment WHERE user_id IN ({id_csv}) OR rental_order_id IN (SELECT id FROM rental_order WHERE user_id IN ({id_csv}));
DELETE FROM rental_order WHERE user_id IN ({id_csv});
DELETE FROM withdraw_order WHERE user_id IN ({id_csv});
DELETE FROM recharge_order WHERE user_id IN ({id_csv});
DELETE FROM user_withdraw_address WHERE user_id IN ({id_csv});
DELETE FROM token_transaction WHERE user_id IN ({id_csv});
DELETE FROM wallet_transaction WHERE user_id IN ({id_csv});
DELETE FROM user_token_wallet WHERE user_id IN ({id_csv});
DELETE FROM user_wallet WHERE user_id IN ({id_csv});
DELETE FROM sys_notification WHERE user_id IN ({id_csv});
DELETE FROM user_push_device WHERE user_id IN ({id_csv});
DELETE FROM user_team_relation WHERE ancestor_user_id IN ({id_csv}) OR descendant_user_id IN ({id_csv});
DELETE FROM user_referral_relation WHERE user_id IN ({id_csv}) OR parent_user_id IN ({id_csv}) OR level1_user_id IN ({id_csv}) OR level2_user_id IN ({id_csv});
DELETE FROM app_user WHERE id IN ({id_csv});
SET FOREIGN_KEY_CHECKS=1;
""",
                    expect_rows=False,
                )
            email_csv = ",".join(self.quote(e) for e in emails)
            self.sql(f"DELETE FROM email_verify_code WHERE email IN ({email_csv})", expect_rows=False)
            if self.admin_log_start is not None:
                self.sql(
                    "DELETE FROM sys_admin_log "
                    f"WHERE id > {int(self.admin_log_start)} "
                    "AND action IN ('APPROVE_RECHARGE','REJECT_RECHARGE','APPROVE_WITHDRAW',"
                    "'REJECT_WITHDRAW','PAID_WITHDRAW','RUN_SCHEDULER')",
                    expect_rows=False,
                )
            if self.scheduler_log_start is not None:
                self.sql(
                    f"DELETE FROM scheduler_log WHERE id > {int(self.scheduler_log_start)} "
                    "AND task_name='COMMISSION_GENERATE'",
                    expect_rows=False,
                )
            remaining = {}
            if ids:
                id_csv = ",".join(ids)
                probes = [
                    ("app_user", f"id IN ({id_csv})"),
                    ("user_wallet", f"user_id IN ({id_csv})"),
                    ("user_token_wallet", f"user_id IN ({id_csv})"),
                    ("recharge_order", f"user_id IN ({id_csv})"),
                    ("withdraw_order", f"user_id IN ({id_csv})"),
                    ("rental_order", f"user_id IN ({id_csv})"),
                    ("rental_profit_record", f"user_id IN ({id_csv})"),
                    ("commission_record", f"benefit_user_id IN ({id_csv}) OR source_user_id IN ({id_csv})"),
                    ("admin_todo_notice", f"user_id IN ({id_csv})"),
                ]
                for table, where in probes:
                    remaining[table] = int(self.scalar(f"SELECT COUNT(*) FROM {table} WHERE {where}", 0))
            remaining["email_verify_code"] = int(
                self.scalar(f"SELECT COUNT(*) FROM email_verify_code WHERE email IN ({email_csv})", 0)
            )
            cleanup_info["remaining"] = remaining
            cleanup_info["ok"] = all(value == 0 for value in remaining.values())
        except Exception as exc:
            cleanup_info["ok"] = False
            cleanup_info["error"] = str(exc)
            self.state["errors"].append({"phase": "cleanup", "error": str(exc), "trace": traceback.format_exc()})
        cleanup_info["finishedAt"] = datetime.now().isoformat(timespec="seconds")
        self.state["cleanup"] = cleanup_info

    def run(self):
        try:
            self.step("preflight db baselines")
            self.admin_log_start = int(self.scalar("SELECT COALESCE(MAX(id),0) FROM sys_admin_log", 0))
            self.scheduler_log_start = int(self.scalar("SELECT COALESCE(MAX(id),0) FROM scheduler_log", 0))
            unrelated = int(
                self.scalar("SELECT COUNT(*) FROM rental_profit_record WHERE status='SETTLED' AND commission_generated=0", 0)
            )
            self.check("commission candidate baseline is clean", unrelated == 0, {"count": unrelated})

            self.step("admin login")
            admin_login = self.api("POST", "/api/admin/auth/login", {"userName": "admin", "password": "admin123"})
            self.admin_token = (
                admin_login.get("adminAccessToken") or admin_login.get("accessToken") or admin_login.get("token")
            )
            self.check("admin token received", bool(self.admin_token), {"keys": list(admin_login.keys())})

            self.step("signup parent/child users")
            self.insert_code(self.parent_email, "SIGNUP", self.signup_code)
            self.insert_code(self.child_email, "SIGNUP", self.signup_code)
            self.parent_token = self.api(
                "POST",
                "/api/auth/signup",
                {
                    "email": self.parent_email,
                    "code": self.signup_code,
                    "userName": f"P0Parent{self.run_id[-6:]}",
                    "password": self.password,
                },
            )["accessToken"]
            self.parent_user_id, invite_code = self.get_user_row(self.parent_email)
            self.child_token = self.api(
                "POST",
                "/api/auth/signup",
                {
                    "email": self.child_email,
                    "code": self.signup_code,
                    "userName": f"P0Child{self.run_id[-6:]}",
                    "password": self.password,
                    "inviteCode": invite_code,
                },
            )["accessToken"]
            self.child_user_id, _ = self.get_user_row(self.child_email)
            self.parent_token = self.login_user(self.parent_email)
            self.child_token = self.login_user(self.child_email)
            self.state["created"].update(
                {"parentUserId": self.parent_user_id, "childUserId": self.child_user_id, "inviteCode": invite_code}
            )
            team_summary = self.api("GET", "/api/team/summary", token=self.parent_token)
            self.check("invite relation visible in parent team summary", int(team_summary.get("directTeamCount", 0)) >= 1, team_summary)

            self.step("load catalog, channel, estimate")
            products = self.api("GET", "/api/products", params={"pageNo": 1, "pageSize": 100, "language": "zh-CN"})
            product_records = products.get("records") or []
            rentable = [
                p for p in product_records
                if int(p.get("availableStock") or 0) > 0 and self.dec(p.get("rentPrice")) > 0
            ]
            product = min(rentable or product_records, key=lambda p: self.dec(p.get("rentPrice")))
            models = self.api("GET", "/api/ai-models", params={"language": "zh-CN"}) or []
            cycles = self.api("GET", "/api/rental-cycle-rules", params={"language": "zh-CN"}) or []
            channels = self.api(
                "GET", "/api/recharge/channels", token=self.child_token, params={"language": "zh-CN"}
            ) or []
            model = models[0] if models else None
            cycle = min(cycles, key=lambda x: int(x.get("cycleDays") or 9999)) if cycles else None
            channel = channels[0] if channels else None
            self.check(
                "catalog prerequisites available",
                bool(product and model and cycle and channel),
                {
                    "productCount": len(product_records),
                    "modelCount": len(models),
                    "cycleCount": len(cycles),
                    "channelCount": len(channels),
                },
            )
            estimate = self.api(
                "POST",
                "/api/rental/estimate",
                {"productId": product["id"], "aiModelId": model["id"], "cycleRuleId": cycle["id"], "language": "zh-CN"},
                token=self.child_token,
            )
            self.check(
                "rental estimate returns positive amount/profit",
                self.dec(estimate.get("rentPrice")) > 0 and self.dec(estimate.get("expectedDailyProfit")) > 0,
                estimate,
            )
            self.state["created"]["selection"] = {
                "productId": product["id"],
                "productName": product.get("productName"),
                "rentPrice": str(product.get("rentPrice")),
                "aiModelId": model["id"],
                "aiModelName": model.get("modelName"),
                "cycleRuleId": cycle["id"],
                "cycleDays": cycle.get("cycleDays"),
                "channelId": channel["channelId"],
            }

            self.step("create and approve recharge")
            recharge_amount = 10000000.00
            recharge_body = {
                "channelId": channel["channelId"],
                "applyAmount": recharge_amount,
                "externalTxNo": f"P0TX{self.run_id}",
                "paymentProofUrl": f"https://example.com/p0-proof/{self.run_id}.png",
                "userRemark": f"P0 regression {self.run_id}",
                "clientRequestId": f"p0-recharge-{self.run_id}",
            }
            recharge = self.api("POST", "/api/recharge/orders", recharge_body, token=self.child_token)
            replay = self.api("POST", "/api/recharge/orders", recharge_body, token=self.child_token)
            self.recharge_no = recharge["rechargeNo"]
            self.state["created"]["rechargeNo"] = self.recharge_no
            self.check("recharge idempotency", replay["rechargeNo"] == self.recharge_no, {"rechargeNo": self.recharge_no})
            approved = self.api(
                "POST",
                f"/api/admin/recharge/orders/{urllib.parse.quote(self.recharge_no)}/approve",
                {"actualAmount": recharge_amount, "reviewRemark": f"P0 approve {self.run_id}"},
                token=self.admin_token,
            )
            wallet = self.api("GET", "/api/wallet/me", token=self.child_token)
            self.check("recharge approved and credited", approved.get("status") == "APPROVED" and self.dec(wallet.get("availableBalance")) >= self.dec(recharge_amount), {"approved": approved, "wallet": wallet})

            self.step("create withdraw address/order and admin paid")
            address = self.api(
                "POST",
                "/api/withdraw/addresses",
                {
                    "network": "TRC20",
                    "accountName": "P0 Regression",
                    "accountNo": "TQn9Y2khEsLJW1ChVWFMSMeRDow5KcbLSE",
                    "label": f"P0 {self.run_id}",
                    "defaultAddress": True,
                },
                token=self.child_token,
            )
            self.insert_code(self.child_email, "WITHDRAW", self.withdraw_code)
            withdraw = self.api(
                "POST",
                "/api/withdraw/orders",
                {
                    "applyAmount": 123.45,
                    "emailCode": self.withdraw_code,
                    "clientRequestId": f"p0-withdraw-{self.run_id}",
                    "withdrawAddressId": address.get("addressId"),
                },
                token=self.child_token,
            )
            self.withdraw_no = withdraw["withdrawNo"]
            self.state["created"]["withdrawNo"] = self.withdraw_no
            self.check("withdraw created and frozen", withdraw.get("status") == "PENDING_REVIEW" and withdraw.get("freezeTxNo"), withdraw)
            approved_withdraw = self.api(
                "POST",
                f"/api/admin/withdraw/orders/{urllib.parse.quote(self.withdraw_no)}/approve",
                {"reviewRemark": f"P0 approve {self.run_id}"},
                token=self.admin_token,
            )
            paid_withdraw = self.api(
                "POST",
                f"/api/admin/withdraw/orders/{urllib.parse.quote(self.withdraw_no)}/paid",
                {"payProofNo": f"P0PAY{self.run_id}"},
                token=self.admin_token,
            )
            self.check(
                "withdraw approved and paid",
                approved_withdraw.get("status") == "APPROVED" and paid_withdraw.get("status") == "PAID" and paid_withdraw.get("paidTxNo"),
                paid_withdraw,
            )

            self.step("create rental order, pay machine fee, pay deploy fee")
            rental_body = {
                "productId": product["id"],
                "aiModelId": model["id"],
                "cycleRuleId": cycle["id"],
                "clientRequestId": f"p0-rental-{self.run_id}",
            }
            order = self.api("POST", "/api/rental/orders", rental_body, token=self.child_token)
            replay_order = self.api("POST", "/api/rental/orders", rental_body, token=self.child_token)
            self.order_no = order["orderNo"]
            self.state["created"]["rentalOrderNo"] = self.order_no
            self.check("rental order idempotency", replay_order["orderNo"] == self.order_no, {"orderNo": self.order_no})
            paid_order = self.api("POST", f"/api/rental/orders/{urllib.parse.quote(self.order_no)}/pay", token=self.child_token)
            credential = paid_order.get("apiCredential") or {}
            self.check(
                "machine fee paid and credential generated",
                paid_order.get("orderStatus") == "PENDING_ACTIVATION" and credential.get("tokenStatus") == "GENERATED",
                paid_order,
            )
            deploy = self.api("POST", f"/api/rental/orders/{urllib.parse.quote(self.order_no)}/deploy/pay", token=self.child_token)
            running_detail = self.api("GET", f"/api/rental/orders/{urllib.parse.quote(self.order_no)}", token=self.child_token)
            self.check(
                "deploy fee paid and order running",
                deploy.get("status") == "PAID"
                and running_detail.get("orderStatus") == "RUNNING"
                and (running_detail.get("apiCredential") or {}).get("tokenStatus") == "ACTIVE",
                {"deploy": deploy, "detailStatus": running_detail.get("orderStatus")},
            )
            api_page = self.api("GET", "/api/rental/api-management", token=self.child_token, params={"pageNo": 1, "pageSize": 10})
            self.check(
                "api management shows running API",
                any(r.get("orderNo") == self.order_no and r.get("apiStage") == "RUNNING" for r in (api_page.get("records") or [])),
                api_page,
            )

            self.step("backdate temp order run segment for profit generation")
            self.sql(
                f"""
UPDATE rental_order SET profit_start_at = DATE_SUB(NOW(), INTERVAL 1 DAY), started_at = DATE_SUB(NOW(), INTERVAL 1 DAY), activated_at = DATE_SUB(NOW(), INTERVAL 1 DAY), deploy_fee_paid_at = DATE_SUB(NOW(), INTERVAL 1 DAY), updated_at = NOW() WHERE order_no = {self.quote(self.order_no)} AND user_id = {self.child_user_id};
UPDATE api_credential SET started_at = DATE_SUB(NOW(), INTERVAL 1 DAY), activated_at = DATE_SUB(NOW(), INTERVAL 1 DAY), activation_paid_at = DATE_SUB(NOW(), INTERVAL 1 DAY), updated_at = NOW() WHERE rental_order_id = (SELECT id FROM rental_order WHERE order_no = {self.quote(self.order_no)} AND user_id = {self.child_user_id});
UPDATE rental_order_run_segment SET segment_start_at = DATE_SUB(NOW(), INTERVAL 1 DAY), created_at = DATE_SUB(NOW(), INTERVAL 1 DAY), updated_at = NOW() WHERE rental_order_id = (SELECT id FROM rental_order WHERE order_no = {self.quote(self.order_no)} AND user_id = {self.child_user_id}) AND segment_end_at IS NULL;
""",
                expect_rows=False,
            )
            today_estimate = self.api("GET", "/api/profit/today-estimate", token=self.child_token)
            self.check("today estimate readable while order running", self.dec(today_estimate.get("estimatedProfit")) >= 0, today_estimate)

            self.step("early settle rental order and verify profit/token wallet")
            settlement = self.api("POST", f"/api/rental/orders/{urllib.parse.quote(self.order_no)}/settle-early", token=self.child_token)
            self.settlement_no = settlement.get("settlementNo")
            self.state["created"]["settlementNo"] = self.settlement_no
            closed = self.api("GET", f"/api/rental/orders/{urllib.parse.quote(self.order_no)}", token=self.child_token)
            profit_summary = self.api("GET", "/api/profit/summary", token=self.child_token)
            token_wallet = self.api("GET", "/api/token-wallet/me", token=self.child_token)
            profit_records = self.api("GET", "/api/profit/records", token=self.child_token, params={"pageNo": 1, "pageSize": 20})
            self.check(
                "early settlement closed order",
                settlement.get("status") == "SETTLED"
                and closed.get("orderStatus") == "EARLY_CLOSED"
                and (closed.get("apiCredential") or {}).get("tokenStatus") == "REVOKED",
                {"settlement": settlement, "orderStatus": closed.get("orderStatus")},
            )
            self.check(
                "profit and token settlement visible",
                self.dec(profit_summary.get("totalProfit")) > 0
                and self.dec(token_wallet.get("totalEarned")) > 0
                and int(profit_records.get("total") or 0) > 0,
                {"profitSummary": profit_summary, "tokenWallet": token_wallet, "profitRecordTotal": profit_records.get("total")},
            )

            self.step("run commission generation scheduler for temp profit records")
            candidate_row = self.sql(
                "SELECT COUNT(*), COALESCE(SUM(CASE WHEN user_id = %d THEN 1 ELSE 0 END),0) "
                "FROM rental_profit_record WHERE status='SETTLED' AND commission_generated=0" % self.child_user_id
            )[0]
            total_candidates = int(candidate_row[0])
            own_candidates = int(Decimal(candidate_row[1]))
            self.check("commission candidates are only temp records", total_candidates == own_candidates and own_candidates > 0, {"total": total_candidates, "temp": own_candidates})
            sched = self.api("POST", "/api/admin/scheduler/commission-generate/run", token=self.admin_token)
            self.check("commission scheduler succeeded", sched.get("status") == "SUCCESS" and int(sched.get("successCount") or 0) >= own_candidates, sched)
            commission_summary = self.api("GET", "/api/commission/summary", token=self.parent_token)
            commission_records = self.api("GET", "/api/commission/records", token=self.parent_token, params={"pageNo": 1, "pageSize": 20})
            parent_wallet = self.api("GET", "/api/wallet/me", token=self.parent_token)
            self.check(
                "parent commission visible and wallet credited",
                self.dec(commission_summary.get("totalCommission")) > 0
                and int(commission_records.get("total") or 0) > 0
                and self.dec(parent_wallet.get("totalCommission")) > 0,
                {"commissionSummary": commission_summary, "recordsTotal": commission_records.get("total"), "parentWallet": parent_wallet},
            )

            self.step("verify list endpoints for p0 closure")
            child_wallet = self.api("GET", "/api/wallet/me", token=self.child_token)
            order_list = self.api("GET", "/api/rental/orders", token=self.child_token, params={"pageNo": 1, "pageSize": 20})
            recharge_list = self.api("GET", "/api/recharge/orders", token=self.child_token, params={"pageNo": 1, "pageSize": 20})
            withdraw_list = self.api("GET", "/api/withdraw/orders", token=self.child_token, params={"pageNo": 1, "pageSize": 20})
            settlement_list = self.api("GET", "/api/settlement/orders", token=self.child_token, params={"pageNo": 1, "pageSize": 20})
            team_members = self.api("GET", "/api/team/members", token=self.parent_token, params={"pageNo": 1, "pageSize": 20})
            self.check(
                "user-side order/recharge/withdraw/settlement/team lists include temp data",
                any(r.get("orderNo") == self.order_no for r in (order_list.get("records") or []))
                and any(r.get("rechargeNo") == self.recharge_no for r in (recharge_list.get("records") or []))
                and any(r.get("withdrawNo") == self.withdraw_no for r in (withdraw_list.get("records") or []))
                and any(r.get("settlementNo") == self.settlement_no for r in (settlement_list.get("records") or []))
                and int(team_members.get("total") or 0) >= 1,
                {
                    "childWallet": child_wallet,
                    "orderTotal": order_list.get("total"),
                    "rechargeTotal": recharge_list.get("total"),
                    "withdrawTotal": withdraw_list.get("total"),
                    "settlementTotal": settlement_list.get("total"),
                    "teamTotal": team_members.get("total"),
                },
            )
            self.state["status"] = "passed"
        except Exception as exc:
            self.state["status"] = "failed"
            self.state["errors"].append({"phase": "run", "error": str(exc), "trace": traceback.format_exc()})
            print("[ERROR]", exc)
        finally:
            self.cleanup()
            self.state["finishedAt"] = datetime.now().isoformat(timespec="seconds")
            with open(self.result_path, "w", encoding="utf-8") as output:
                json.dump(self.state, output, ensure_ascii=False, indent=2, default=str)
            print("[RESULT]", self.result_path)
            print("[STATUS]", self.state.get("status"))
            print("[CLEANUP]", json.dumps(self.state.get("cleanup"), ensure_ascii=False, default=str))
            if self.state.get("status") != "passed" or not self.state.get("cleanup", {}).get("ok"):
                return 1
            return 0


if __name__ == "__main__":
    os.makedirs(REPORT_DIR, exist_ok=True)
    sys.exit(RegressionRun().run())
