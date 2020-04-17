import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/pages/pages.dart';

class BookmarkedQuestionPageArgs extends QuestionPageArgs {
  final int id;

  BookmarkedQuestionPageArgs({@required this.id}) : super(id: id);
}

class BookmarkedQuestionPage extends QuestionPage {
  static const routeName = '/bookmarked_questions/:id';

  List<UscisQuizQuestion> findQuestions(BuildContext context) {
    final state =
        (BlocProvider.of<UscisQuizBloc>(context).state as UscisQuizStateLoaded);
    return state.questions
        .where((question) => state.bookmarkedIds.contains(question.id))
        .toList();
  }

  void navigateSelf(BuildContext context, int id) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: BookmarkedQuestionPageArgs(
        id: id,
      ),
    );
  }
}
