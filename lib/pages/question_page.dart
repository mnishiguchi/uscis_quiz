import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart' show Linkify;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/widgets/widgets.dart';

class QuestionPageArgs {
  final int id;

  QuestionPageArgs({
    @required this.id,
  }) : assert(id != null);
}

class QuestionPage extends StatelessWidget {
  static const routeName = '/questions/:id';

  List<UscisQuizQuestion> findQuestions(BuildContext context) {
    return (BlocProvider.of<UscisQuizBloc>(context).state
            as UscisQuizStateLoaded)
        .questions;
  }

  void navigateSelf(BuildContext context, int id) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: QuestionPageArgs(
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuestionPageArgs args = ModalRoute.of(context).settings.arguments;
    assert(args != null, "QuestionPageArgs is required");

    final questions = findQuestions(context);
    final indexLookup = _findIndices(questions, args.id);
    final currentQuestion = questions[indexLookup['current']];
    final previousQuestion = questions[indexLookup['previous']];
    final nextQuestion = questions[indexLookup['next']];

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
      bottomNavigationBar: _buildBottomNavigationBar(
        context,
        questions,
        previousQuestion.id,
        nextQuestion.id,
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

  Widget _buildBottomNavigationBar(
    BuildContext context,
    List<UscisQuizQuestion> questions,
    int previousQuestionId,
    int nextQuestionId,
  ) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_back_ios),
          title: Text('Previous'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward_ios),
          title: Text('Next'),
        ),
      ],
      selectedItemColor: Colors.grey[600],
      unselectedItemColor: Colors.grey[600],
      onTap: (id) {
        id == 0
            ? navigateSelf(context, previousQuestionId)
            : navigateSelf(context, nextQuestionId);
      },
    );
  }

  Map<String, int> _findIndices(
    List<UscisQuizQuestion> questions,
    int currentId,
  ) {
    final current =
        questions.lastIndexWhere((question) => question.id == currentId);
    final last = questions.length - 1;
    final previous =
        questions.length > 1 ? (current == 0 ? last : current - 1) : current;
    final next =
        questions.length > 1 ? (current == last ? 0 : current + 1) : current;
    return Map()
      ..['last'] = last
      ..['current'] = current
      ..['previous'] = previous
      ..['next'] = next;
  }
}
