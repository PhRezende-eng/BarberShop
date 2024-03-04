import 'package:barber_shop/src/core/constants/local_storage_keys.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  // before make request
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = LocalStorageKeys.authHeaderKey;
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}',
      });
    }

    handler.next(options);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.response?.data) {
      case ("token_expired" || "token_invalid"):
        final sp = await SharedPreferences.getInstance();
        sp.remove(LocalStorageKeys.accessToken);
      default:
    }

    handler.next(err);
    super.onError(err, handler);
  }
}
