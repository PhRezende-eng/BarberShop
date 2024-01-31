import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  }) : assert(
          status == LoginStateStatus.error && errorMessage == null,
        );

  LoginState copyWith({
    ValueGetter<LoginStateStatus>? status,
    ValueGetter<String?>? errorMessage,
  }) =>
      LoginState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );
}
