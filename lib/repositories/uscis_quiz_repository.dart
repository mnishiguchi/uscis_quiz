import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

import 'package:uscisquiz/models/models.dart';

class UscisQuizRepository {
  UscisQuizRepository();

  Future<List<UscisQuizQuestion>> getUscisQuizQuestions() async {
    final String jsonString = await _loadAsset();
    final List<dynamic> parsedJson = await json.decode(jsonString);

    try {
      return parsedJson.map(UscisQuizQuestion.fromJson).toList();
    } catch (error) {
      throw Exception('Error parsing questions json: $error');
    }
  }

  Future<String> _loadAsset() async {
    try {
      return await rootBundle.loadString('assets/uscis_quiz_questions.json');
    } catch (error) {
      throw Exception('Error loading questions asset: $error');
    }
  }
}
