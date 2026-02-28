import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/country_repo_contract.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/get_all_countries_use_case.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_countries_use_case_test.mocks.dart';
@GenerateMocks([CountryRepoContract])
void main() {
  test('when calling get all countries use case it must call repo', () async{
    CountryRepoContract repo = MockCountryRepoContract();
    GetAllCountriesUseCase useCase = GetAllCountriesUseCase(repo);
    CountryEntity entity=CountryEntity(flag: 'flag',name: 'egypt');
    provideDummy<BaseResponse<List<CountryEntity>>>(SuccessResponse(data:[entity]));
    when(repo.getAllCountries()).thenAnswer((_) async => SuccessResponse(data:[ entity]));
    var result =await useCase.invoke();
    expect(result, isA<SuccessResponse<List<CountryEntity>>>());
    verify(repo.getAllCountries()).called(1);
  });
}