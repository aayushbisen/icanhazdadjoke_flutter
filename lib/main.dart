import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icanhazdadjoke_flutter/blocs/joke_bloc/joke_bloc.dart';
import 'package:icanhazdadjoke_flutter/myapp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<JokeBloc>(
            create: (context) => JokeBloc()
              ..add(
                LoadJokeEvent(),
              ),
          ),
        ],
        child: MyHomePage(
          title: 'Dad Jokes',
        ),
      ),
    );
  }
}
