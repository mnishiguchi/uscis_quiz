import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';

class BookmarkedQuestionsPage extends QuestionsPage {
  static const routeName = '/bookmarked_questions';

  @override
  String pageTitle() => 'Bookmarked Questions';

  @override
    List<UscisQuizQuestion> findQuestions(UscisQuizStateLoaded state) =>
      state.getBookmarkedQuestions();
}
