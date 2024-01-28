import 'package:barber_shop/src/core/exceptions/auth_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
