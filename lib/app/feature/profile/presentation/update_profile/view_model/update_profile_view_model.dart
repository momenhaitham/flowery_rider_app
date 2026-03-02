import 'dart:io';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_intent.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/base_state/custom_cubit.dart';
import '../../../domain/request/update_profile_request.dart';
import '../../../domain/use_case/update_profile_use_case.dart';
import '../../../domain/use_case/upload_profile_photo_use_case.dart';

@injectable
class UpdateProfileViewModel
    extends CustomCubit<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final UploadProfilePhotoUseCase _profilePhotoUseCase;

  UpdateProfileViewModel(this._updateProfileUseCase, this._profilePhotoUseCase)
    : super(
        UpdateProfileState(
          profileState: BaseState(),
          profilePhotoState: BaseState(),
        ),
      );

  Future<void> _updateProfile(UpdateProfileRequest request) async {
    emit(state.copyWith(profileState: BaseState(isLoading: true)));
    final response = await _updateProfileUseCase.invoke(request);
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

  void doIntent(UpdateProfileIntent intent) {
    switch (intent) {
      case UpdateProfileAction():
        _updateProfile(intent.request);
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
    }
  }
}
