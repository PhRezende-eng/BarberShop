import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/fp/nil.dart';
import 'package:barber_shop/src/services/barbershop_register/barbershop_register_service.dart';

class BarbershopRegisterServiceImpl implements BarbershopRegisterService {
  @override
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        List<String> weekDays,
        List<String> hours,
      }) barbershopData) async {
    return Failure(ServiceException(message: ''));
  }
}
