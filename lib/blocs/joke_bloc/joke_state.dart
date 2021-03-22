part of 'joke_bloc.dart';

@immutable
abstract class JokeState {}

// class JokeInitial extends JokeState {}

class LoadingJokeState extends JokeState {}

class LoadedJokeState extends JokeState {
  final Joke joke;
  LoadedJokeState({this.joke});
}

class FailToLoadJokeState extends JokeState {
  final Error error;
  FailToLoadJokeState({this.error});
}
