import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import '../../../data/model/forget_password_response.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<ForgetPasswordResponse> forgetPasswordState;

  const ForgetPasswordState({required this.forgetPasswordState});

  ForgetPasswordState copyWith(
      {BaseState<ForgetPasswordResponse>? forgetPasswordState}) {
    return ForgetPasswordState(
        forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState);
  }

  @override
  List<Object?> get props => [forgetPasswordState];
  }
