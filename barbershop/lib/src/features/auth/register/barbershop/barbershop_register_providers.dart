import 'package:barber_shop/src/core/providers/application_providers.dart';
import 'package:barber_shop/src/services/barbershop_register/barbershop_register_service.dart';
import 'package:barber_shop/src/services/barbershop_register/barbershop_register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "barbershop_register_providers.g.dart";

@Riverpod(keepAlive: true)
BarbershopRegisterService barbershopRegisterService(
        BarbershopRegisterServiceRef ref) =>
    BarbershopRegisterServiceImpl(
      restClient: ref.read(restClientProvider),
      barbershopRepository: ref.read(barbershopRepositoryProvider),
    );
