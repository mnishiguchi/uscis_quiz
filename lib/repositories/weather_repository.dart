import 'dart:async' show Future;
import 'package:meta/meta.dart' show required;

import 'package:uscisquiz/models/models.dart' show Weather;
import 'package:uscisquiz/repositories/weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherClient;

  WeatherRepository({@required this.weatherClient})
      : assert(weatherClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherClient.fetchLocationId(city);
    return weatherClient.fetchWeather(locationId);
  }
}
