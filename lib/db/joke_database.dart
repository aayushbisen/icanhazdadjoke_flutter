import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class JokeDB {
  JokeDB._();
  static final JokeDB _singleton = JokeDB._();

  static JokeDB get instance => _singleton;

  static Database _db;

  String _dbPath = 'joke.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    final documentDIR = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDIR.path, _dbPath);
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}
