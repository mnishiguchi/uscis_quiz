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
      body: BlocBuilder<UscisQuizBloc, UscisQuizState>(
        builder: (_, uscisQuizState) {
          return _buildContent(context, uscisQuizState);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, UscisQuizState state) {
    if (state is UscisQuizStateUninitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is UscisQuizStateLoaded) {
      return _buildQuestions(context, state.questions);
    }

    return Center(
      child: Text('Something went wrong'),
    );
  }

  Widget _buildQuestions(
    BuildContext context,
    List<UscisQuizQuestion> questions,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        // Find next suggestion index ignoring dividers.
        // 0,1,2,3,4,5, ... => 0,0,1,1,2,2,...
        final questionIndex = i ~/ 2;

        return _buildRow(context, questions[questionIndex]);
      },
      itemCount: questions.length * 2,
    );
  }

  Widget _buildRow(
    BuildContext context,
    UscisQuizQuestion question,
  ) {
    return ListTile(
      title: Text(question.question),
      trailing: Icon(
        Icons.bookmark_border,
        // TODO: Implement the bookmark functionality.
        // question.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          AnswerPage.routeName,
          arguments: AnswerPageArgs(id: question.id),
        );
      },
      onLongPress: () {
        // TODO:: Toggle bookmark.
        print('long pressed');
      },
    );
  }
}
