part of 'uscis_quiz_bloc.dart';

@immutable
abstract class UscisQuizState extends Equatable {
  const UscisQuizState();

  @override
  List<Object> get props => [];
}

class UscisQuizStateUninitialized extends UscisQuizState {}

class UscisQuizStateLoading extends UscisQuizState {}

class UscisQuizStateLoaded extends UscisQuizState {
  final List<UscisQuizQuestion> questions;

  const UscisQuizStateLoaded({@required this.questions})
      : assert(questions != null);

  @override
  List<Object> get props => [questions];

  String toString() =>
      'UscisQuizStateLoaded { questions: ${questions.length} }';
}

class UscisQuizStateError extends UscisQuizState {
  final dynamic error;

  const UscisQuizStateError({this.error});

  String toString() => 'UscisQuizStateError { error: ${error.toString()} }';
}
