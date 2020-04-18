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

    // When an item is unbookmarked, the current item will be nonexistent.
    if (indexLookup['current'].isNegative) {
      return Container();
    }

    final currentQuestion = questions[indexLookup['current']];
    final previousQuestion = questions[indexLookup['previous']];
    final nextQuestion = questions[indexLookup['next']];

    print('[$runtimeType] $indexLookup');

    return BlocBuilder<UscisQuizBloc, UscisQuizState>(
      builder: (context, state) {
        final isBookmarked =
            (state as UscisQuizStateLoaded).isBookmarked(args.id);

        return Scaffold(
          appBar: AppBar(
            title: Text('Question #${currentQuestion.id}'),
            actions: <Widget>[
              IconButton(
                color: Colors.grey[100],
                icon:
                    Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () async {
                  isBookmarked
                      ? _removeBookmark(context, currentQuestion.id)
                      : _addBookmark(context, currentQuestion.id);
                },
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              _buildQuestion(context, currentQuestion.question),
              _buildAnswerList(context, currentQuestion.answer),
            ],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(
            context,
            questions,
            previousQuestion.id,
            nextQuestion.id,
          ),
        );
      },
    );
  }

  Widget _buildQuestion(BuildContext context, String question) {
    final Color backgroundColor = Theme.of(context).primaryColorDark;
    return Container(
      padding: const EdgeInsets.only(
        top: 80.0,
        right: 20.0,
        bottom: 80.0,
        left: 20.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Text(
        question,
        style: Theme.of(context).textTheme.headline.copyWith(
              color: Colors.grey[100],
            ),
      ),
    );
  }

  Widget _buildAnswerList(BuildContext context, List<String> answerList) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: VisibilityToggle(
        summary: Text("Answers"),
        child: Card(
          child: Column(
            children: answerList
                .map((answerEntry) => _buildAnswerListTile(
                      context,
                      answerEntry,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerListTile(BuildContext context, String answerEntry) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Linkify(
          text: answerEntry,
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 20.0),
          onOpen: (link) async {
            if (await canLaunch(link.url)) await launch(link.url);
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

    // When an item is unbookmarked, the current item will be nonexistent.
    return current >= 0
        ? (Map()
          ..['previous'] = previous
          ..['current'] = current
          ..['next'] = next)
        : (Map()
          ..['previous'] = -1
          ..['current'] = -1
          ..['next'] = -1);
  }

  void _addBookmark(BuildContext context, int id) {
    context
        .bloc<UscisQuizBloc>()
        .add(UscisQuizEventAddBookmark(questionId: id));
  }

  void _removeBookmark(BuildContext context, int id) {
    context
        .bloc<UscisQuizBloc>()
        .add(UscisQuizEventRemoveBookmark(questionId: id));
  }
}
