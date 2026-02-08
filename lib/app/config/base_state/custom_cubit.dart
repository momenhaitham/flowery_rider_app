import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
class CustomCubit<event,state> extends Cubit<state>{
  CustomCubit(super.initialState);
  StreamController<event> streamController = StreamController.broadcast();
  Stream<event> get cubitStream=>streamController.stream;

  @override
  Future<void> close() async {
    await streamController.close();
    await super.close();
  }
}