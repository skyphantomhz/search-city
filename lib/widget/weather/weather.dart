import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/bloc/navigator_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/model/weather/weather.dart';

class WeatherDetail extends StatefulWidget {
  WeatherDetail({Key key}) : super(key: key);

  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  WeatherBloc weatherBloc;
  CityBloc cityBloc;
  NavigatorBloc navigatorBloc;

  void getWoeid() async {
    final woeid = await cityBloc.getWoeid();
    if (mounted) {
      if (woeid == null) {
        navigatorBloc.setHomeState(1);
      } else
        weatherBloc.fetchWeather(woeid);
    }
  }

  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    cityBloc = BlocProvider.of<CityBloc>(context);
    navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    getWoeid();
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: StreamBuilder<Weather>(
            stream: weatherBloc.weather,
            builder: (context, snapshot) {
              final location = snapshot?.data?.location;
              final currentObservation = snapshot?.data?.currentObservation;
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(location?.city ?? "N/A"),
                    Text(location?.region ?? "N/A"),
                    Text(currentObservation?.condition?.temperature
                            ?.toString() ??
                        "N/A"),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
