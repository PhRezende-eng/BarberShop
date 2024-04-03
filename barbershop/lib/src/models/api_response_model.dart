class ApiResponseModel {
  final Object data;
  final int statusCode;
  final String statusMessage;
  final String? accessToken;
  final String? refreshToken;
  final String? type;

  ApiResponseModel({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
    this.accessToken,
    this.refreshToken,
    this.type,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'data': final Object data,
        'status_code': final int statusCode,
        'status_message': final String statusMessage,
      } =>
        ApiResponseModel(
          data: data,
          statusCode: statusCode,
          statusMessage: statusMessage,
          accessToken: json["access_token"],
          refreshToken: json["refresh_token"],
          type: json["type"],
        ),
      _ => throw ArgumentError('Invalid ApiResponseModel Json'),
    };
  }
}
