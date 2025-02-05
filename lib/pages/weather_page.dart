import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/helpers/date.helper.dart';
import 'package:minimal_weather_app/models/weather.model.dart';
import 'package:minimal_weather_app/services/weather.service.dart';
import 'package:minimal_weather_app/utils/colors.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService =
      WeatherService(apiKey: '4f603bfd14a0494c7463d2bbfcf12ad9');
  Weather? _weather;
  String? _currentDate;

  // fetch weather
  _fetchWeather() async {
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
    _fetchWeather();
    _currentDate = formattedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #### Appbar
      appBar: _appBar(context),

      // ##### Body
      body: _body(context),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ##### city name
            Column(
              children: [
                Icon(Icons.location_on),
                SizedBox(height: 4),
                Text(
                  _weather?.cityName ?? "Loading City...",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            // ##### animation
            Lottie.asset(
              _getWeatherAnimation(_weather?.mainCondition),
            ),

            // ##### temperature
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${_weather?.temperature.round().toString()}°',
                  style: Theme.of(context).textTheme.displayLarge,
                ),

                // condition
                Text(
                  _weather?.mainCondition ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                SizedBox(height: 40),

                _additionalWeatherInfo(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _additionalWeatherInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.water_drop_rounded),
                SizedBox(width: 4),
                Text(
                  'Humid',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                '${_weather?.humidity.round().toString()}%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
          child: VerticalDivider(
            width: 40,
            thickness: 1,
            color: DarkMode.foreground.withValues(alpha: 0.2),
          ),
        ),
        // SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.air_rounded),
                SizedBox(width: 4),
                Text(
                  'Wind',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                '${_weather?.wind.round().toString()}m/s',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: Column(
          children: [
            Text(
              _currentDate ?? "",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 14),
          child: IconButton(
            onPressed: _fetchWeather,
            icon: Icon(Icons.refresh_rounded),
          ),
        ),
      ],
    );
  }
}
