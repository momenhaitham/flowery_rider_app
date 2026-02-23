import 'package:bloc/bloc.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../domain/model/driver_entity.dart';
import '../../../domain/use_case/get_driver_data_use_case.dart';

@injectable
class ProfileViewModel extends CustomCubit<ProfileEvent, ProfileState> {
  final GetDriverDataUseCase _getDriverDataUseCase;
  ProfileViewModel(this._getDriverDataUseCase)
    : super(ProfileState(profileState: BaseState()));
  Future<void> _getDriverData() async {
    emit(state.copyWith(profileState: BaseState(isLoading: true)));
    final response = await _getDriverDataUseCase.invoke();
    switch (response) {
      case SuccessResponse<DriverEntity>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;
      case ErrorResponse<DriverEntity>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, error: response.error),
          ),
        );
        break;
    }
  }
  void doIntent(ProfileIntent intent) {
    switch (intent) {
      case GetProfileAction():
        _getDriverData();
        break;
      case NavigateToEditProfileIntent():
        streamController.add(NavigateToEditProfileScreen(intent.driver));
        break;
    }
  }
}
