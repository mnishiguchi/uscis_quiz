import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/repositories/repositories.dart';

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
  }
}
