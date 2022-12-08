import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperList {
  static DatabaseHelperList? _stateInstanse;
  static Database? _database;

  DatabaseHelperList._internal() {
    _stateInstanse = this;
  }

  factory DatabaseHelperList() => _stateInstanse ?? DatabaseHelperList._internal();
  static const String _queryFavorites = 'favorite';

  Future<Database> _inisialitationDatabase() async {
    var path = await getDatabasesPath();
    var createDatabase = openDatabase(
      '$path/appresto.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_queryFavorites (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating REAL
            )     
          ''');
      },
      version: 1,
    );
    return createDatabase;
  }

  Future<Database?> get database async {
    _database ??= await _inisialitationDatabase();
    return _database;
  }

  Future<List<Restaurant>> getFavorite() async {
    final getRestaurantFavorite = await database;
    List<Map<String, dynamic>> resultsGetFavorite = await getRestaurantFavorite!.query(_queryFavorites);

    return resultsGetFavorite.map((getAllfavorite) => Restaurant.fromJson(getAllfavorite)).toList();
  }


  Future<void> addFavorite(Restaurant resto) async {
    final addDatabase = await database;
    await addDatabase!.insert(_queryFavorites, resto.toJson());
  }

  
  Future<Map> getFavoriteById(String id) async {
    final getDatabase = await database;

    List<Map<String, dynamic>> resultsGetDatabase = await getDatabase!.query(
      _queryFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultsGetDatabase.isNotEmpty) {
      return resultsGetDatabase.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final deleteDb = await database;
    await deleteDb!.delete(
      _queryFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
