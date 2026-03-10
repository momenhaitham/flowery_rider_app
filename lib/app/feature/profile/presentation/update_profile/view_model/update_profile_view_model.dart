import 'dart:io';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/base_state/custom_cubit.dart';
import '../../../../apply_driver/domain/request/apply_driver_request.dart';
import '../../../../vehicles/domain/get_all_vehicles_use_case.dart';
import '../../../domain/use_case/update_profile_use_case.dart';
import '../../../domain/use_case/upload_profile_photo_use_case.dart';

@injectable
class UpdateProfileViewModel
    extends CustomCubit<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final UploadProfilePhotoUseCase _profilePhotoUseCase;
  final GetAllVehiclesUseCase _allVehiclesUseCase;


  UpdateProfileViewModel(this._updateProfileUseCase, this._profilePhotoUseCase,this._allVehiclesUseCase)
    : super(
        UpdateProfileState(
          profileState: BaseState(),
          profilePhotoState: BaseState(),
          vehiclesState: BaseState()
        ),
      );

  Future<void> _updateProfile(ApplyDriverRequest request,{bool isFormData=false}) async {
    emit(state.copyWith(profileState: BaseState(isLoading: true)));
    final response = await _updateProfileUseCase.invoke(request,isFormData: isFormData);
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, error: response.error),
          ),
        );
        break;
    }
  }

  Future<void> _uploadProfilePhoto(File file) async {
    emit(state.copyWith(profilePhotoState: BaseState(isLoading: true)));
    final response = await _profilePhotoUseCase.invoke(file);
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            profilePhotoState: BaseState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            profilePhotoState: BaseState(
              isLoading: false,
              error: response.error,
            ),
          ),
        );
        break;
    }
  }
 Future<void> _getAllVehicles()async{
    emit(state.copyWith(vehiclesState: BaseState(isLoading: true)));
    final result=await _allVehiclesUseCase.invoke();
    emit(state.copyWith(vehiclesState:result.toBaseState()));
 }

  void doIntent(UpdateProfileIntent intent) {
    switch (intent) {
      case UpdateProfileAction():
        _updateProfile(intent.request,isFormData: intent.isFormData);
        break;
      case UploadProfilePhotoAction():
        _uploadProfilePhoto(intent.file);
        break;
      case NavigateToProfileAction():
        streamController.add(NavigateToProfileEvent());
        break;
      case NavigateToChangePasswordAction():
        streamController.add(NavigateToChangePasswordEvent());
        break;
      case UpdateVehicleInitIntent():
        _getAllVehicles();
        break;
    }
  }
}
