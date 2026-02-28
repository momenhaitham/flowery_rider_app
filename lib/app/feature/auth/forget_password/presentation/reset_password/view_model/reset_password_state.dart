import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
class ResetPasswordState extends Equatable {
  final BaseState resetPasswordState;
  const ResetPasswordState({required this.resetPasswordState});
  ResetPasswordState copyWith({BaseState? resetPasswordState}){
    return ResetPasswordState(resetPasswordState: resetPasswordState ?? this.resetPasswordState);
  }

  @override
  List<Object?> get props => [resetPasswordState];
}


