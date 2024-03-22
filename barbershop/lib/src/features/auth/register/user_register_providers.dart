import 'package:barber_shop/src/core/providers/application_providers.dart';
import 'package:barber_shop/src/services/user_register/user_register_adm_service.dart';
import 'package:barber_shop/src/services/user_register/user_register_adm_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "user_register_providers.g.dart";

@Riverpod(keepAlive: true)
UserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) =>
    UserRegisterAdmServiceImpl(
      userLoginService: ref.read(userLoginServiceProvider),
      userRepository: ref.read(userRepositoryProvider),
    );
