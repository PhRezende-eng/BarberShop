import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/fp/nil.dart';

abstract interface class BarbershopRegisterService {
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        List<String> weekDays,
        List<String> hours,
      }) barbershopData);
}
