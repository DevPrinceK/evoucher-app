class APIEndpoints {
  // final String baseUrl = "https://api.evoucher.my/api-v1/";
  static const String baseUrl = "http://192.168.137.1:8000/api-v1/";
  static const String login = "${baseUrl}login/";
  static const String logout = "${baseUrl}logout/";
  static const String stats = "${baseUrl}stats/";
  final String events = "all-events";
}
