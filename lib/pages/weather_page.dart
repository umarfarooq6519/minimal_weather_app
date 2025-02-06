import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:minimal_weather_app/helpers/date.helper.dart';
import 'package:minimal_weather_app/models/weather.model.dart';
import 'package:minimal_weather_app/services/weather.service.dart';
import 'package:minimal_weather_app/theme/theme.dart';
import 'package:minimal_weather_app/theme/theme.provider.dart';
import 'package:provider/provider.dart';

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

  // fetch weather from weather service
  Future<void> _fetchWeather() async {
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
      body: LiquidPullToRefresh(
        // fetch weather again on pull to refresh
        onRefresh: _fetchWeather,
        color: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        springAnimationDurationInMilliseconds: 300,
        child: _body(context),
      ),
    );
  }

  SingleChildScrollView _body(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ##### city name

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

                SizedBox(height: 70),

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
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
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
                '${_weather?.wind.round().toString()} m/s',
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 4),
            Text(
              _weather?.cityName ?? "Loading City...",
              style:
                  Theme.of(context).textTheme.titleMedium!.copyWith(height: 0),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Provider.of<ThemeProvider>(context).themeData == lightMode
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
          ),
        ),
      ],
    );
  }
}
