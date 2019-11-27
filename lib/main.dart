import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/util/locator.dart';
import 'package:search_city/widget/home.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search City',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CityBloc>(
        creator: (_context, _bag) => CityBloc(),
        child: MyHomePage(title: 'Search city'),
        autoDispose: true,
      ),
    );
  }
}
