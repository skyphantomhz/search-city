import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:search_city/bloc/city_bloc.dart';
import 'package:search_city/model/city.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
