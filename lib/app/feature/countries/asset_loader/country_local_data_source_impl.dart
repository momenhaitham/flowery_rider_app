import 'dart:convert';


import 'package:flowery_rider_app/app/config/api_utils/api_utils.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';

import 'package:flowery_rider_app/app/feature/countries/domain/country_local_data_source_contract.dart';

import 'package:injectable/injectable.dart';

import '../data/model/country_dto.dart';
import 'AssetLoader.dart';
@Injectable(as: CountryLocalDataSourceContract)
class CountryLocalDataSourceImpl extends CountryLocalDataSourceContract{
  final JsonLoader _assetLoader;
  CountryLocalDataSourceImpl(this._assetLoader);
  @override
  Future<BaseResponse<List<CountryDto>>> getAllCountries() =>executeApi(()async {
    var response = await _assetLoader.loadString(AssetsFiles.countriesFile,);
    final List<dynamic> jsonList = jsonDecode(response);
    final List<CountryDto> countries =
    jsonList.map((e) => CountryDto.fromJson(e)).toList();
    return Future.value(countries);
  },);
}