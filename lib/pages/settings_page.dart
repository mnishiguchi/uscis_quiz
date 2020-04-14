import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    print('[SettingsPage] build');

    return Scaffold(
      appBar: AppBar(title: Text('SettingsPage')),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return _buildTemperatureUnitListTile(
                context,
                state.temperatureUnit,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureUnitListTile(
    BuildContext context,
    TemperatureUnits temperatureUnit,
  ) {
    return ListTile(
      title: Text('Temperature Units'),
      isThreeLine: true,
      subtitle: Text('Use metric measurements for temperature units.'),
      trailing: Switch(
        value: temperatureUnit == TemperatureUnits.c,
        onChanged: (_) => _toggleTemperatureUnit(context),
      ),
    );
  }

  void _toggleTemperatureUnit(BuildContext context) {
    BlocProvider.of<SettingsBloc>(context)
        .add(SettingsEventTemperatureUnitsToggled());
  }
}
