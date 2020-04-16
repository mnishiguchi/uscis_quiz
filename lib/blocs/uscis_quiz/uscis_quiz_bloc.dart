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
    if (event is UscisQuizEventFetch) {
      yield* _onFetch(state);
    }
  }

  Stream<UscisQuizState> _onFetch(UscisQuizState state) async* {
    try {
      if (state is UscisQuizStateUninitialized) {
        final List<UscisQuizQuestion> questions =
            await uscisQuizRepository.getUscisQuizQuestions();
        yield UscisQuizStateLoaded(questions: questions);
      }
    }
    catch (error) {
      yield UscisQuizStateError(error: error);
    }
  }
}
