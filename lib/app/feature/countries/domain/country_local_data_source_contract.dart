import '../../../config/base_response/base_response.dart';
import '../data/model/country_dto.dart';

abstract class CountryLocalDataSourceContract {
  Future<BaseResponse<List<CountryDto>>> getAllCountries();

}