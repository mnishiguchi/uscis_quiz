part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {}

class SettingsEventTemperatureUnitsToggled extends SettingsEvent {
  @override
  List<Object> get props => [];
}
