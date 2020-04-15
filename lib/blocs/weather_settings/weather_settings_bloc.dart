import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_settings_event.dart';
part 'weather_settings_state.dart';

class WeatherSettingsBloc extends Bloc<WeatherSettingsEvent, WeatherSettingsState> {
  @override
  WeatherSettingsState get initialState =>
      WeatherSettingsState(temperatureUnit: TemperatureUnits.c);

  @override
  Stream<WeatherSettingsState> mapEventToState(WeatherSettingsEvent event) async* {
    if (event is WeatherSettingsEventTemperatureUnitsToggled) {
      yield* _onTemperatureUnitsToggled(event);
    }
  }

  Stream<WeatherSettingsState> _onTemperatureUnitsToggled(
      WeatherSettingsEventTemperatureUnitsToggled event) async* {
    yield WeatherSettingsState(
      temperatureUnit: state.temperatureUnit == TemperatureUnits.c
          ? TemperatureUnits.f
          : TemperatureUnits.c,
    );
  }
}
