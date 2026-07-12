import 'dart:convert';

class ApiLogger {
  static void showResponse({
    required String url,
    dynamic request,
    dynamic response,
    bool enabled = false,
  }) {
    if (!enabled) return;

    final encoder = const JsonEncoder.withIndent("  ");

    print("""

================ API RESPONSE ================

URL:
$url


REQUEST:
${_pretty(request)}


STATUS:
${response?.statusCode}


BODY:
${_pretty(response?.data)}


================================================

""");
  }

  static String _pretty(dynamic data) {
    try {
      return const JsonEncoder.withIndent("  ").convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
