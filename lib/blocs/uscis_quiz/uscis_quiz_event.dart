part of 'uscis_quiz_bloc.dart';

@immutable
abstract class UscisQuizEvent extends Equatable {
  const UscisQuizEvent();

  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UscisQuizEventFetch extends UscisQuizEvent {}

class UscisQuizEventShuffle extends UscisQuizEvent {}

class UscisQuizEventAddBookmark extends UscisQuizEvent {
  final int questionId;

  const UscisQuizEventAddBookmark({@required this.questionId})
      : assert(questionId != null);

  @override
  List<Object> get props => [questionId];
}

class UscisQuizEventRemoveBookmark extends UscisQuizEvent {
  final int questionId;

  const UscisQuizEventRemoveBookmark({@required this.questionId})
      : assert(questionId != null);

  @override
  List<Object> get props => [questionId];
}
