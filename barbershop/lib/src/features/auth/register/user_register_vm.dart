import 'package:asyncstate/asyncstate.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/providers/application_providers.dart';
import 'package:barber_shop/src/features/auth/register/user_register_providers.dart';
import 'package:barber_shop/src/features/auth/register/user_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterState build() => UserRegisterState.initial();

  Future<void> registerUser(
      ({String email, String password, String name}) userData) async {
    final userRegisterService = ref.watch(userRegisterAdmServiceProvider);

    final resultRegister =
        await userRegisterService.execute(userData).asyncLoader();

    switch (resultRegister) {
      case Success():
        ref.invalidate(getMeProvider);
        state = state.copyWith(status: () => UserRegisterStateStatus.success);
      case Failure(:final exception):
        state = state.copyWith(
            status: () => UserRegisterStateStatus.error,
            errorMessage: () => exception.message);
    }
  }
}
