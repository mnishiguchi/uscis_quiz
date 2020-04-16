import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';

class AnswerPageArgs {
  final int id;

  AnswerPageArgs({@required this.id});
}

class AnswerPage extends StatelessWidget {
  static const routeName = '/questions/:id/answer';

  @override
  Widget build(BuildContext context) {
    print('[AnswerPage] build');

    final AnswerPageArgs args = ModalRoute.of(context).settings.arguments;
    assert(args != null, "AnswerPageArgs is required");
    final id = args.id;

    // Assumption: Questions have already been loaded.
    final uscisQuizBloc = BlocProvider.of<UscisQuizBloc>(context);
    final questions = (uscisQuizBloc.state as UscisQuizStateLoaded).questions;
    final currentQuestion = questions.firstWhere((q) => q.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentQuestion.question),
      ),
      body: ListView(
        children: <Widget>[
          _buildQuestion(context, currentQuestion.question),
          _buildAnswer(context, currentQuestion.answer),
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String question) {
    return Container(
      padding: const EdgeInsets.only(
        top: 100.0,
        right: 20.0,
        bottom: 100.0,
        left: 20.0,
      ),
      decoration: const BoxDecoration(color: Colors.blue),
      child: Text(
        question,
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildAnswer(BuildContext context, List<String> answer) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        child: Column(
          children: answer
              .map(
                (answerEntry) => ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      answerEntry,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
