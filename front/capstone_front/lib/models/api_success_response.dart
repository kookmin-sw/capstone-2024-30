class ApiSuccessResponse {
  final String success;
  final String message;
  final Map<String, dynamic> response;

  ApiSuccessResponse({
    required this.success,
    required this.message,
    required this.response,
  });
}
