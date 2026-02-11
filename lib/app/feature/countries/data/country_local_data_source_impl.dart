import 'dart:convert';

import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';

import 'package:flowery_rider_app/app/feature/countries/domain/country_local_data_source_contract.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'model/country_dto.dart';
@Injectable(as: CountryLocalDataSourceContract)
class CountryLocalDataSourceImpl extends CountryLocalDataSourceContract{
  @override
  Future<BaseResponse<List<CountryDto>>> getAllCountries() =>executeApi(()async {
    var response = await rootBundle.loadString('assets/jsonFiles/country.json');
    final List<dynamic> jsonList = jsonDecode(response);
    final List<CountryDto> countries =
    jsonList.map((e) => CountryDto.fromJson(e)).toList();
    return Future.value(countries);
  },);
}