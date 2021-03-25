import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanhazdadjoke_flutter/db/joke_dao.dart';
import 'package:icanhazdadjoke_flutter/db/joke_provider.dart';
import 'package:provider/provider.dart';

class SavedJokesPage extends StatefulWidget {
  @override
  _SavedJokesPageState createState() => _SavedJokesPageState();
}

class _SavedJokesPageState extends State<SavedJokesPage> {
  @override
  void initState() {
    Provider.of<JokesProvider>(context).fetchAndSetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Jokes',
          style: GoogleFonts.pressStart2p(),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final currentJoke = Provider.of<JokesProvider>(context).jokes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              // vertical: 10,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        currentJoke.joke,
                        style: GoogleFonts.pressStart2p(
                          height: 1.5,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.share_outlined,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outlined,
                          ),
                          onPressed: () {
                            Provider.of<JokesProvider>(context)
                                .deleteJoke(currentJoke);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, _) => SizedBox(height: 10),
        itemCount: Provider.of<JokesProvider>(context).jokes.length,
      ),
    );
  }
}
