import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:search_city/bloc/system_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/util/color.dart';
import 'package:search_city/util/color.dart' as res;
import 'package:search_city/widget/weather/weather.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SystemBloc system;
  WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    system = BlocProvider.of<SystemBloc>(context);
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.setListener();
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: colors[res.Element.background]),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Weather(),
                flex: 1,
              ),
              Flexible(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(1, -1),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.lightbulb,
                            color: colors[res.Element.item],
                          ),
                          onPressed: () {
                            system.updateTheme(
                                Theme.of(context).brightness == Brightness.light
                                    ? Brightness.dark
                                    : Brightness.light);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
