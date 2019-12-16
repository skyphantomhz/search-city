import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:search_city/bloc/base_bloc.dart';
import 'package:search_city/model/city.dart';
import 'package:search_city/service/city_service.dart';
import 'package:search_city/service/weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityBloc extends BaseBloc {
  final service = GetIt.I<CityService>();
  final weatherService = GetIt.I<WeatherService>();

  PublishSubject<String> _keyWord = PublishSubject<String>();
  PublishSubject<List<City>> _cities = PublishSubject<List<City>>();
  PublishSubject<int> _woeidSaved = PublishSubject<int>();
  Observable<int> get woeidSaved => _woeidSaved.stream;
  Observable<List<City>> get cities => _cities.stream;

  void addListener() {
    _keyWord.stream.debounceTime(Duration(milliseconds: 500)).listen((keyWord) {
      _searchCity(keyWord);
    });
  }

  void _searchCity(String keyWord) async {
    final data = await service.searchCity(keyWord);
    _cities.sink.add(data);
  }

  void setKeyWord(String keyWord) {
    _keyWord.sink.add(keyWord);
  }

  @override
  void dispose() {
    _cities.close();
    _keyWord.close();
  }

  @override
  get initialState => null;

  @override
  Stream mapEventToState(event) {
    return null;
  }

  void saveLocationId(int woeid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("woeid", woeid);
    // _woeidSaved.sink.add(woeid);
  }

  Future<int> getWoeid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final woeid = prefs.getInt("woeid");
    return woeid;
  }
}
