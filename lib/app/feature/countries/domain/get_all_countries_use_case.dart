import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/country_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';

class GetAllCountriesUseCase {
  final CountryRepoContract _repoContract;
  GetAllCountriesUseCase(this._repoContract);
  Future<BaseResponse<List<CountryEntity>>> invoke(){
    return _repoContract.getAllCountries();
  }
}