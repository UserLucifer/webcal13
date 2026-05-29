class Env {
  static const _webCalApiBaseUrl = String.fromEnvironment(
    'WEB_CAL_API_BASE_URL',
  );
  static const _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static const apiBaseUrl = _webCalApiBaseUrl != ''
      ? _webCalApiBaseUrl
      : _apiBaseUrl != ''
      ? _apiBaseUrl
      : 'http://10.0.2.2:8080';
}
