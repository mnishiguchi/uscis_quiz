import 'package:flutter/material.dart';

import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/widgets/widgets.dart';

class BookmarkedQuestionsPage extends QuestionsPage {
  static const routeName = '/bookmarked_questions';

  @override
  String pageTitle() => 'Bookmarked Questions';

  @override
  Widget buildQuestions(BuildContext context, UscisQuizStateLoaded state) {
    return QuestionList(
      questions: state.getBookmarkedQuestions(),
      onItemTap: (int questionId) {
        Navigator.pushNamed(
          context,
          BookmarkedQuestionPage.routeName,
          arguments: BookmarkedQuestionPageArgs(id: questionId),
        );
      },
    );
  }
}
