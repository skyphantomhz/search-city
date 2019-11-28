import 'package:bloc/bloc.dart';

abstract class BaseBloc extends Bloc<dynamic, dynamic> {
  @override
  get initialState => null;

  @override
  Stream mapEventToState(event) {
    return null;
  }

  void dispose();
}
