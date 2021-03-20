import 'dart:convert';

import 'package:icanhazdadjoke_flutter/joke.dart';

import 'package:http/http.dart' as http;

class JokeService {
  final _baseUrl = 'https://icanhazdadjoke.com/';

  Future<Joke> getJoke() async {
    try {
      final uri = Uri.parse(_baseUrl);
      final headers = {
        'Accept': 'application/json',
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return Joke.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load joke');
      }
    } catch (error) {
      throw Exception('Failed to load joke');
    }
  }
}
