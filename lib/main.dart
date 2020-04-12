import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/rendering.dart';

import 'package:uscisquiz/pages/home_page.dart';
import 'package:uscisquiz/pages/counter_page.dart';
import 'package:uscisquiz/pages/random_words_page.dart';
import 'package:uscisquiz/blocs/counter_bloc.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      title: 'USCIS Quiz',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.white,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        CounterPage.routeName: (context) => BlocProvider<CounterBloc>(
              create: (context) => CounterBloc(),
              child: CounterPage(title: 'USCIS Quiz Counter Page'),
            ),
        RandomWordsPage.routeName: (context) => RandomWordsPage(),
      },
    );
  }
}
