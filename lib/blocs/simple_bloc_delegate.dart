import 'package:bloc/bloc.dart';

// The bloc library allows us to have access to all Transitions in one place.
// The change from one state to another is called a Transition.
// A Transition consists of the current state, the event, and the next state.
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    // Print the transition to the console every time a Bloc Transition occurs.
    print(transition);
  }
}
