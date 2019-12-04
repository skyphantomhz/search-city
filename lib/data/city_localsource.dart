import 'package:search_city/data/local_datasource.dart';
import 'package:search_city/model/city.dart';
import 'package:sqflite/sqflite.dart';

class CityLocalSource {
  static Future<void> insert(City city) async {
    await (await LocalDataSource.database).insert(
      LocalDataSource.tableCity,
      city.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<City>> getCities() async {
    final List<Map<String, dynamic>> maps =
        await (await LocalDataSource.database).query(LocalDataSource.tableCity);
    return List.generate(maps.length, (index) {
      return City.fromJson(maps[index]);
    });
  }
}
