class ApiFailResponse {
  final bool success;
  final String message;
  final String code;

  ApiFailResponse({
    required this.success,
    required this.message,
    required this.code,
  });

  ApiFailResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool,
        message = json['message'] as String,
        code = json['code'] as String;
}
