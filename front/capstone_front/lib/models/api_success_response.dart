class ApiSuccessResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> response;

  ApiSuccessResponse({
    required this.success,
    required this.message,
    required this.response,
  });

  ApiSuccessResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool,
        message = json['message'] as String,
        response = json['response'];
}
