import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/model/weather/location.dart';
import 'package:search_city/widget/weather/search.dart';

class Weather extends StatefulWidget {
  Weather({Key key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.setListener();
    return Container(
      padding: EdgeInsets.all(8.0),
      child: PageView(
        children: <Widget>[
          SearchCity(),
          SizedBox.expand(
            child: Container(
              child: Column(
                children: <Widget>[
                  StreamBuilder<Location>(
                      stream: weatherBloc.location,
                      builder: (context, snapshot) {
                        final name = snapshot?.data?.city ?? "N/A";
                        return Text(name);
                      }),
                  StreamBuilder<Location>(
                      stream: weatherBloc.location,
                      builder: (context, snapshot) {
                        final region = snapshot?.data?.region ?? "N/A";
                        return Text(region);
                      }),
                  StreamBuilder<int>(
                      stream: weatherBloc.temperature,
                      builder: (context, snapshot) {
                        final temperature = snapshot.data?.toString() ?? "N/A";
                        return Text(temperature);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
