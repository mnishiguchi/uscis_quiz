import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/counter_bloc.dart';

class CounterPage extends StatelessWidget {
  static const routeName = '/counter';

  CounterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    print('[CounterPage] build');

    // https://github.com/felangel/bloc/issues/587
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<CounterBloc, int>(builder: (context, count) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$count',
                style: Theme.of(context).textTheme.display1,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      counterBloc.add(CounterEvent.decrement);
                    },
                    child: Text('-'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      counterBloc.add(CounterEvent.increment);
                    },
                    child: Text('+'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterBloc.add(CounterEvent.increment);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
