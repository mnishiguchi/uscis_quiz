import 'dart:convert' show jsonDecode;
import 'package:meta/meta.dart' show required;
import 'package:http/http.dart' as http;

import 'package:uscisquiz/models/models.dart' show Weather;

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<int> fetchLocationId(String city) async {
    final response =
        await this.httpClient.get('$baseUrl/api/location/search/?query=$city');
    if (response.statusCode != 200) {
      throw Exception('Error fetching  location id for city');
    }
    final locationJson = jsonDecode(response.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final response =
        await this.httpClient.get('$baseUrl/api/location/$locationId');
    if (response.statusCode != 200) {
      throw Exception('Error fetching  weather for location $locationId');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }
}
