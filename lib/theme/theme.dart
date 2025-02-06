import 'package:flutter/material.dart';
import 'package:minimal_weather_app/utils/colors.dart';

// ################# LIGHT MODE #######################

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Bebas Neue',
  colorScheme: ColorScheme.light(
    surface: LightMode.background,
    onSurface: LightMode.foreground,
  ),

  // #### Icon Theme
  iconTheme: IconThemeData(
    color: LightMode.foreground,
    size: 22,
  ),

  // ##### Appbar Theme
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: LightMode.background,
    iconTheme: IconThemeData(
      color: LightMode.foreground,
      size: 20,
    ),
  ),

  // ##### Icon Button Theme
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        LightMode.foreground,
      ),
      iconSize: WidgetStatePropertyAll(20),
    ),
  ),
);

// ################# DARK MODE #######################

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Bebas Neue',
  colorScheme: ColorScheme.dark(
    surface: DarkMode.background,
    onSurface: DarkMode.foreground,
  ),

  // #### Icon Theme
  iconTheme: IconThemeData(
    color: DarkMode.foreground,
    size: 22,
  ),

  // ##### Appbar Theme
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: DarkMode.background,
    iconTheme: IconThemeData(
      color: DarkMode.foreground,
      size: 20,
    ),
  ),

  // ##### Icon Button Theme
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        DarkMode.foreground,
      ),
      iconSize: WidgetStatePropertyAll(20),
    ),
  ),
);
