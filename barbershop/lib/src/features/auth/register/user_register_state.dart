import 'package:flutter/material.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

class UserRegisterState {
  final UserRegisterStateStatus status;
  final String? errorMessage;
  UserRegisterState.initial() : this(status: UserRegisterStateStatus.initial);

  UserRegisterState({
    required this.status,
    this.errorMessage,
  });

  UserRegisterState copyWith({
    ValueGetter<UserRegisterStateStatus>? status,
    ValueGetter<String?>? errorMessage,
  }) =>
      UserRegisterState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );
}
