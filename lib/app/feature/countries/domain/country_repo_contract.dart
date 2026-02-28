import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';

abstract class CountryRepoContract {
  Future<BaseResponse<List<CountryEntity>>> getAllCountries();
}