import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minimal_weather_app/pages/weather_page.dart';
import 'package:minimal_weather_app/theme/theme.provider.dart';

// TODO: Add more weather animations

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ##### Theme Data
      theme: Provider.of<ThemeProvider>(context).themeData,

      // ##### HomePage
      home: WeatherPage(),
    );
  }
}
