import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';

// A list view of UscisQuizQuestions. Requires UscisQuizBloc through context.
class QuestionList extends StatelessWidget {
  final List<UscisQuizQuestion> questions;
  final Function onItemTap;

  QuestionList({
    Key key,
    @required this.questions,
    @required this.onItemTap,
  })  : assert(questions != null),
        assert(onItemTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (questions.length == 0) {
      return Center(
        child: Text('No item found'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final currentQuestion = questions[index];
        final isBookmarked = _isBookmarked(context, currentQuestion.id);
        return _buildRow(context, currentQuestion, isBookmarked);
      },
      itemCount: questions.length,
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
        onTap: () => _toggleBookmark(context, question.id),
      ),
      onTap: () => onItemTap(question.id),
    );
  }

  void _toggleBookmark(BuildContext context, int id) {
    context
        .bloc<UscisQuizBloc>()
        .add(UscisQuizEventToggleBookmark(questionId: id));
  }

  bool _isBookmarked(BuildContext context, int id) =>
      (context.bloc<UscisQuizBloc>().state as UscisQuizStateLoaded)
          .isBookmarked(id);
}
