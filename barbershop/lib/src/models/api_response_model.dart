class ApiResponseModel {
  final Object? data;
  final int statusCode;
  final String statusMessage;
  final String? accessToken;
  final String? refreshToken;
  final String type;

  ApiResponseModel({
    this.data,
    this.accessToken,
    this.refreshToken,
    required this.statusCode,
    required this.statusMessage,
    required this.type,
  });

  factory ApiResponseModel.fromJson(Object json) {
    return switch (json) {
      {
        'data': final Object? data,
        'status_code': final int statusCode,
        'status_message': final String statusMessage,
        'access_token': final String? accessToken,
        'refresh_token': final String? refreshToken,
        'type': final String type,
      } =>
        ApiResponseModel(
          data: data,
          statusCode: statusCode,
          statusMessage: statusMessage,
          accessToken: accessToken,
          refreshToken: refreshToken,
          type: type,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
