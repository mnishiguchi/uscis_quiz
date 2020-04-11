import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/home_page.dart';
import './pages/counter_page.dart';

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
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        CounterPage.routeName: (context) => CounterPage(title: 'USCIS Quiz Counter Page'),
      },
    );
  }
}
