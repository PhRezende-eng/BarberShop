import 'package:barber_shop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "barbershop_register_vm.g.dart";

@Riverpod()
class BarbershopRegisterVM extends _$BarbershopRegisterVM {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  Future<void> createBarbershop(
      ({String name, String email}) barbershopData) async {
    print('Send request');
  }
}
