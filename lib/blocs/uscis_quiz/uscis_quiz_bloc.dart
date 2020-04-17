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
        if (state is! UscisQuizStateUninitialized) return;
        yield* _onFetchQuestions();
      }
      if (event is UscisQuizEventAddBookmark) {
        yield* _onBookmarkAdded(state, event.questionId);
      }
      if (event is UscisQuizEventRemoveBookmark) {
        yield* _onBookmarkRemoved(state, event.questionId);
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

  Stream<UscisQuizState> _onBookmarkAdded(
    UscisQuizStateLoaded state,
    int questionId,
  ) async* {
    final bookmarkedIds = _createBookmarkIdsFromState(state)..add(questionId);
    uscisQuizRepository.setBookmarkedIds(bookmarkedIds);
    yield state.copyWith(
      bookmarkedIds: bookmarkedIds,
    );
  }

  Stream<UscisQuizState> _onBookmarkRemoved(
    UscisQuizStateLoaded state,
    int questionId,
  ) async* {
    final bookmarkedIds = _createBookmarkIdsFromState(state)
      ..remove(questionId);
    uscisQuizRepository.setBookmarkedIds(bookmarkedIds);
    yield state.copyWith(
      bookmarkedIds: bookmarkedIds,
    );
  }

  // Create a new instance so that the bloc will trigger the transition.
  Set<int> _createBookmarkIdsFromState(UscisQuizStateLoaded state) {
    return state.bookmarkedIds == null
        ? Set<int>()
        : Set.from(state.bookmarkedIds);
  }
}
