part of 'uscis_quiz_bloc.dart';

@immutable
abstract class UscisQuizEvent extends Equatable {
  UscisQuizEvent();

  List<Object> get props => [];
}

class UscisQuizEventFetch extends UscisQuizEvent {}
