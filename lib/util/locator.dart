import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:search_city/service/city_service.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<Client>(() => Client());
  getIt.registerLazySingleton<JsonDecoder>(() => JsonDecoder());
  getIt.registerLazySingleton<CityService>(() => CityService());
}