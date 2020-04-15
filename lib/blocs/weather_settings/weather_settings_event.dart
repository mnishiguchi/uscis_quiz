part of 'weather_settings_bloc.dart';

@immutable
abstract class WeatherSettingsEvent extends Equatable {}

class WeatherSettingsEventTemperatureUnitsToggled extends WeatherSettingsEvent {
  @override
  List<Object> get props => [];
}
