export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname === "/version" && request.method === "GET") {
      return handleVersion(request, env, url);
    }

    if (
      url.pathname === "/download" &&
      (request.method === "GET" || request.method === "HEAD")
    ) {
      return handleDownload(request, env, url);
    }

    return env.ASSETS.fetch(request);
  },
};

async function handleVersion(request, env, url) {
  if (!isAuthorized(request, env, url)) {
    return json({ message: "Invite code is invalid or expired" }, 401);
  }

  const latest = await readLatest(env);
  if (!latest) {
    return json({ message: "No APK version is published" }, 404);
  }

  const downloadUrl = new URL("/download", url.origin);
  const code = url.searchParams.get("code");
  if (code) {
    downloadUrl.searchParams.set("code", code);
  }

  return json({
    versionName: latest.versionName,
    versionCode: latest.versionCode,
    minSupportedVersionCode: latest.minSupportedVersionCode,
    forceUpdate: latest.forceUpdate,
    fileName: latest.fileName,
    fileSizeBytes: latest.fileSizeBytes,
    sha256: latest.sha256,
    publishedAt: latest.publishedAt,
    releaseNotes: latest.releaseNotes,
    apkUrl: downloadUrl.toString(),
  });
}

async function handleDownload(request, env, url) {
  if (!isAuthorized(request, env, url)) {
    return json({ message: "Invite code is invalid or expired" }, 401);
  }

  const latest = await readLatest(env);
  if (!latest?.objectKey) {
    return json({ message: "No APK file is published" }, 404);
  }

  const range = parseRange(request.headers.get("range"));
  const object = await env.APK_BUCKET.get(
    latest.objectKey,
    range ? { range } : undefined,
  );

  if (!object?.body) {
    return json({ message: "APK file not found" }, 404);
  }

  const headers = buildApkHeaders(object, latest);
  const body = request.method === "HEAD" ? null : object.body;

  if (range && object.range) {
    const total = object.size;
    const offset =
      object.range.offset ?? Math.max(0, total - object.range.suffix);
    const length = object.range.length ?? object.size;
    const end = Math.min(total - 1, offset + length - 1);
    headers.set("content-range", `bytes ${offset}-${end}/${total}`);
    headers.set("content-length", String(end - offset + 1));
    return new Response(body, { status: 206, headers });
  }

  headers.set("content-length", String(object.size));
  return new Response(body, { headers });
}

function buildApkHeaders(object, latest) {
  const fileName = safeFileName(latest.fileName);
  const headers = new Headers();

  object.writeHttpMetadata(headers);
  headers.set("content-type", "application/vnd.android.package-archive");
  headers.set("accept-ranges", "bytes");
  headers.set("x-content-type-options", "nosniff");
  headers.set(
    "content-disposition",
    `attachment; filename="${fileName}"; filename*=UTF-8''${encodeURIComponent(fileName)}`,
  );
  headers.set("cache-control", "private, no-transform, max-age=3600");
  headers.set("etag", object.httpEtag);

  if (latest.sha256) {
    headers.set("x-apk-sha256", latest.sha256);
  }

  return headers;
}

async function readLatest(env) {
  const object = await env.APK_BUCKET.get("latest.json");
  if (!object) {
    return null;
  }
  return object.json();
}

function isAuthorized(request, env, url) {
  const expected = String(env.INVITE_CODES || "")
    .split(",")
    .map((value) => value.trim())
    .filter(Boolean);

  if (expected.length === 0) {
    return false;
  }

  const provided =
    url.searchParams.get("code") ||
    request.headers.get("x-download-code") ||
    "";

  return expected.includes(provided.trim());
}

function parseRange(value) {
  if (!value) {
    return null;
  }
  const match = value.match(/^bytes=(\d*)-(\d*)$/);
  if (!match) {
    return null;
  }
  const start = match[1] === "" ? null : Number(match[1]);
  const end = match[2] === "" ? null : Number(match[2]);

  if (start === null && end !== null) {
    return { suffix: end };
  }
  if (start !== null && end !== null && end >= start) {
    return { offset: start, length: end - start + 1 };
  }
  if (start !== null && end === null) {
    return { offset: start };
  }
  return null;
}

function safeFileName(value) {
  return String(value || "webcal-client.apk").replace(/[^a-zA-Z0-9._+-]/g, "_");
}

function json(body, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      "content-type": "application/json; charset=utf-8",
      "cache-control": "no-store",
    },
  });
}
