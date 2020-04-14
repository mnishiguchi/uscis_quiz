import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState =>
      SettingsState(temperatureUnit: TemperatureUnits.c);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsEventTemperatureUnitsToggled) {
      yield SettingsState(
        temperatureUnit: state.temperatureUnit == TemperatureUnits.c
            ? TemperatureUnits.f
            : TemperatureUnits.c,
      );
    }
  }
}
