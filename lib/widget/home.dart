import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:search_city/bloc/navigator_bloc.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/bloc/system_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/util/color.dart';
import 'package:search_city/util/color.dart' as res;
import 'package:search_city/widget/header_clock.dart';
import 'package:search_city/widget/weather/search.dart';
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SystemBloc system;
  NavigatorBloc navigatorBloc;
  CityBloc cityBloc;
  WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    system = BlocProvider.of<SystemBloc>(context);
    navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    cityBloc = BlocProvider.of<CityBloc>(context);
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    setListener();
    initialData();
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: colors[res.Element.background]),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  HeaderClock()
                ],
              ),
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
        ),
      ),
    );
  }

  void setListener(){
    navigatorBloc.homeStatus.listen((status){
      if(!mounted) return;
      switch (status) {
        case 1:
          searchCity();
          break;
        default:
      }
    });
  }


  void initialData() async {
    var woeid = await cityBloc.getWoeid();
    if(mounted){
      if(woeid == null || woeid == 0){
        Toast.show("Woei is null", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        searchCity();
      }else{
        Toast.show("Woei is $woeid", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        weatherBloc.fetchWeather(woeid);
      }
    }
  }

  void searchCity() async {
    final result = await showDialog(
          context: context,
          builder: (BuildContext context) => SearchCity(),
        );
        if(result == 'ok'){
          setState(() {});
        }
  }
}


