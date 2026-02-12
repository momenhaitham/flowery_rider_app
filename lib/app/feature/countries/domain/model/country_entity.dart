import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable{
  final String? name;
  final String? flag;

  const CountryEntity({
    this.name,
    this.flag,
  });

  @override
  List<Object?> get props => [name,flag];
}