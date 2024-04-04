import 'package:asyncstate/asyncstate.dart';
import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_providers.dart';
import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "barbershop_register_vm.g.dart";

@riverpod
class BarbershopRegisterVM extends _$BarbershopRegisterVM {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  final hours = [
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
  ];

  void addOrRemoveWeekDay(String day) {
    final selectedDays = state.selectedDays;
    if (selectedDays[day] == null) {
      selectedDays[day] = day;
    } else {
      selectedDays[day] = null;
    }

    state = state.copyWith(selectedDays: () => selectedDays);
  }

  void addOrRemoveHour(String hour) {
    final selectedHours = state.selectedHours;

    if (selectedHours[hour] == null) {
      final intValue = int.parse(hour.split(':')[0]);
      selectedHours[hour] = intValue;
    } else {
      selectedHours[hour] = null;
    }

    state = state.copyWith(selectedHours: () => selectedHours);
  }

  List<String> getValidDays() {
    final List<String> weekDays = [];

    for (var day in state.selectedDays.values) {
      if (day != null) weekDays.add(day);
    }

    return weekDays;
  }

  List<int> getValidHours() {
    final List<int> hours = [];

    for (var hour in state.selectedHours.values) {
      if (hour != null) hours.add(hour);
    }

    return hours;
  }

  Future<void> createBarbershop(
    String name,
    String email,
  ) async {
    final barbershopRegisterService =
        ref.read(barbershopRegisterServiceProvider);

    final dto = (
      name: name,
      email: email,
      hours: getValidHours(),
      weekDays: getValidDays(),
    );

    final response = await barbershopRegisterService.execute(dto).asyncLoader();

    switch (response) {
      case Success():
        state = state.copyWith(status: () => BarbershopRegisterStatus.success);
      case Failure(exception: ServiceException(message: final message)):
        state = state.copyWith(
            status: () => BarbershopRegisterStatus.error,
            errorMessage: () => message);
    }
  }
}
