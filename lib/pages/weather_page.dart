import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/widgets/widgets.dart';

// This is stateful because it needs to maintain a completer.
class WeatherPage extends StatefulWidget {
  static const routeName = '/weather';

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Completer<void> _refreshCompleter;

  void initState() {
    super.initState();
    // In order to use the RefreshIndicator we had to create a Completer which
    // allows us to produce a Future which we can complete at a later time.
    _initRefreshCompleter();
  }

  @override
  Widget build(BuildContext context) {
    print('[WeatherPage] build');

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              // Navigate to the city selectiton and return the selected value.
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelectionForm(),
                ),
              );
              if (city == null) return;
              _loadWeather(context, city);
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          // Perform side-effects.
          listener: (context, weatherState) {
            if (weatherState is WeatherStateLoaded) {
              _updateWeatherTheme(context, weatherState.weather.condition);
              _initRefreshCompleter();
            }
          },
          // Rebuild the UI.
          builder: (_, weatherState) {
            switch (weatherState.runtimeType) {
              case (WeatherStateEmpty):
                return Center(child: Text('Please Select a Location'));
              case (WeatherStateLoading):
                return Center(child: CircularProgressIndicator());
              case (WeatherStateLoaded):
                final weather = (weatherState as WeatherStateLoaded).weather;
                return BlocBuilder<WeatherThemeBloc, WeatherThemeState>(
                  builder: (_, weatherThemeState) {
                    return GradientContainer(
                      color: weatherThemeState.color,
                      child: RefreshIndicator(
                        onRefresh: () {
                          _updateWeather(context, weather.location);
                          return _refreshCompleter.future;
                        },
                        child: _buildWeatherListView(weather),
                      ),
                    );
                  },
                );
              case (WeatherStateError):
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              default:
                throw Exception('Invalid weather state $weatherState');
            }
          },
        ),
      ),
    );
  }

  void _loadWeather(BuildContext context, String city) {
    BlocProvider.of<WeatherBloc>(context).add(WeatherEventFetch(city: city));
  }

  void _updateWeather(BuildContext context, String city) {
    BlocProvider.of<WeatherBloc>(context).add(WeatherEventRefresh(city: city));
  }

  void _updateWeatherTheme(
      BuildContext context, WeatherCondition weatherCondition) {
    BlocProvider.of<WeatherThemeBloc>(context).add(
      ThemeEventWeatherChanged(weatherCondition: weatherCondition),
    );
  }

  void _initRefreshCompleter() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer<void>();
  }

  Widget _buildWeatherListView(weather) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Center(
            child: Location(location: weather.location),
          ),
        ),
        Center(
          child: LastUpdated(dateTime: weather.lastUpdated),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Center(
            child: CombinedWeatherInfo(weather: weather),
          ),
        ),
      ],
    );
  }
}
