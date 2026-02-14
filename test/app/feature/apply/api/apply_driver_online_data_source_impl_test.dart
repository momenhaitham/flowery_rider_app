import 'dart:io';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/api/apply_api_client.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/api/apply_driver_online_data_source_impl.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/data/model/apply_driver_response.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_driver_online_data_source_impl_test.mocks.dart';
@GenerateMocks([ApplyApiClient])
void main() {
  late ApplyDriverOnlineDataSourceImpl dataSource;
  late ApplyApiClient apiClient;
  late ApplyDriverResponse applyResponse;
  late ApplyDriverRequest driverRequest;
  setUpAll(() {
    apiClient = MockApplyApiClient();
    dataSource = ApplyDriverOnlineDataSourceImpl(apiClient);
    applyResponse = ApplyDriverResponse(message: 'success',
    driver: Driver(
      id: '1',
      firstName: 'ahmed',
      lastName: 'ali',
    )
    );
    driverRequest=ApplyDriverRequest(
      firstName: 'ahmed',
      lastName: 'ali',
    );
  });
  group('apply driver', () {
    test(
      'when calling apply driver with success it must return data',
          () async {
        when(
          apiClient.applyDriver(
            driverRequest,
          ),

        ).thenAnswer((_) async => applyResponse);
        final response = await dataSource.applyDriver(driverRequest)
        as SuccessResponse<ApplyDriverResponse>;
        expect(response.data, applyResponse);
      },
    );
    test(

      'when calling apply driver with failure it must return error',
          () async {
        when(apiClient.applyDriver(driverRequest)).thenThrow(IOException);
        final response =
        await dataSource.applyDriver(driverRequest)
        as ErrorResponse<ApplyDriverResponse>;
        expect(response.error, UnexpectedError());
      },
    );
  });

}
