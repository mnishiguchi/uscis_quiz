import 'package:equatable/equatable.dart';

class UscisQuizQuestion extends Equatable {
  final int id;
  final String question;
  // The data type is List<dynamic> because of the persed json's data type.
  final List<dynamic> answer;

  UscisQuizQuestion({
    this.id,
    this.question,
    this.answer,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'UscisQuizQuestion { id: $id }';

  // Creates an instance from the API response JSON.
  static UscisQuizQuestion fromJson(dynamic json) {
    return UscisQuizQuestion(
      id: json['id'] as int,
      question: json['question'],
      answer: json['answer'],
    );
  }
}
