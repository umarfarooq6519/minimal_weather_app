import 'package:flutter/material.dart';
import 'package:minimal_weather_app/pages/weather_page.dart';
import 'package:minimal_weather_app/utils/colors.dart';

// TODO: Add more weather animations
// TODO: Add slide from top animation to refresh
// TODO: Add dark and light mode

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bebas Neue',

        // ##### Theme Data
        scaffoldBackgroundColor: DarkMode.background,
        iconTheme: _iconTheme(),
        textTheme: _textTheme(),
        iconButtonTheme: _iconBtnTheme(),
        appBarTheme: _appBarTheme(),
      ),

      // ##### HomePage
      home: WeatherPage(),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme().copyWith(
      backgroundColor: DarkMode.background,
    );
  }

  IconButtonThemeData _iconBtnTheme() {
    return IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(DarkMode.foreground),
        iconSize: WidgetStatePropertyAll(26),
      ),
    );
  }

  IconThemeData _iconTheme() {
    return IconThemeData(
      color: DarkMode.foreground,
    );
  }

  TextTheme _textTheme() {
    return TextTheme().copyWith(
      displayLarge: TextStyle(color: DarkMode.foreground),
      headlineMedium: TextStyle(color: DarkMode.foreground),
      titleLarge: TextStyle(color: DarkMode.foreground),
    );
  }
}
