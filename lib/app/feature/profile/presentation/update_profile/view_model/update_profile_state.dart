import 'package:equatable/equatable.dart';
import '../../../../../config/base_state/base_state.dart';

class UpdateProfileState extends Equatable {
  final BaseState<String> profileState;
  final BaseState<String> profilePhotoState;

  const UpdateProfileState({
    required this.profileState,
    required this.profilePhotoState,
  });

  UpdateProfileState copyWith({
    BaseState<String>? profileState,
    BaseState<String>? profilePhotoState,
  }) {
    return UpdateProfileState(
      profileState: BaseState(
        isLoading: profileState?.isLoading ?? this.profileState.isLoading,
        data: profileState?.data ?? this.profileState.data,
        error: profileState?.error ?? this.profileState.error,
      ),
      profilePhotoState: BaseState(
        isLoading:
            profilePhotoState?.isLoading ?? this.profilePhotoState.isLoading,
        data: profilePhotoState?.data ?? this.profilePhotoState.data,
        error: profilePhotoState?.error ?? this.profilePhotoState.error,
      ),
    );
  }

  @override
  List<Object?> get props => [profileState, profilePhotoState];
}
