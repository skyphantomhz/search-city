import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search_city/bloc/base_bloc.dart';
import 'package:search_city/model/weather/location.dart';
import 'package:search_city/model/weather/weather.dart';
import 'package:search_city/service/weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherBloc extends BaseBloc {
  final weatherService = GetIt.I<WeatherService>();

  PublishSubject<Weather> _weather = PublishSubject<Weather>();
  Observable<Weather> get weather => _weather.stream;
  Observable<Location> location;
  Observable<int> temperature;

  void fetchWeather(int woeid) async {
    final data = await weatherService.fetchWeather(woeid);
    _weather.sink.add(data);
  }

  @override
  void dispose() {
    _weather.close();
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final woeid = prefs.getInt("woeid");
    fetchWeather(woeid);
  }
}
