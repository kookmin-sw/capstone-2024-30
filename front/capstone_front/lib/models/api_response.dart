class ApiResponse {
  final String success;
  final String? message;
  final Map<String, dynamic> response;

  ApiResponse({
    required this.success,
    required this.message,
    required this.response,
  });
}
