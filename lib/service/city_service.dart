import 'dart:convert';

import 'package:search_city/model/base_response.dart';
import 'package:search_city/model/city.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class CityService {
  final baseUrl = "https://www.yahoo.com/news/_tdnews/api/resource";
  final http.Client client = GetIt.I<http.Client>();
  final _decoder = GetIt.I<JsonDecoder>();

  Future<List<City>> searchCity(String keyWord) async {
    String url = "$baseUrl/WeatherSearch;text=$keyWord";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = _decoder.convert(response.body);
      if (json != null) {
        var cities = new List<City>();
        json.forEach((city) {
          cities.add(new City.fromJson(city));
        });
        return cities;
      }
    } else {
      throw Exception("Failed to load route");
    }
  }
}
