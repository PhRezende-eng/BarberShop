import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/rest_client/rest_client.dart';
import 'package:barber_shop/src/models/barbershop_model.dart';
import 'package:barber_shop/src/models/user_model.dart';
import 'package:barber_shop/src/repositories/barbershop/barbershop_repositoy.dart';
import 'package:barber_shop/src/repositories/barbershop/barbershop_repositoy_impl.dart';
import 'package:barber_shop/src/repositories/user/user_repository.dart';
import 'package:barber_shop/src/repositories/user/user_repository_impl.dart';
import 'package:barber_shop/src/services/users_login/user_login_service.dart';
import 'package:barber_shop/src/services/users_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "application_providers.g.dart";

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(
      restClient: ref.watch(restClientProvider),
    );

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(
      userRepository: ref.watch(userRepositoryProvider),
    );

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final result =
      await ref.watch(barbershopRepositoryProvider).getMyBarbershop(userModel);

  return switch (result) {
    Success(value: final barbershopModel) => barbershopModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}
