String friendlyErrorMessage(Object? error, {int maxLength = 120}) {
  final raw = error?.toString().trim() ?? '';
  if (raw.isEmpty) {
    return '请求暂时没有返回有效结果，请稍后重试。';
  }
  var text = raw
      .replaceFirst(RegExp(r'^Exception:\s*'), '')
      .replaceFirst(RegExp(r'^ApiException:\s*'), '')
      .replaceFirst(RegExp(r'^DioException\s*\[[^\]]+\]:\s*'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  final lowerText = text.toLowerCase();
  if (lowerText.contains('connection refused') ||
      lowerText.contains('connection errored') ||
      lowerText.contains('socketexception')) {
    text = '网络连接异常，请检查网络后重试。';
  } else if (lowerText.contains('timeout') || lowerText.contains('timed out')) {
    text = '网络连接超时，请稍后重试。';
  }
  if (text.length > maxLength) {
    text = '${text.substring(0, maxLength)}...';
  }
  return text.isEmpty ? '请求失败，请稍后重试。' : text;
}
