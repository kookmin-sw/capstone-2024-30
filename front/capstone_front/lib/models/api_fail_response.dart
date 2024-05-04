class ApiFailResponse {
  final bool success;
  final String message;

  ApiFailResponse({
    required this.success,
    required this.message,
  });

  ApiFailResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool,
        message = json['message'] as String;
}
