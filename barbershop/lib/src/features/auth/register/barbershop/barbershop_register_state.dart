import 'package:flutter/material.dart';

enum BarbershopRegisterStatus {
  initial,
  error,
  success,
}

class BarbershopRegisterState {
  final String? errorMessage;
  final BarbershopRegisterStatus status;
  final Map<String, String?> selectedDays;
  final Map<String, int?> selectedHours;

  BarbershopRegisterState.initial()
      : this(
            status: BarbershopRegisterStatus.initial,
            selectedDays: {},
            selectedHours: {});

  BarbershopRegisterState({
    this.errorMessage,
    required this.status,
    required this.selectedDays,
    required this.selectedHours,
  });

  BarbershopRegisterState copyWith({
    ValueGetter<BarbershopRegisterStatus>? status,
    ValueGetter<String?>? errorMessage,
    ValueGetter<Map<String, String?>>? selectedDays,
    ValueGetter<Map<String, int?>>? selectedHours,
  }) =>
      BarbershopRegisterState(
        status: status != null ? status() : this.status,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
        selectedDays: selectedDays != null ? selectedDays() : this.selectedDays,
        selectedHours:
            selectedHours != null ? selectedHours() : this.selectedHours,
      );
}
