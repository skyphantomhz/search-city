import 'package:bloc_provider/bloc_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:search_city/model/city.dart';
import 'package:search_city/service/city_service.dart';
import 'package:search_city/service/weather_service.dart';

class CityBloc extends Bloc {
  final service = GetIt.I<CityService>();
  final weatherService = GetIt.I<WeatherService>();

  PublishSubject<String> _keyWord = PublishSubject<String>();
  PublishSubject<List<City>> _cities = PublishSubject<List<City>>();
  Observable<List<City>> get cities => _cities.stream;

  void addListener() {
    _keyWord.stream.debounceTime(Duration(milliseconds: 500)).listen((keyWord) {
      _searchCity(keyWord);
    });
  }

  void _searchCity(String keyWord) async {
    final data = await service.searchCity(keyWord);
    _cities.sink.add(data);
    final res = await weatherService.fetchWeather(1252376);
  }

  void setKeyWord(String keyWord) {
    _keyWord.sink.add(keyWord);
  }

  @override
  void dispose() {
    _cities.close();
    _keyWord.close();
  }
}
