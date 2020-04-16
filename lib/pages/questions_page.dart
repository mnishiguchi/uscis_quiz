import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/pages/pages.dart';
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
          AnswerPage.routeName,
          arguments: AnswerPageArgs(id: question.id),
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
