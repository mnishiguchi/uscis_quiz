part of 'settings_bloc.dart';

enum TemperatureUnits { f, c }

@immutable
class SettingsState extends Equatable {
  final TemperatureUnits temperatureUnit;

  const SettingsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  List<Object> get props => [temperatureUnit];

    @override
  String toString() =>
      'SettingsState { temperatureUnit: $temperatureUnit }';
}
