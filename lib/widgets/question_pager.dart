import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart' show Linkify;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/widgets/widgets.dart';

class QuestionPager extends StatelessWidget {
  final List<UscisQuizQuestion> questions;
  final int questionId;

  QuestionPager({@required this.questionId, @required this.questions})
      : assert(questions != null),
        assert(questionId != null);

  @override
  Widget build(BuildContext context) {
    final questionIndex =
        questions.lastIndexWhere((question) => question.id == questionId);

    final pageController = PageController(
      initialPage: questionIndex,
    );

    return PageView(
      controller: pageController,
      children: questions
          .map((question) => QuestionPagerItem(question: question))
          .toList(),
    );
  }
}

class QuestionPagerItem extends StatelessWidget {
  final UscisQuizQuestion question;

  QuestionPagerItem({@required this.question}) : assert(question != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UscisQuizBloc, UscisQuizState>(
      builder: (context, state) {
        final isBookmarked =
            (state as UscisQuizStateLoaded).isBookmarked(question.id);

        return Scaffold(
          appBar: AppBar(
            title: Text('Question #${question.id}'),
            actions: <Widget>[
              IconButton(
                color: Colors.grey[100],
                icon:
                    Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () => _toggleBookmark(context, question.id),
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              _buildQuestion(context, question.question),
              _buildAnswerList(context, question.answer),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestion(BuildContext context, String question) {
    final Color backgroundColor = Theme.of(context).primaryColorDark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 200.0,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          question,
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.grey[100]),
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

  void _toggleBookmark(BuildContext context, int id) {
    context
        .bloc<UscisQuizBloc>()
        .add(UscisQuizEventToggleBookmark(questionId: id));
  }
}
