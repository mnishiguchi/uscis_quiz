import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/widgets/widgets.dart';

class WeatherPage extends StatelessWidget {
  static const routeName = '/weather';

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
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, weatherState) {
            if (weatherState is WeatherStateEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (weatherState is WeatherStateLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (weatherState is WeatherStateLoaded) {
              final weather = weatherState.weather;

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
}
