import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/countries/data/model/country_dto.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/country_local_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/country_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';

class CountriesRepoImpl extends CountryRepoContract{
  final CountryLocalDataSourceContract _localDataSourceContract;
  CountriesRepoImpl(this._localDataSourceContract);
  @override
  Future<BaseResponse<List<CountryEntity>>> getAllCountries()async {
final result=await _localDataSourceContract.getAllCountries();
switch(result) {
  case SuccessResponse<List<CountryDto>>():
    final List<CountryEntity> countries=result.data.map((e) => e.toCountryEntity(),).toList();
    return SuccessResponse(data: countries);
  case ErrorResponse<List<CountryDto>>():
   return ErrorResponse(error: result.error);
}
  }
}