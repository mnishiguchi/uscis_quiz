import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/repositories/repositories.dart';

part 'uscis_quiz_event.dart';
part 'uscis_quiz_state.dart';

class UscisQuizBloc extends Bloc<UscisQuizEvent, UscisQuizState> {
  final UscisQuizRepository uscisQuizRepository;

  UscisQuizBloc({@required this.uscisQuizRepository});

  @override
  UscisQuizState get initialState => UscisQuizStateUninitialized();

  @override
  Stream<UscisQuizState> mapEventToState(UscisQuizEvent event) async* {
    try {
      if (event is UscisQuizEventFetch) {
        // Currently we fetch only once.
        if (state is! UscisQuizStateUninitialized) return;
        yield* _onFetchQuestions();
      }
      if (event is UscisQuizEventShuffle) {
        if (state is! UscisQuizStateLoaded) return;
        yield* _onShuffleQuestions(state);
      }
      if (event is UscisQuizEventToggleBookmark) {
        if (state is! UscisQuizStateLoaded) return;
        yield* _onToggleBookmark(state, event.questionId);
      }
    } catch (error) {
      yield UscisQuizStateError(error: error);
    }
  }

  Stream<UscisQuizState> _onFetchQuestions() async* {
    final List<UscisQuizQuestion> questions =
        await uscisQuizRepository.getUscisQuizQuestions();
    final Set<int> bookmarkedIds = await uscisQuizRepository.getBookmarkedIds();
    yield UscisQuizStateLoaded(
      questions: questions,
      bookmarkedIds: bookmarkedIds,
    );
  }

  Stream<UscisQuizState> _onShuffleQuestions(
    UscisQuizStateLoaded state,
  ) async* {
    // Note: Duplicate the list first because state is immutable.
    final duplicatedQuestions = List<UscisQuizQuestion>.from(state.questions);
    yield state.copyWith(
      questions: duplicatedQuestions..shuffle(),
    );
  }

  Stream<UscisQuizState> _onToggleBookmark(
    UscisQuizStateLoaded state,
    int questionId,
  ) async* {
    final Set<int> bookmarkedIds = (state.isBookmarked(questionId))
        ? (Set<int>.from(state.bookmarkedIds)..remove(questionId))
        : (Set<int>.from(state.bookmarkedIds)..add(questionId));
    uscisQuizRepository.saveBookmarkedIds(bookmarkedIds);
    yield state.copyWith(
      bookmarkedIds: bookmarkedIds,
    );
  }
}
