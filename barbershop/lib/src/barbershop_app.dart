import 'package:asyncstate/asyncstate.dart';
import 'package:barber_shop/src/core/ui/barbershop_theme.dart';
import 'package:barber_shop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber_shop/src/features/auth/login/login_page.dart';
import 'package:barber_shop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarberShopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: "DW BarberShop",
          theme: BarberShopTheme.theme,
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            "/": (_) => const SplashPage(),
            "/auth/login": (_) => const LoginPage(),
            "/home/adm": (_) => const Text('adm'),
            "/home/employee": (_) => const Text('employee'),
          },
        );
      },
    );
  }
}
