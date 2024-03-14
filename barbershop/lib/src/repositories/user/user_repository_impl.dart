import 'dart:developer';
import 'dart:io';

import 'package:barber_shop/src/core/exceptions/auth_exception.dart';
import 'package:barber_shop/src/core/exceptions/repository_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/fp/nil.dart';
import 'package:barber_shop/src/core/rest_client/rest_client.dart';
import 'package:barber_shop/src/models/user_model.dart';
import 'package:barber_shop/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;
  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      if (data['status_message'] == 'Success') {
        return Success(UserModel.fromJson(data["data"]));
      } else {
        final apiMessage = data["data"];
        return Failure(
          RepositoryException(message: apiMessage ?? "Error ao realizar login"),
        );
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:data) = e.response!;
        final apiMessage = data["data"];
        log(apiMessage, stackTrace: s);
        return Failure(
          RepositoryException(message: apiMessage ?? "Erro ao buscar usuário"),
        );
      }
      log("Erro ao buscar usuário", stackTrace: s);
      return Failure(
          RepositoryException(message: e.message ?? "Erro ao buscar usuário"));
    } on ArgumentError catch (e, s) {
      log("Invalid json", stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String name, String password, String email}) dataUser) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': dataUser.name,
        'password': dataUser.password,
        'email': dataUser.email,
        'profile': 'A',
      });
      return Success(nil);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:data) = e.response!;
        final apiMessage = data["data"];
        log(apiMessage, stackTrace: s);
        return Failure(
          RepositoryException(
              message: apiMessage ?? "Error ao cadastrar usuário"),
        );
      }
      log("Error ao cadastrar usuário", stackTrace: s);
      return Failure(RepositoryException(
          message: e.message ?? "Error ao cadastrar usuário"));
    }
  }

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post(
        '/auth',
        data: {
          "email": email,
          "password": password,
        },
      );

      if (data['status_message'] == 'Success') {
        return Success(data["access_token"]);
      } else {
        final apiMessage = data["data"];
        return Failure(
          AuthError(message: apiMessage ?? "Error ao realizar login"),
        );
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode, :data) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log("Login ou senha inválidos", stackTrace: s);
          return Failure(AuthUnathorizedException());
        } else {
          final apiMessage = data["data"];
          log(apiMessage, stackTrace: s);
          return Failure(
            AuthError(message: apiMessage ?? "Error ao realizar login"),
          );
        }
      }
      log("Error ao realizar login", stackTrace: s);
      return Failure(
        AuthError(message: e.message ?? "Error ao realizar login"),
      );
    }
  }
}
