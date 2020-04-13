import 'package:flutter/material.dart';

import 'package:uscisquiz/models/models.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return Image.asset('assets/clear.png');
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return Image.asset('assets/snow.png');
      case WeatherCondition.heavyCloud:
        return Image.asset('assets/cloudy.png');
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return Image.asset('assets/rainy.png');
      case WeatherCondition.thunderstorm:
        return Image.asset('assets/thunderstorm.png');
      case WeatherCondition.unknown:
        return Image.asset('assets/clear.png');
      default:
        throw Exception('Invalid weather condition $condition');
    }
  }
}
