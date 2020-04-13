import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventFetch extends WeatherEvent {
  final String city;

  const WeatherEventFetch({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
