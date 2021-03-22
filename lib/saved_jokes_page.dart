import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanhazdadjoke_flutter/db/joke_dao.dart';

class SavedJokesPage extends StatefulWidget {
  @override
  _SavedJokesPageState createState() => _SavedJokesPageState();
}

class _SavedJokesPageState extends State<SavedJokesPage> {
  final _jokeDao = JokeDAO();


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
      body: StreamBuilder(
        stream: Stream.fromFuture( _jokeDao.getAllJokes()),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                itemBuilder: (context, index) {
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
                                snapshot.data[index].joke,
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
                                    _jokeDao.delete(snapshot.data[index]);
                                    setState(() {

                                    });
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
                itemCount: snapshot.data.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
