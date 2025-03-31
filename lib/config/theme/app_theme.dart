
import 'package:flutter/material.dart';

class AppTheme {

  static const Color seedColor = Color(0xFF002147);

  /// 🌞 Tema claro
  ThemeData get getLightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),// fondo claro
  );

  /// 🌙 Tema oscuro
  ThemeData get getDarkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: seedColor, // fondo azul oscuro
    bottomAppBarTheme: const BottomAppBarTheme(
      color: seedColor,
      surfaceTintColor: Colors.black,
      shadowColor: Colors.white
    ),
    appBarTheme: const AppBarTheme(
      color: seedColor,
    )
  );
}