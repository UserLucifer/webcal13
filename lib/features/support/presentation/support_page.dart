import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/async_state_view.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  late final WebViewController _controller;
  var _loadingProgress = 0;
  var _hasLoadError = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.softBackground)
      ..addJavaScriptChannel(
        'WebCalSupport',
        onMessageReceived: (_) {
          if (mounted) {
            setState(() => _hasLoadError = true);
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() => _loadingProgress = progress);
            }
          },
          onPageStarted: (_) {
            if (mounted) {
              setState(() {
                _hasLoadError = false;
                _loadingProgress = 0;
              });
            }
          },
          onPageFinished: (_) => _openChatwayWidget(),
          onWebResourceError: (error) {
            if (mounted && error.isForMainFrame == true) {
              setState(() => _hasLoadError = true);
            }
          },
        ),
      )
      ..loadHtmlString(_chatwayHtml, baseUrl: 'https://webcal.app/support');
  }

  Future<void> _reload() async {
    setState(() {
      _hasLoadError = false;
      _loadingProgress = 0;
    });
    await _controller.loadHtmlString(
      _chatwayHtml,
      baseUrl: 'https://webcal.app/support',
    );
  }

  Future<void> _openChatwayWidget() async {
    await _runOpenChatwayScript();
    unawaited(
      Future<void>.delayed(
        const Duration(seconds: 1),
        () => _runOpenChatwayScript(80),
      ),
    );
    unawaited(
      Future<void>.delayed(
        const Duration(seconds: 3),
        () => _runOpenChatwayScript(80),
      ),
    );
  }

  Future<void> _runOpenChatwayScript([int remaining = 120]) async {
    try {
      await _controller.runJavaScript('openChatwayWhenReady($remaining);');
    } catch (_) {
      // The Chatway script remains available through the on-page widget button.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = !_hasLoadError && _loadingProgress < 100;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
          icon: const Icon(LucideIcons.arrowLeft),
          tooltip: '返回',
        ),
        title: const Text('在线客服'),
        actions: [
          IconButton(
            onPressed: _reload,
            icon: const Icon(LucideIcons.refreshCcw),
            tooltip: '重新加载',
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: _loadingProgress <= 0 ? null : _loadingProgress / 100,
                  minHeight: 3,
                  color: AppColors.deepForest,
                  backgroundColor: AppColors.outline,
                ),
              ),
            if (_hasLoadError)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.softBackground,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: ErrorCard(
                        message: '客服页面加载失败，请检查网络后重试。',
                        onRetry: _reload,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

const _chatwayHtml = r'''
<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta
    name="viewport"
    content="width=device-width, initial-scale=1, viewport-fit=cover">
  <title>WebCal Support</title>
  <style>
    html,
    body {
      height: 100%;
      margin: 0;
      background: #f4f5f7;
      color: #121212;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    }

    .page {
      min-height: 100%;
      box-sizing: border-box;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px;
    }

    .card {
      width: min(100%, 340px);
      box-sizing: border-box;
      border: 1px solid #e2e5e0;
      border-radius: 16px;
      background: #ffffff;
      padding: 22px;
      text-align: center;
      box-shadow: 0 16px 36px rgba(18, 18, 18, 0.08);
    }

    .badge {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      min-height: 28px;
      border-radius: 999px;
      background: #9fe870;
      color: #163300;
      padding: 0 12px;
      font-size: 12px;
      font-weight: 800;
    }

    h1 {
      margin: 16px 0 8px;
      font-size: 20px;
      line-height: 1.25;
    }

    p {
      margin: 0;
      color: #666666;
      font-size: 14px;
      line-height: 1.55;
    }

    button {
      width: 100%;
      min-height: 48px;
      margin-top: 18px;
      border: 0;
      border-radius: 14px;
      background: #163300;
      color: #9fe870;
      font: inherit;
      font-size: 15px;
      font-weight: 800;
    }
  </style>
  <script>
    function chatwayApi() {
      if (typeof $chatway !== 'undefined') {
        return $chatway;
      }
      if (window.$chatway) {
        return window.$chatway;
      }
      return null;
    }

    function isChatwayOpen() {
      var container = document.querySelector('.chatway--container');
      return !!(
        container && container.classList.contains('widget--open')
      );
    }

    function forceOpenChatwayWidget() {
      var api = chatwayApi();
      if (api && typeof api.openChatwayWidget === 'function') {
        api.openChatwayWidget();
      }

      window.setTimeout(function() {
        if (isChatwayOpen()) {
          return;
        }

        var trigger = document.querySelector('#chatway_widget_trigger');
        var launcher =
          document.querySelector('.chatway-launcher') ||
          document.querySelector('.launcher-default-open-icon') ||
          document.querySelector('.launcher-icon');

        if (trigger && typeof trigger.click === 'function') {
          trigger.click();
        }
        if (!isChatwayOpen() && launcher && typeof launcher.click === 'function') {
          launcher.click();
        }
      }, 100);

      window.setTimeout(function() {
        if (isChatwayOpen()) {
          return;
        }

        var container = document.querySelector('.chatway--container');
        var frame = document.querySelector('.chatway--frame-container');
        if (container) {
          container.classList.remove('disable--widget');
          container.classList.remove('hide--widget');
          container.classList.add('widget--open');
          document.body.classList.add('chatway-is-open');
        }
        if (frame) {
          frame.classList.remove('chatway--preview--only--container');
          frame.classList.remove('chatway--quick--reply--container');
          frame.classList.add('chatway--chat--widget--container');
        }

        var iframe = document.getElementById('chatway_widget_app');
        if (iframe && typeof iframe.focus === 'function') {
          iframe.focus();
        }
      }, 300);

      return isChatwayOpen();
    }

    function openChatwayWhenReady(remaining) {
      if (forceOpenChatwayWidget()) {
        return;
      }
      if (remaining > 0) {
        window.setTimeout(function() {
          openChatwayWhenReady(remaining - 1);
        }, 250);
      }
    }

    window.$chatwayOnLoad = function() {
      openChatwayWhenReady(120);
    };

    function notifyChatwayError() {
      if (window.WebCalSupport) {
        window.WebCalSupport.postMessage('widget_load_failed');
      }
    }

    window.addEventListener('load', function() {
      openChatwayWhenReady(120);
    });

    document.addEventListener('chatwayLoaded', function() {
      openChatwayWhenReady(120);
    });
  </script>
</head>
<body>
  <main class="page" aria-label="WebCal 在线客服">
    <section class="card">
      <div class="badge">WebCal Support</div>
      <h1>正在打开客服聊天</h1>
      <p>点击在线客服后会自动展开聊天窗口。如未展开，请点击下方按钮。</p>
      <button type="button" onclick="openChatwayWhenReady(120)">
        打开客服
      </button>
    </section>
  </main>
  <script
    id="chatway"
    async
    onload="openChatwayWhenReady(120)"
    onerror="notifyChatwayError()"
    src="https://cdn.chatway.app/widget.js?id=w1imp1TIzXva">
  </script>
</body>
</html>
''';
