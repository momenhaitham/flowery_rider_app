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
      profileState: profileState?? this.profileState,

      profilePhotoState: profilePhotoState?? this.profilePhotoState,

    );
  }

  @override
  List<Object?> get props => [profileState, profilePhotoState];
}
