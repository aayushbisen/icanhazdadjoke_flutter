import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanhazdadjoke_flutter/blocs/joke_bloc/joke_bloc.dart';

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
      home: BlocProvider<JokeBloc>(
        create: (context) => JokeBloc()
          ..add(
            LoadJokeEvent(),
          ),
        child: MyHomePage(title: 'Random Dad Jokes'),
      ), 
    );
  }
}

class MyHomePage extends StatelessWidget {
  final title;

  const MyHomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.pressStart2p(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<JokeBloc, JokeState>(
        builder: (context, state) {
          if (state is LoadingJokeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedJokeState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.joke.joke,
                  textAlign: TextAlign.center,
                
                  style: GoogleFonts.pressStart2p(
                    fontSize: 24.0,
                    height: 1.5,
                  ),
                ),
              ),
            );
          } else if (state is FailToLoadJokeState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.error.toString(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 24.0,
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async =>
            BlocProvider.of<JokeBloc>(context).add(PullToRefreshEvent()),
      ),
    );
  }
}
