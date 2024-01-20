import 'package:asyncstate/asyncstate.dart';
import 'package:barber_shop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_shop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BSBarberShopApp extends StatelessWidget {
  const BSBarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarberShopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: "DW BarberShop",
          navigatorObservers: [asyncNavigatorObserver],
          routes: {"/": (_) => const BSSplashPage()},
        );
      },
    );
  }
}
