import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/widgets/widgets.dart';

class QuestionsPage extends StatelessWidget {
  static const routeName = '/questions';

  @override
  Widget build(BuildContext context) {
    print('[QuestionsPage] build');

    return BlocBuilder<UscisQuizBloc, UscisQuizState>(
      builder: (_, state) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Questions'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () {
                  // TODO: Toggle bookmark filter.
                },
              )
            ],
          ),
          body: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, UscisQuizState state) {
    if (state is UscisQuizStateUninitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is UscisQuizStateLoaded) {
      return _buildQuestions(context, state);
    }

    return Center(
      child: Text('Something went wrong'),
    );
  }

  Widget _buildQuestions(BuildContext context, UscisQuizStateLoaded state) {
    final questions = state.questions;
    final Set<int> bookmarkedIds = state.bookmarkedIds ?? Set<int>();

    return QuestionList(
      questions: questions,
      bookmarkedIds: bookmarkedIds,
    );
  }
}
