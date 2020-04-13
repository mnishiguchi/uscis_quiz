import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:uscisquiz/models/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

// Occurs when the user has not yet selected a city.
class WeatherStateEmpty extends WeatherState {}

// Occurs while we are fetching the weather for a given city.
class WeatherStateLoading extends WeatherState {}

// Occurs if we were able to successfully fetch weather for a given city.
class WeatherStateLoaded extends WeatherState {
  final Weather weather;

  const WeatherStateLoaded({@required this.weather}): assert(weather != null);

  @override
  List<Object> get props => [weather];
}

// Occurs if we were unable to fetch weather for a given city.
class WeatherStateError extends WeatherState {}
