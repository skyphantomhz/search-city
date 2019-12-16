import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/navigator_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/model/weather/weather.dart';
import 'package:search_city/util/color.dart' as res;
import 'package:search_city/util/color.dart';

class HeaderClock extends StatelessWidget {
  WeatherBloc weatherBloc;
  NavigatorBloc navigatorBloc;
  HeaderClock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return StreamBuilder<Weather>(
      stream: weatherBloc.weather,
      builder: (context, snapshot) {
        final cityName = snapshot?.data?.location?.city ?? "";
        final temprature =
            snapshot?.data?.currentObservation?.condition?.temperature ?? "";
        final status =
            snapshot?.data?.currentObservation?.condition?.text ?? "";
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: InkWell(
              onTap: () {
                navigatorBloc.setHomeState(1);
              },
              child: Text(
                cityName,
                style: TextStyle(color: colors[res.Element.text], fontSize: 25),
              ),
            )),
            Text(
              "$temprature* C",
              style: TextStyle(color: colors[res.Element.text], fontSize: 30),
            ),
            Text(
              status,
              style: TextStyle(color: colors[res.Element.text], fontSize: 20),
            )
          ],
        );
      },
    );
  }
}
