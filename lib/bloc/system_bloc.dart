import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:search_city/bloc/base_bloc.dart';

class SystemBloc extends BaseBloc {
  PublishSubject<Brightness> _brightness = PublishSubject();

  Observable<Brightness> get brightness => _brightness.stream;

  void updateTheme(Brightness brightness) {
    _brightness.sink.add(brightness);
  }

  @override
  void dispose() {
    _brightness.close();
  }
}
