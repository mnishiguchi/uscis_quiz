import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart' show Linkify;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/widgets/widgets.dart';

class QuestionPageArgs {
  final int id;

  QuestionPageArgs({@required this.id});
}

class QuestionPage extends StatelessWidget {
  static const routeName = '/questions/:id';

  @override
  Widget build(BuildContext context) {
    print('[QuestionPage] build');

    final QuestionPageArgs args = ModalRoute.of(context).settings.arguments;
    assert(args != null, "QuestionPageArgs is required");
    final id = args.id;

    // Assumption: Questions have already been loaded.
    final uscisQuizBloc = BlocProvider.of<UscisQuizBloc>(context);
    final questions = (uscisQuizBloc.state as UscisQuizStateLoaded).questions;
    final currentQuestion = questions.firstWhere((q) => q.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Question #${currentQuestion.id}'),
      ),
      body: ListView(
        children: <Widget>[
          _buildQuestion(currentQuestion.question),
          _buildAnswerList(currentQuestion.answer),
        ],
      ),
    );
  }

  Widget _buildQuestion(String question) {
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

  Widget _buildAnswerList(List<String> answer) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: VisibilityToggle(
        summary: Text("Answers"),
        child: Card(
          child: Column(
            children: answer.map(_buildAnswerListTile).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerListTile(String answerEntry) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Linkify(
          text: answerEntry,
          style: TextStyle(
            fontSize: 20,
          ),
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
        ),
      ),
    );
  }
}
