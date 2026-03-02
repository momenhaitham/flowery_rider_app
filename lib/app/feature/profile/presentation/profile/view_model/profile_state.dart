import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../domain/model/driver_entity.dart';


class ProfileState extends Equatable {
  final BaseState<DriverEntity> profileState;
  const ProfileState({required this.profileState});

  ProfileState copyWith({BaseState<DriverEntity>? profileState}) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      // BaseState(
      //   isLoading: profileState?.isLoading ?? this.profileState.isLoading,
      //   data: profileState?.data ?? this.profileState.data,
      //   error: profileState?.error ?? this.profileState.error,
      // ),
    );
  }

  @override
  List<Object?> get props => [profileState];
}

