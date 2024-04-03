import 'package:asyncstate/asyncstate.dart';
import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_providers.dart';
import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "barbershop_register_vm.g.dart";

@Riverpod()
class BarbershopRegisterVM extends _$BarbershopRegisterVM {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  Future<void> createBarbershop(
      ({
        String name,
        String email,
        Iterable<String?> weekDays,
        Iterable<int?> hours,
      }) barbershopData) async {
    final List<String> weekDays = [];
    final List<int> hours = [];

    for (var day in barbershopData.weekDays) {
      if (day != null) weekDays.add(day);
    }
    for (var hour in barbershopData.hours) {
      if (hour != null) hours.add(hour);
    }

    final barbershopRegisterService =
        ref.read(barbershopRegisterServiceProvider);

    final response = await barbershopRegisterService.execute((
      email: barbershopData.email,
      name: barbershopData.name,
      weekDays: weekDays,
      hours: hours
    )).asyncLoader();

    switch (response) {
      case Success():
        state =
            BarbershopRegisterState(status: BarbershopRegisterStatus.success);
      case Failure(exception: ServiceException(message: final message)):
        state = BarbershopRegisterState(
            status: BarbershopRegisterStatus.error, errorMessage: message);
    }
  }
}
