class APIEndpoints {
  // final String baseUrl = "https://api.evoucher.my/api-v1/";
  // static const String baseUrl = "http://192.168.137.1:8000/api-v1/";
  static const String baseUrl = "http://10.10.18.213:8000/api-v1/";
  static const String login = "${baseUrl}login/";
  static const String logout = "${baseUrl}logout/";
  static const String stats = "${baseUrl}stats/";
  static const String creditWallet = "${baseUrl}credit-wallet/";
  static const String debitWallet = "${baseUrl}debit-wallet/";
  static const String events = "${baseUrl}cud-event/";
  static const String vouchers = "${baseUrl}cud-voucher/";
  static const String allEvents = "${baseUrl}all-events/";
  static const String allVouchers = "${baseUrl}all-vouchers/";
}
