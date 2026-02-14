import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/use_case/apply_driver_use_case.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_event.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_intent.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_state.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_view_model.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/get_all_countries_use_case.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/get_all_vehicles_use_case.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_driver_view_model_test.mocks.dart';
@GenerateMocks([ApplyDriverUseCase,GetAllCountriesUseCase,GetAllVehiclesUseCase])
void main() {
  late GetAllCountriesUseCase countriesUseCase;
  late GetAllVehiclesUseCase vehiclesUseCase;
  late ApplyDriverUseCase driverUseCase;
  late ApplyDriverViewModel driverViewModel;
  late CountryEntity countryEntity;
  late VehicleEntity vehicleEntity;
  setUpAll(() {
    countriesUseCase=MockGetAllCountriesUseCase();
    vehiclesUseCase=MockGetAllVehiclesUseCase();
    driverUseCase=MockApplyDriverUseCase();
    countryEntity=CountryEntity(
      name: 'egypt'
    );
    vehicleEntity=VehicleEntity(
      vehicleType: 'car'
    );
  },);
  setUp(() {
    driverViewModel=ApplyDriverViewModel(vehiclesUseCase, countriesUseCase, driverUseCase);
  },);
  group('init intent', () {
    blocTest(
      'when calling dointent with init  action with success in countries and vehicles it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<CountryEntity>>>(
          SuccessResponse(data: [countryEntity]),
        );
        provideDummy<BaseResponse<List<VehicleEntity>>>(
          SuccessResponse(data: [vehicleEntity]),
        );
        when(countriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [countryEntity]));
        });
        when(vehiclesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [vehicleEntity]));
        });
      },
      build: () => driverViewModel,
      act: (bloc) {
        driverViewModel.doIntent(InitIntent());
      },
      expect: () {
        var state = ApplyDriverState();
        return [
          state.copyWith(countriesState: BaseState(isLoading: true)),
          state.copyWith(countriesState:BaseState(isLoading: true),
          vehiclesState: BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              data: [countryEntity],
            ),
            vehiclesState:BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              data: [countryEntity],
            ),
            vehiclesState: BaseState(
              isLoading:false ,
              data: [vehicleEntity],
            ),)
        ];
      },
    );
    blocTest(
      'when calling dointent with init  action with success in countries and error in vehicles it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<CountryEntity>>>(
          SuccessResponse(data: [countryEntity]),
        );
        provideDummy<BaseResponse<List<VehicleEntity>>>(
          ErrorResponse(error:UnexpectedError()),
        );
        when(countriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [countryEntity]));
        });
        when(vehiclesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error:UnexpectedError()));
        });
      },
      build: () => driverViewModel,
      act: (bloc) {
        driverViewModel.doIntent(InitIntent());
      },
      expect: () {
        var state = ApplyDriverState();
        return [
          state.copyWith(countriesState: BaseState(isLoading: true)),
          state.copyWith(countriesState:BaseState(isLoading: true),
            vehiclesState: BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              data: [countryEntity],
            ),
            vehiclesState:BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              data: [countryEntity],
            ),
            vehiclesState: BaseState(
              isLoading:false ,
              error: UnexpectedError()
            ),)
        ];
      },
    );
    blocTest(
      'when calling dointent with init  action with error in countries and success in vehicles it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<CountryEntity>>>(
          ErrorResponse(error: UnexpectedError()),
        );
        provideDummy<BaseResponse<List<VehicleEntity>>>(
          SuccessResponse(data: [vehicleEntity]),
        );
        when(countriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
        when(vehiclesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [vehicleEntity]));
        });
      },
      build: () => driverViewModel,
      act: (bloc) {
        driverViewModel.doIntent(InitIntent());
      },
      expect: () {
        var state = ApplyDriverState();
        return [
          state.copyWith(countriesState: BaseState(isLoading: true)),
          state.copyWith(countriesState:BaseState(isLoading: true),
            vehiclesState: BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              error: UnexpectedError()
            ),
            vehiclesState:BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              error:UnexpectedError(),
            ),
            vehiclesState: BaseState(
                isLoading:false ,
                data: [vehicleEntity]
            ),)
        ];
      },
    );
    blocTest(
      'when calling dointent with init  action with error in countries and  vehicles it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<CountryEntity>>>(
          ErrorResponse(error: UnexpectedError()),
        );
        provideDummy<BaseResponse<List<VehicleEntity>>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(countriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
        when(vehiclesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
      },
      build: () => driverViewModel,
      act: (bloc) {
        driverViewModel.doIntent(InitIntent());
      },
      expect: () {
        var state = ApplyDriverState();
        return [
          state.copyWith(countriesState: BaseState(isLoading: true)),
          state.copyWith(countriesState:BaseState(isLoading: true),
            vehiclesState: BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
                isLoading: false,
                error: UnexpectedError()
            ),
            vehiclesState:BaseState(isLoading: true),),
          state.copyWith(
            countriesState: BaseState(
              isLoading: false,
              error:UnexpectedError(),
            ),
            vehiclesState: BaseState(
                isLoading:false ,
                error:UnexpectedError()
            ),)
        ];
      },
    );
  },);
group('apply driver', () {
  test('when calling do intent with apply driver action with success it must emit correct event', ()async {
    // Arrange
    final request = ApplyDriverRequest(firstName: "Sayed");
provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));
    when(driverUseCase.invoke(request))
        .thenAnswer((_) async => SuccessResponse(data: 'success'));

    final emittedEvents = <ApplyDriverEvent>[ApplyDriverLoadingEvent(),NavigateToLoginEvent(),];
    driverViewModel.cubitStream.listen(emittedEvents.add);

    // Act
     driverViewModel.doIntent(ApplyIntent(driverRequest: request));

    // Assert
    expect(emittedEvents[0], isA<ApplyDriverLoadingEvent>());
    expect(emittedEvents[1], isA<NavigateToLoginEvent>());
    verify(driverUseCase.invoke(request)).called(1);
  },);
  test('when calling do intent with apply driver action with error it must emit correct event', ()async {
    // Arrange
    final request = ApplyDriverRequest(firstName: "Sayed");
    provideDummy<BaseResponse<String>>(ErrorResponse(error: UnexpectedError()));
    when(driverUseCase.invoke(request))
        .thenAnswer((_) async => ErrorResponse(error: UnexpectedError()));

    final emittedEvents = <ApplyDriverEvent>[ApplyDriverLoadingEvent(),ApplyDriverErrorEvent(errorMessage: UnexpectedError()),];
    driverViewModel.cubitStream.listen(emittedEvents.add);

    // Act
    driverViewModel.doIntent(ApplyIntent(driverRequest: request));

    // Assert
    expect(emittedEvents[0], isA<ApplyDriverLoadingEvent>());
    expect(emittedEvents[1], isA<ApplyDriverErrorEvent>());
    verify(driverUseCase.invoke(request)).called(1);
  },);
},);
}