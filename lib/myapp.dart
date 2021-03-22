import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanhazdadjoke_flutter/blocs/joke_bloc/joke_bloc.dart';
import 'package:icanhazdadjoke_flutter/db/joke_dao.dart';
import 'package:icanhazdadjoke_flutter/saved_jokes_page.dart';

class MyHomePage extends StatefulWidget {
  final title;

  const MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.pressStart2p(),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SavedJokesPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.save),
            ),
          ),
        ],
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocConsumer<JokeBloc,JokeState>(
            listener: (context, state) {},
            builder: (context, state) => FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.save_alt),
              onPressed: state is LoadedJokeState
                  ? () {
                      JokeDAO().insert(state.joke);
                    }
                  : null,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.refresh),
            onPressed: () async =>
                BlocProvider.of<JokeBloc>(context).add(PullToRefreshEvent()),
          ),
        ],
      ),
    );
  }
}
