import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/bloc/system_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/util/locator.dart';
import 'package:search_city/widget/home.dart';

import 'data/local_datasource.dart';

void main() {
  setupLocator();
  LocalDataSource.connect();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(
    BlocProvider<SystemBloc>(
      create: (_context) => SystemBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SystemBloc systemBloc;
  Brightness _brightness = Brightness.light;

  @override
  void dispose() {
    systemBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    systemBloc = BlocProvider.of<SystemBloc>(context);
    listenConfigChange();
    return StreamBuilder<Brightness>(
      stream: systemBloc.brightness,
      initialData: Brightness.light,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialApp(
          title: 'Search City',
          theme: ThemeData(
            brightness: _brightness,
            primarySwatch: Colors.blue,
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CityBloc>(
                create: (_context) => CityBloc(),
              ),
              BlocProvider<WeatherBloc>(
                create: (_context) => WeatherBloc(),
              ),
            ],
            child: MyHomePage(title: 'Search city'),
          ),
        );
      },
    );
  }

  void listenConfigChange() {
    systemBloc.brightness.listen((brightness) {
      setState(() {
        _brightness = brightness;
      });
    });
  }
}
