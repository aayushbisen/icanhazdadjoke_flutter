import 'package:flutter/foundation.dart';
import 'package:icanhazdadjoke_flutter/db/joke_dao.dart';
import 'package:icanhazdadjoke_flutter/joke.dart';

class JokesProvider with ChangeNotifier {
  final JokeDAO _jokeDAO;
  List<Joke> _localJokes = [];

  JokesProvider(this._jokeDAO);
  List<Joke> get jokes => [..._localJokes];

  void deleteJoke(Joke joke) async {
    await _jokeDAO.delete(joke);
    _localJokes = await _jokeDAO.getAllJokes();
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    _localJokes = await _jokeDAO.getAllJokes();
    notifyListeners();
  }
}
