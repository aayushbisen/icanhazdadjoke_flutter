part of 'joke_bloc.dart';

@immutable
abstract class JokeEvent {}


class LoadJokeEvent extends JokeEvent {}

class PullToRefreshEvent extends JokeEvent {}
