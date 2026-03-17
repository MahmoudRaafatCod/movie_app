import 'package:movie/features/movie_details/data/models/saved_movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  /// Database
  static Database? _database;

  /// Instance
  static final DataBaseHelper instance = DataBaseHelper._();

  DataBaseHelper._();

  /// Check DataBase
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDataBase();
    return _database!;
  }

  /// Init DB
  Future<Database> _initDataBase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, "movies.db");

    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: _createDataBase,
    );
  }

  /// Create DB
  Future<void> _createDataBase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE saved_movies(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        media_type TEXT NOT NULL,
        poster_path TEXT NOT NULL,
        vote_average REAL
      )
    ''');
  }

  /// Create Movie
  Future<int> createMovie(SavedMovieModel movie) async {
    Database db = await database;
    return await db.insert(
      "saved_movies",
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Read Movies
  Future<List<SavedMovieModel>> getMovies() async {
    Database db = await database;
    List<Map<String, dynamic>> moviesAsMap = await db.query("saved_movies");
    List<SavedMovieModel> movies = moviesAsMap.map((Map<String, dynamic> movie) => SavedMovieModel.fromMap(movie)).toList();
    return movies;
  }

  /// Update Movie
  Future<int> updateMovie(SavedMovieModel movie) async {
    Database db = await database;
    return await db.update(
      "saved_movies",
      movie.toMap(),
      where: "id = ?",
      whereArgs: [movie.id],
    );
  }

  /// Delete Movie
  Future<int> deleteMovie(int id) async {
    Database db = await database;
    return await db.delete(
      "saved_movies",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Read Movies By Type
  Future<List<SavedMovieModel>> getMoviesByType(String type) async {
    Database db = await database;

    List<Map<String, dynamic>> moviesAsMap = await db.query(
      "saved_movies",
      where: "media_type = ?",
      whereArgs: [type],
    );

    List<SavedMovieModel> movies = moviesAsMap.map((Map<String, dynamic> movie) => SavedMovieModel.fromMap(movie)).toList();

    return movies;
  }

  Future<bool> hasMovies() async {
    Database db = await database;

    final result = await db.query(
      "saved_movies",
      where: "media_type = ?",
      whereArgs: ["movie"],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<bool> hasTv() async {
    Database db = await database;

    final result = await db.query(
      "saved_movies",
      where: "media_type = ?",
      whereArgs: ["tv"],
      limit: 1,
    );

    return result.isNotEmpty;
  }


  /// Clear Table
  Future<void> clearMovies() async {
    Database db = await database;
    await db.delete("saved_movies");
  }

  /// Drop Database
  Future<void> dropDatabase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, "movies.db");
    await deleteDatabase(fullPath);
  }
}
