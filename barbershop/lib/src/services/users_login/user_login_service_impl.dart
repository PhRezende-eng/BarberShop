import 'package:barber_shop/src/core/constants/local_storage_keys.dart';
import 'package:barber_shop/src/core/exceptions/auth_exception.dart';
import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/fp/nil.dart';
import 'package:barber_shop/src/repositories/user/user_repository.dart';
import 'package:barber_shop/src/services/users_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;
  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        await sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() => Failure(ServiceException(message: exception.message)),
          AuthUnathorizedException() =>
            Failure(ServiceException(message: exception.message)),
        };
    }
  }
}
