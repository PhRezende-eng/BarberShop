import 'package:barber_shop/src/core/exceptions/repository_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/models/barbershop_model.dart';
import 'package:barber_shop/src/models/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
  Future<Either<RepositoryException, BarbershopModel>> createMyBarbershop(
      ({
        String name,
        String email,
        List<String> weekDays,
        List<String> hours
      }) barbershopData);
}
