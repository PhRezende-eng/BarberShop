import 'package:asyncstate/asyncstate.dart';
import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/providers/application_providers.dart';
import 'package:barber_shop/src/features/auth/login/login_state.dart';
import 'package:barber_shop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "login_vm.g.dart";

@riverpod
class LoginVM extends _$LoginVM {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        final user = await ref.read(getMeProvider.future);
        switch (user) {
          case UserModelADM():
            state = state.copyWith(status: () => LoginStateStatus.admLogin);
          case UserModelEmployee():
            state =
                state.copyWith(status: () => LoginStateStatus.employeeLogin);
        }
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: () => LoginStateStatus.error,
          errorMessage: () => message,
        );
    }

    loaderHandler.close();
  }
}
