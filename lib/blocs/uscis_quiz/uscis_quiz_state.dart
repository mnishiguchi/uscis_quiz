part of 'uscis_quiz_bloc.dart';

@immutable
abstract class UscisQuizState extends Equatable {
  const UscisQuizState();

  @override
  List<Object> get props => [];
}

// Initial state.
class UscisQuizStateUninitialized extends UscisQuizState {}

// Occurs when something went wrong.
class UscisQuizStateError extends UscisQuizState {
  final dynamic error;

  const UscisQuizStateError({this.error});

  String toString() => 'UscisQuizStateError { error: ${error.toString()} }';
}

// Occurs once questions are loaded.
class UscisQuizStateLoaded extends UscisQuizState {
  final List<UscisQuizQuestion> questions;
  final Set<int> bookmarkedIds;

  const UscisQuizStateLoaded({
    @required this.questions,
    @required this.bookmarkedIds,
  })  : assert(questions != null),
        assert(bookmarkedIds != null);

  @override
  List<Object> get props => [questions, bookmarkedIds];

  String toString() =>
      'UscisQuizStateLoaded { questions: ${questions.length}, bookmarkedIds: ${bookmarkedIds?.length} }';

  // A utility that duplicates an instance with overrides.
  UscisQuizStateLoaded copyWith({
    List<UscisQuizQuestion> questions,
    Set<int> bookmarkedIds,
  }) {
    return UscisQuizStateLoaded(
      questions: questions ?? this.questions,
      bookmarkedIds: bookmarkedIds ?? this.bookmarkedIds,
    );
  }

  bool isBookmarked(int questionId) => bookmarkedIds.contains(questionId);
}
