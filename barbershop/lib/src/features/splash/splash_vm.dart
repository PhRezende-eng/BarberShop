import 'package:barber_shop/src/core/constants/local_storage_keys.dart';
import 'package:barber_shop/src/core/providers/application_providers.dart';
import 'package:barber_shop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part "splash_vm.g.dart";

enum SplashState {
  login,
  loggedEmployee,
  loggedADM,
  initial,
}

@riverpod
class SplashVM extends _$SplashVM {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey(LocalStorageKeys.accessToken)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);

      try {
        final userModel = await ref.watch(getMeProvider.future);
        return switch (userModel) {
          UserModelEmployee() => SplashState.loggedEmployee,
          UserModelADM() => SplashState.loggedADM,
        };
      } catch (e) {
        return SplashState.login;
      }
    }

    return SplashState.initial;
  }
}
