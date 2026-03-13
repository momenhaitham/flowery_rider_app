import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../domain/model/driver_entity.dart';


class ProfileState extends Equatable {
  final BaseState<DriverEntity> profileState;
  final bool? isLogout;
  const ProfileState({required this.profileState,this.isLogout});

  ProfileState copyWith({BaseState<DriverEntity>? profileState,bool? isLogout}) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      isLogout: isLogout??this.isLogout

    );
  }

  @override
  List<Object?> get props => [profileState,isLogout];
}

