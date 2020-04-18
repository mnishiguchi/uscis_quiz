import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/widgets/widgets.dart';

// The default questions page.
class QuestionsPage extends StatelessWidget {
  static const routeName = '/questions';

  String pageTitle() => 'All Questions';

  List<UscisQuizQuestion> findQuestions(UscisQuizStateLoaded state) =>
      state.questions;

  @override
  Widget build(BuildContext context) {
    print('[$runtimeType] build');

    return BlocBuilder<UscisQuizBloc, UscisQuizState>(
      builder: (_, state) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text(pageTitle()),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.shuffle),
                onPressed: () => _shuffleQuestions(context),
              ),
            ],
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
      return _buildQuestions(context, findQuestions(state));
    }

    return Center(
      child: Text('Something went wrong'),
    );
  }

  Widget _buildQuestions(BuildContext context, List<UscisQuizQuestion> questions) {
    return QuestionList(
      questions: questions,
      onItemTap: (int questionId) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return QuestionPager(
              questions: questions,
              questionId: questionId,
            );
          }),
        );
      },
    );
  }

  void _shuffleQuestions(BuildContext context) {
    context.bloc<UscisQuizBloc>().add(UscisQuizEventShuffle());
  }
}
