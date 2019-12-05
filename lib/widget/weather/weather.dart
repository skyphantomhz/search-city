import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/model/weather/location.dart';
import 'package:search_city/model/weather/weather.dart';
import 'package:search_city/widget/weather/search.dart';

class WeatherDetail extends StatefulWidget {
  WeatherDetail({Key key}) : super(key: key);

  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  WeatherBloc weatherBloc;
  CityBloc cityBloc;
  PageController pageController = PageController();

  void addPagerListener() {
    cityBloc.citySaved.listen((saved) {
      if (saved) {
        pageController.jumpToPage(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    cityBloc = BlocProvider.of<CityBloc>(context);
    weatherBloc.getData();
    addPagerListener();
    return Container(
      padding: EdgeInsets.all(8.0),
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SearchCity(),
          SizedBox.expand(
            child: StreamBuilder<Weather>(
                stream: weatherBloc.weather,
                builder: (context, snapshot) {
                  final location = snapshot?.data?.location;
                  final currentObservation = snapshot?.data?.currentObservation;
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(location.city ?? "N/A"),
                        Text(location.region ?? "N/A"),
                        Text(currentObservation.condition.temperature
                                .toString() ??
                            "N/A"),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
