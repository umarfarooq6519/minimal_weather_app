import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather.model.dart';
import 'package:minimal_weather_app/services/weather.service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService =
      Weatherservice(apiKey: '4f603bfd14a0494c7463d2bbfcf12ad9');
  Weather? _weather;

  // fetch weather
  fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animations
  String _getWeatherAnimation(String? mainCondition) {
    // default to sunny
    if (mainCondition == null) return 'assets/animations/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/animations/cloudy.json';

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animations/mist.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animations/rainy.json';

      case 'thunderstorm':
        return 'assets/animations/thunder.json';

      case 'clear':
        return 'assets/animations/sunny.json';

      default:
        return 'assets/animations/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Icon(Icons.location_on),
            Text(_weather?.cityName ?? "Loading City..."),

            // animation
            Lottie.asset(_getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text('${_weather?.temperature.round().toString()}C'),

            // condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
