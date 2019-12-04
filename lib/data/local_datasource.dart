import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  static String tableCity = "cities";
  static Future<Database> database;
  static void connect() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'clock_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableCity(woeid INTEGER PRIMARY KEY, lat INTEGER, lon INTEGER, country TEXT, city TEXT, qualifiedName TEXT)",
        );
      },
      version: 1,
    );
  }
}
