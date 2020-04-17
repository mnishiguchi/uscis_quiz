import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/repositories/repositories.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final blogPostRepository = BlogPostRepository(
      blogPostClient: BlogPostApiClient(httpClient: http.Client()));

  final uscisQuizRepository = UscisQuizRepository();

  runApp(
    // Global blocs
    MultiBlocProvider(
      providers: [
        BlocProvider<BlogPostBloc>(
          // Instantiate the bloc and fetch the initial batch.
          create: (_) {
            return BlogPostBloc(blogPostRepository: blogPostRepository)
              ..add(BlogPostEventFetch());
          },
        ),
        BlocProvider<CounterBloc>(
          create: (_) => CounterBloc(),
        ),
        BlocProvider<WeatherSettingsBloc>(
          create: (_) => WeatherSettingsBloc(),
        ),
        BlocProvider<WeatherThemeBloc>(
          create: (_) => WeatherThemeBloc(),
        ),
        BlocProvider<UscisQuizBloc>(
          create: (_) {
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
  final weatherRepository = WeatherRepository(
    weatherClient: WeatherApiClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherThemeBloc, WeatherThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          // debugShowMaterialGrid: true,
          title: 'USCIS Quiz',
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: Colors.grey[100],
          ),

          initialRoute: QuestionsPage.routeName,
          routes: {
            QuestionsPage.routeName: (_) => QuestionsPage(),
            QuestionPage.routeName: (_) => QuestionPage(),
            CounterPage.routeName: (_) => CounterPage(),
            RandomWordsPage.routeName: (_) => RandomWordsPage(),
            BlogPostsPage.routeName: (_) => BlogPostsPage(),
            WeatherSettingsPage.routeName: (_) => WeatherSettingsPage(),
            WeatherPage.routeName: (_) {
              // This bloc only exists as long as the page is displayed.
              return BlocProvider(
                create: (_) =>
                    WeatherBloc(weatherRepository: weatherRepository),
                child: WeatherPage(),
              );
            }
          },
        );
      },
    );
  }
}
