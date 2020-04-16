import 'package:equatable/equatable.dart';

class UscisQuizQuestion extends Equatable {
  final int id;
  final String question;
  final List<String> answer;

  UscisQuizQuestion({
    this.id,
    this.question,
    this.answer,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'UscisQuizQuestion { id: $id }';

  static List<UscisQuizQuestion> fromJsonList(List<Map> jsonList) {
    return jsonList.map(UscisQuizQuestion.fromJson).toList();
  }

  // Creates an instance from the API response JSON.
  static UscisQuizQuestion fromJson(Map jsonObject) {
    return UscisQuizQuestion(
      id: jsonObject['id'] as int,
      question: jsonObject['question'] as String,
      // Create a new instance because type 'List<dynamic>' is not a subtype of
      // type 'List<String>'.
      // https://dart.dev/guides/language/sound-problems#invalid-casts
      answer: (jsonObject['answer'] as List).cast<String>(),
    );
  }
}
