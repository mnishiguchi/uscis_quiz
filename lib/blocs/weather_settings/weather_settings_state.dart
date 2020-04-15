part of 'weather_settings_bloc.dart';

enum TemperatureUnits { f, c }

@immutable
class WeatherSettingsState extends Equatable {
  final TemperatureUnits temperatureUnit;

  const WeatherSettingsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  List<Object> get props => [temperatureUnit];

    @override
  String toString() =>
      'WeatherSettingsState { temperatureUnit: $temperatureUnit }';
}
