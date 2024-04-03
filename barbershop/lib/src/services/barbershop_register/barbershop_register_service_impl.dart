import 'package:barber_shop/src/core/exceptions/service_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/fp/nil.dart';
import 'package:barber_shop/src/core/rest_client/rest_client.dart';
import 'package:barber_shop/src/repositories/barbershop/barbershop_repositoy.dart';
import 'package:barber_shop/src/services/barbershop_register/barbershop_register_service.dart';

class BarbershopRegisterServiceImpl implements BarbershopRegisterService {
  final RestClient restClient;
  final BarbershopRepository barbershopRepository;
  BarbershopRegisterServiceImpl(
      {required this.restClient, required this.barbershopRepository});

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        List<String> weekDays,
        List<int> hours,
      }) barbershopData) async {
    final response =
        await barbershopRepository.createMyBarbershop(barbershopData);

    return switch (response) {
      Success() => Success(nil),
      Failure(:final exception) =>
        Failure(ServiceException(message: exception.message)),
    };
  }
}
