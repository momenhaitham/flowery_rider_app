import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BaseState<T> extends Equatable {
  bool? isLoading;
  Exception? error;
  T? data;

  BaseState({this.isLoading = false, this.error, this.data});

  @override
  List<Object?> get props => [isLoading, data, error];
}
