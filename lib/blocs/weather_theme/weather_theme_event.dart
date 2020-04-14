part of 'weather_theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;

  const ThemeEventWeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null);

  @override
  List<Object> get props => [weatherCondition];
}
