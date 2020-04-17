import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/widgets/widgets.dart';

// The default questions page.
class QuestionsPage extends StatelessWidget {
  static const routeName = '/questions';

  String pageTitle() => 'All Questions';

  @override
  Widget build(BuildContext context) {
    print('[$runtimeType] build');

    return BlocBuilder<UscisQuizBloc, UscisQuizState>(
      builder: (_, state) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text(pageTitle()),
            actions: <Widget>[],
          ),
          body: buildBody(context, state),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, UscisQuizState state) {
    if (state is UscisQuizStateUninitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is UscisQuizStateLoaded) {
      return buildQuestions(context, state);
    }

    return Center(
      child: Text('Something went wrong'),
    );
  }

  Widget buildQuestions(BuildContext context, UscisQuizStateLoaded state) {
    return QuestionList(
      questions: state.questions,
      onItemTap: (int questionId) {
        Navigator.pushNamed(
          context,
          QuestionPage.routeName,
          arguments: QuestionPageArgs(id: questionId),
        );
      },
    );
  }
}
