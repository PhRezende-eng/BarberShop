import 'package:barber_shop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class BarberShopTheme {
  static const OutlineInputBorder _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: ColorsConstants.grey),
  );
  static ThemeData get theme => ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: ColorsConstants.grey),
          border: _defaultInputBorder,
          enabledBorder: _defaultInputBorder,
          focusedBorder: _defaultInputBorder,
          errorBorder: _defaultInputBorder.copyWith(
            borderSide: const BorderSide(color: ColorsConstants.red),
          ),
        ),
        fontFamily: FontConstants.fontFamily,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: ColorsConstants.brown,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );
}
