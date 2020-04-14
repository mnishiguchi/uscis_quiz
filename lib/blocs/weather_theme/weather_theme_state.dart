part of 'weather_theme_bloc.dart';

class WeatherThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  const WeatherThemeState({
    @required this.theme,
    @required this.color,
  })  : assert(theme != null),
        assert(color != null);

  List<Object> get props => [theme, color];
}
