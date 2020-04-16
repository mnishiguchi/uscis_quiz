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
    yield UscisQuizStateLoaded(questions: questions);
  }

  Stream<UscisQuizState> _onBookmarkAdded(
    UscisQuizStateLoaded state,
    int questionId,
  ) async* {
    yield state.copyWith(
      bookmarkedIds: _createBookmarkIdsFromState(state)..add(questionId),
    );
  }

  Stream<UscisQuizState> _onBookmarkRemoved(
    UscisQuizStateLoaded state,
    int questionId,
  ) async* {
    yield state.copyWith(
      bookmarkedIds: _createBookmarkIdsFromState(state)..remove(questionId),
    );
  }

  // Create a new instance so that the bloc will trigger the transition.
  Set<int> _createBookmarkIdsFromState(UscisQuizStateLoaded state) {
    return state.bookmarkedIds == null
        ? Set<int>()
        : Set.from(state.bookmarkedIds);
  }
}
