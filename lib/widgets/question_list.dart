import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/pages/pages.dart';

// A list view of UscisQuizQuestions. Requires UscisQuizBloc through context.
class QuestionList extends StatelessWidget {
  final List<UscisQuizQuestion> questions;
  final Set<int> bookmarkedIds;

  QuestionList({
    Key key,
    @required this.questions,
    @required this.bookmarkedIds,
  })  : assert(questions != null),
        assert(bookmarkedIds != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        // Find next suggestion index ignoring dividers.
        // 0,1,2,3,4,5, ... => 0,0,1,1,2,2,...
        final questionIndex = i ~/ 2;
        final currentQuestion = questions[questionIndex];
        final isBookmarked = bookmarkedIds.contains(currentQuestion.id);

        return _buildRow(context, currentQuestion, isBookmarked);
      },
      itemCount: questions.length * 2,
    );
  }

  Widget _buildRow(
    BuildContext context,
    UscisQuizQuestion question,
    bool isBookmarked,
  ) {
    return ListTile(
      title: Text(question.question),
      trailing: InkWell(
        child: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        ),
        onTap: () {
          isBookmarked
              ? _removeBookmark(context, question.id)
              : _addBookmark(context, question.id);
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          QuestionPage.routeName,
          arguments: QuestionPageArgs(id: question.id),
        );
      },
    );
  }

  void _addBookmark(BuildContext context, int id) {
    context.bloc<UscisQuizBloc>().add(
          UscisQuizEventAddBookmark(questionId: id),
        );
  }

  void _removeBookmark(BuildContext context, int id) {
    context.bloc<UscisQuizBloc>().add(
          UscisQuizEventRemoveBookmark(questionId: id),
        );
  }
}
