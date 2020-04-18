import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/repositories/repositories.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final uscisQuizRepository = UscisQuizRepository();

  runApp(
    // Global blocs
    MultiBlocProvider(
      providers: [
        BlocProvider<UscisQuizBloc>(
          create: (_) {
            // Instantiate the bloc and fetch the data.
            return UscisQuizBloc(uscisQuizRepository: uscisQuizRepository)
              ..add(UscisQuizEventFetch());
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      title: 'USCIS Civics Quiz',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: QuestionsPage.routeName,
      routes: {
        AboutPage.routeName: (_) => AboutPage(),
        BookmarkedQuestionsPage.routeName: (_) => BookmarkedQuestionsPage(),
        QuestionsPage.routeName: (_) => QuestionsPage(),
      },
    );
  }
}
