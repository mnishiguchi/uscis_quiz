import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:uscisquiz/models/models.dart';

part 'weather_theme_event.dart';
part 'weather_theme_state.dart';

class WeatherThemeBloc extends Bloc<ThemeEvent, WeatherThemeState> {
  WeatherThemeState get initialState => WeatherThemeState(
        theme: ThemeData.light(),
        color: Colors.lightBlue,
      );

  Stream<WeatherThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEventWeatherChanged) {
      yield _mapWeatherContidionToThemeData(event.weatherCondition);
    }
  }

  WeatherThemeState _mapWeatherContidionToThemeData(
      WeatherCondition weatherCondition) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return WeatherThemeState(
          theme: ThemeData(primaryColor: Colors.orangeAccent),
          color: Colors.yellow,
        );
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return WeatherThemeState(
          theme: ThemeData(primaryColor: Colors.lightBlueAccent),
          color: Colors.lightBlue,
        );
      case WeatherCondition.heavyCloud:
        return WeatherThemeState(
          theme: ThemeData(primaryColor: Colors.blueGrey),
          color: Colors.grey,
        );
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return WeatherThemeState(
          theme: ThemeData(primaryColor: Colors.indigoAccent),
          color: Colors.indigo,
        );
      case WeatherCondition.thunderstorm:
        return WeatherThemeState(
          theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
          color: Colors.deepPurple,
        );
      case WeatherCondition.unknown:
        return WeatherThemeState(
          theme: ThemeData.light(),
          color: Colors.lightBlue,
        );
      default:
        throw Exception('Invalid weather condition $weatherCondition');
    }
  }
}
