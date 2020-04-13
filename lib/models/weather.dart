import 'package:equatable/equatable.dart' show Equatable;

// All our possible weather conditions.
enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  const Weather({
    this.condition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.locationId,
    this.created,
    this.lastUpdated,
    this.location,
  });

  @override
  List<Object> get props => [
        condition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location,
      ];

  // Creates an instance from the API response JSON.
  static Weather fromJson(dynamic json) {
    final todaysWeather = json['consolidated_weather'][0];
    return Weather(
      condition: _mapStringToWeatherCondition(
          todaysWeather['weather_state_abbr']),
      formattedCondition: todaysWeather['weather_state_name'],
      minTemp: todaysWeather['min_temp'] as double,
      temp: todaysWeather['the_temp'] as double,
      maxTemp: todaysWeather['max_temp'] as double,
      locationId: json['woeid'] as int,
      created: todaysWeather['created'],
      lastUpdated: DateTime.now(),
      location: json['title'],
    );
  }

  // Maps the raw weather state string to a WeatherCondition.
  static WeatherCondition _mapStringToWeatherCondition(String input) {
    switch (input) {
      case 'sn':
        return WeatherCondition.snow;
      case 'sl':
        return WeatherCondition.sleet;
      case 'h':
        return WeatherCondition.hail;
      case 't':
        return WeatherCondition.thunderstorm;
      case 'hr':
        return WeatherCondition.heavyRain;
      case 'lr':
        return WeatherCondition.lightRain;
      case 's':
        return WeatherCondition.showers;
      case 'hc':
        return WeatherCondition.heavyCloud;
      case 'lc':
        return WeatherCondition.lightCloud;
      case 'c':
        return WeatherCondition.clear;
      default:
        return WeatherCondition.unknown;
    }
  }
}
