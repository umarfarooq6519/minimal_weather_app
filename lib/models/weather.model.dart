class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double humidity;
  final double wind;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      wind: json['wind']['speed'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
