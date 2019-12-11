import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/bloc/navigator_bloc.dart';
import 'package:search_city/bloc/system_bloc.dart';
import 'package:search_city/bloc/weather_bloc.dart';
import 'package:search_city/util/locator.dart';
import 'package:search_city/widget/home.dart';

void main() {
  setupLocator();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SystemBloc>(
        create: (_context) => SystemBloc(),
      ),
      BlocProvider<NavigatorBloc>(
        create: (_context) => NavigatorBloc(),
      ),
      BlocProvider<CityBloc>(
        create: (_context) => CityBloc(),
      ),
      BlocProvider<WeatherBloc>(
        create: (_context) => WeatherBloc(),
      ),
    ],
    child: MyApp(),
  ));
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
          home: MyHomePage(title: 'Search city'),
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
