import 'package:flutter/material.dart';

enum BarbershopRegisterStatus {
  initial,
  error,
  success,
}

class BarbershopRegisterState {
  final String? errorMessage;
  final BarbershopRegisterStatus status;

  BarbershopRegisterState.initial()
      : this(status: BarbershopRegisterStatus.initial);

  BarbershopRegisterState({this.errorMessage, required this.status});

  BarbershopRegisterState copyWith(
    ValueGetter<BarbershopRegisterStatus>? status,
    ValueGetter<String?>? errorMessage,
  ) =>
      BarbershopRegisterState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );
}
