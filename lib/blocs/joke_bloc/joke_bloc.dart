import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:icanhazdadjoke_flutter/joke.dart';
import 'package:meta/meta.dart';

import '../../data_service.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc() : super(LoadingJokeState());
  final _dataService = JokeService();

  @override
  Stream<JokeState> mapEventToState(
    JokeEvent event,
  ) async* {
    if (event is LoadJokeEvent || event is PullToRefreshEvent) {
      yield LoadingJokeState();
      try {
        final joke = await _dataService.getJoke();
        yield LoadedJokeState(joke: joke);
      } catch (e) {
        yield FailToLoadJokeState(error: e);
      }
    }
  }
}
