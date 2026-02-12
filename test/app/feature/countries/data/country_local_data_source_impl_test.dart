import 'dart:convert';
import 'dart:io';

import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/feature/countries/asset_loader/AssetLoader.dart';
import 'package:flowery_rider_app/app/feature/countries/asset_loader/country_local_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/countries/data/model/country_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'country_local_data_source_impl_test.mocks.dart';



@GenerateMocks([JsonLoader])
void main() {
  late JsonLoader mockAssetLoader;
  late CountryLocalDataSourceImpl dataSource;

  setUp(() {
    mockAssetLoader = MockJsonLoader();
    dataSource = CountryLocalDataSourceImpl(mockAssetLoader);
  });

  test('getAllCountries should return list of CountryDto when json is valid',
          () async {
        // Arrange
        final jsonString = jsonEncode([
          {"id": 1, "name": "Egypt"},
          {"id": 2, "name": "USA"}
        ]);

        when(mockAssetLoader.loadString(AssetsFiles.countriesFile))
            .thenAnswer((_) async => jsonString);

        // Act
        final result = await dataSource.getAllCountries() as SuccessResponse<List<CountryDto>>;

        // Assert
        expect(result, isA<SuccessResponse<List<CountryDto>>>());

        final countries = result.data;
        expect(countries.length, 2);
        expect(countries[0].name, "Egypt");
        expect(countries[1].name, "USA");

        verify(mockAssetLoader.loadString(AssetsFiles.countriesFile))
            .called(1);
      });
  test('getAllCountries should return correct error when json is invalid',
          () async {
        // Arrange
        final jsonString = jsonEncode([
          {"id": 1, "name": "Egypt"},
          {"id": 2, "name": "USA"}
        ]);

        when(mockAssetLoader.loadString(AssetsFiles.countriesFile))
            .thenThrow(IOException);

        // Act
        final result = await dataSource.getAllCountries() as ErrorResponse<List<CountryDto>>;

        // Assert
        expect(result, isA<ErrorResponse<List<CountryDto>>>());
        expect(result.error,UnexpectedError());
        verify(mockAssetLoader.loadString(AssetsFiles.countriesFile))
            .called(1);
      });
}
