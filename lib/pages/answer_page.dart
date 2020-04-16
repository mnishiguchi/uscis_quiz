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
      padding: EdgeInsets.only(top: 100.0, left: 5.0, right: 5.0),
      child: Text(
        question,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnswer(BuildContext context, List<dynamic> answer) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              answer[index],
              style: TextStyle(
                fontSize: 24,
                // fontWeight: FontWeight.w200,
              ),
            ),
          );
        },
        itemCount: answer.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    );
  }
}
