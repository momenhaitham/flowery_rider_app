import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';

class ChangePasswordState extends Equatable {
  final BaseState changePasswordState;

  const ChangePasswordState({required this.changePasswordState});

  ChangePasswordState copyWith({BaseState? changePasswordState}) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }

  @override
  List<Object?> get props => [changePasswordState];
}
