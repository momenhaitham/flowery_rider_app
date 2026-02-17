import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/countries/data/countries_repo_impl.dart';
import 'package:flowery_rider_app/app/feature/countries/data/model/country_dto.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/country_local_data_source_contract.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'countries_repo_impl_test.mocks.dart';
@GenerateMocks([CountryLocalDataSourceContract])
void main() {
  test('when calling get all countries it must get data from data source', ()async {
    CountryLocalDataSourceContract dataSource=MockCountryLocalDataSourceContract();
    CountriesRepoImpl repo=CountriesRepoImpl(dataSource);
   CountryDto response=CountryDto(
      flag: 'flag',
      name: 'egypt'
    );

    provideDummy<BaseResponse<List<CountryDto>>>(SuccessResponse(data: [response]),);
    when(dataSource.getAllCountries()).thenAnswer((_) async => SuccessResponse(data: [response]));
    var result=await repo.getAllCountries();
    expect(result,isA<SuccessResponse<List<CountryEntity>>>());
    verify(dataSource.getAllCountries()).called(1);
  });
}