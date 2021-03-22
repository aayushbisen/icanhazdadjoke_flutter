import 'package:flutter/widgets.dart';
import 'package:icanhazdadjoke_flutter/db/joke_database.dart';
import 'package:sembast/sembast.dart';

import '../joke.dart';

class JokeDAO {
  static const String STORE = 'jokes';
  final _jokeStore = intMapStoreFactory.store(STORE);

  Future<Database> get db async => await JokeDB.instance.db;

  Future insert(Joke joke) async {
    await _jokeStore.add(await db, joke.toJson());
    print('Joke added'+joke.joke);
  }

  Future delete(Joke joke) async {
    final findJoke= Finder(filter: Filter.byKey(joke.id));

    await _jokeStore.delete(await db, finder: findJoke,);

    debugPrint(findJoke.toString());
  }

  Future deleteAll() async {
    _jokeStore.delete(
      await db,
    );
  }

  Future<List<Joke>> getAllJokes() async {
    final recordSnapshots = await _jokeStore.find(await db);

    return recordSnapshots.map((snapshot) {
      final joke = Joke.fromJson(snapshot.value);
      return joke;
    }).toList();
  }
}
