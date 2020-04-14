part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventFetch extends WeatherEvent {
  final String city;

  const WeatherEventFetch({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String city;

  const WeatherEventRefresh({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
