import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:search_city/bloc/base_bloc.dart';

class NavigatorBloc extends BaseBloc {
  PublishSubject<int> _homeController = PublishSubject();
  Observable<int> get homeStatus => _homeController.stream;

  @override
  void dispose() {
    _homeController.close();
  }
}
