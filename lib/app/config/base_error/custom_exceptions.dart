import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ConnectionError with EquatableMixin implements Exception{
  String message;
  ConnectionError([this.message = "No Internet Connection"]);
  @override
  List<Object?> get props => [];
}
// ignore: must_be_immutable
class ServerError with EquatableMixin implements Exception {
  String? message;
  String? statusMessage;

  ServerError({this.message, this.statusMessage});

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class UnexpectedError with EquatableMixin implements Exception {
  String message;
  UnexpectedError([this.message = "Something went wrong"]);
  @override
  List<Object?> get props => [];
}