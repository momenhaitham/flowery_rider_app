import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';

class ApplyDriverState {

  final BaseState<List<VehicleEntity>>? vehiclesState;
  final BaseState<List<CountryEntity>>? countriesState;
  ApplyDriverState({this.countriesState,this.vehiclesState});
  ApplyDriverState copyWith({
    BaseState<List<VehicleEntity>>? vehiclesState,
    BaseState<List<CountryEntity>>? countriesState
  }){
    return ApplyDriverState(
        countriesState: countriesState??this.countriesState,
      vehiclesState: vehiclesState??this.vehiclesState
    );
  }
}