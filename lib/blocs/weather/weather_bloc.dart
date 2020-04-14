import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/repositories/repositories.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherStateEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherEventFetch) {
      yield WeatherStateLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherStateLoaded(weather: weather);
      } catch (_) {
        yield WeatherStateError();
      }
    }
    if (event is WeatherEventRefresh) {
      yield WeatherStateLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherStateLoaded(weather: weather);
      } catch (_) {
        yield state;
      }
    }
  }
}
