import 'package:flowery_rider_app/app/feature/countries/data/model/country_dto.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when calling to country entity it must return country entity', () {
    var countryDto=CountryDto(
      flag: 'flag',
      name: 'egypt'
    );
    var result=countryDto.toCountryEntity();
    expect(result,isA<CountryEntity>());
    expect(result,equals(CountryEntity(name: 'egypt',flag: 'flag')));
  });

}