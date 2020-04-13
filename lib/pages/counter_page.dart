import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';

class CounterPage extends StatelessWidget {
  static const routeName = '/counter';

  @override
  Widget build(BuildContext context) {
    print('[CounterPage] build');

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
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
                      BlocProvider.of<CounterBloc>(context)
                          .add(CounterEvent.decrement);
                    },
                    child: Text('-'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context)
                          .add(CounterEvent.increment);
                    },
                    child: Text('+'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.add),
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.remove),
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
