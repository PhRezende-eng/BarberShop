import 'package:barber_shop/src/core/constants/local_storage_keys.dart';
import 'package:barber_shop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

    if (extra case {'DIO_AUTH_KEY': true}) {
      switch (response?.data) {
        case ("token_expired" || "token_invalid"):
          final sp = await SharedPreferences.getInstance();
          sp.remove(LocalStorageKeys.accessToken);
          Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
              .pushNamedAndRemoveUntil('/auth/login', (route) => false);
        default:
      }

      // if (response != null && response.statusCode == HttpStatus.forbidden) {
      //   final sp = await SharedPreferences.getInstance();
      //   sp.remove(LocalStorageKeys.accessToken);
      //   Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
      //       .pushNamedAndRemoveUntil('/auth/login', (route) => false);
      // }
    }

    handler.reject(err);
    super.onError(err, handler);
  }
}
