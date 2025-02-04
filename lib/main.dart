import 'package:flutter/material.dart';
import 'package:minimal_weather_app/pages/weather_page.dart';
import 'package:minimal_weather_app/utils/colors.dart';

// TODO: Add Bebas Neue font and adjust UI
// TODO: Add more weather animations

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
        scaffoldBackgroundColor: DarkMode.background,
        iconTheme: IconThemeData(
          color: DarkMode.foreground,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: DarkMode.foreground,
              displayColor: DarkMode.foreground,
            ),
      ),
      home: WeatherPage(),
    );
  }
}
