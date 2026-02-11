import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/request/apply_driver_request.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/domain/use_case/apply_driver_use_case.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_event.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_intent.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_state.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/get_all_countries_use_case.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/get_all_vehicles_use_case.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class ApplyDriverViewModel  extends CustomCubit<ApplyDriverEvent,ApplyDriverState>{
  ApplyDriverViewModel(this._allVehiclesUseCase,this._allCountriesUseCase,this._applyDriverUseCase):super(ApplyDriverState());
  final ApplyDriverUseCase _applyDriverUseCase;
  final GetAllCountriesUseCase _allCountriesUseCase;
  final GetAllVehiclesUseCase _allVehiclesUseCase;
  Future<void> _getAllVehicles()async{
    emit(state.copyWith(
      vehiclesState: BaseState(isLoading: true)
    ));
    final result=await _allVehiclesUseCase.invoke();
    switch(result) {
      case SuccessResponse<List<VehicleEntity>>():
        emit(state.copyWith(
            vehiclesState: BaseState(isLoading: true,data: result.data)
        ));
        break;
      case ErrorResponse<List<VehicleEntity>>():
        emit(state.copyWith(
            vehiclesState: BaseState(isLoading: true,error: result.error)
        ));
        break;
    }
  }
  Future<void> _getAllCountries()async{
    emit(state.copyWith(
        countriesState: BaseState(isLoading: true)
    ));
    final result=await _allCountriesUseCase.invoke();
    switch(result) {
      case SuccessResponse<List<CountryEntity>>():
        emit(state.copyWith(
            countriesState: BaseState(isLoading: true,data: result.data)
        ));
        break;
      case ErrorResponse<List<CountryEntity>>():
        emit(state.copyWith(
            countriesState: BaseState(isLoading: true,error: result.error)
        ));
        break;
    }
  }
  Future<void> _applyDriver(ApplyDriverRequest driverRequest)async{
   streamController.add(ApplyDriverLoadingEvent());
    final result=await _applyDriverUseCase.invoke(driverRequest);
    switch(result) {
      case SuccessResponse<String>():
        streamController.add(NavigateToLoginEvent());
      case ErrorResponse<String>():
       streamController.add(ApplyDriverErrorEvent(errorMessage: result.error));
    }
  }
  void doIntent(ApplyDriverIntent intent)
  {
    switch(intent) {
      case InitIntent():
        _getAllCountries();
        _getAllVehicles();
        break;
      case ApplyIntent():
       _applyDriver(intent.driverRequest);
       break;
      case NavigateToLoginIntent():
       streamController.add(NavigateToLoginEvent());
       break;
    }
  }
}