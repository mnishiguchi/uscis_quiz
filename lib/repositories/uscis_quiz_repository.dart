import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uscisquiz/models/models.dart';

class UscisQuizRepository {
  static const PREF_KEY_BOOKMARK_IDS = 'bookmarkedIds';

  UscisQuizRepository();

  Future<List<UscisQuizQuestion>> getUscisQuizQuestions() async {
    final String jsonString = await _loadQuestionsFromAsset();
    // https://dart.dev/guides/language/sound-problems#invalid-casts
    final List<Map> parsedJson = await json.decode(jsonString).cast<Map>();
    return UscisQuizQuestion.fromJsonList(parsedJson);
  }

  Future<String> _loadQuestionsFromAsset() async {
    try {
      return await rootBundle.loadString('assets/uscis_quiz_questions.json');
    } catch (error) {
      throw 'Error loading questions from asset: $error';
    }
  }

  Future<Set<int>> getBookmarkedIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedIds = prefs.getStringList(PREF_KEY_BOOKMARK_IDS);
    return Set<int>.from(
      bookmarkedIds.map((id) => int.parse(id)),
    );
  }

  void setBookmarkedIds(Set<dynamic> bookmarkedIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      PREF_KEY_BOOKMARK_IDS,
      List<String>.from(
        bookmarkedIds.map((id) => id.toString()),
      ),
    );
  }
}
