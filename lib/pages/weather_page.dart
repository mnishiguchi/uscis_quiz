import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
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
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    print('[WeatherPage] build');

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherEventFetch(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          // Perform side-effects.
          listener: (context, weatherState) {
            if (weatherState is WeatherStateLoaded) {
              _completeRefreshCompleter();
            }
          },
          // Rebuild the UI.
          builder: (context, weatherState) {
            if (weatherState is WeatherStateEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (weatherState is WeatherStateLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (weatherState is WeatherStateLoaded) {
              return RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<WeatherBloc>(context).add(
                      WeatherEventRefresh(city: weatherState.weather.location));
                  return _refreshCompleter.future;
                },
                child: _buildWeatherListView(weatherState.weather),
              );
            }
            if (weatherState is WeatherStateError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            throw Exception('Invalid weather state $weatherState');
          },
        ),
      ),
    );
  }

  void _completeRefreshCompleter() {
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
            child: CombinedWeatherTemperature(
              weather: weather,
            ),
          ),
        ),
      ],
    );
  }
}
