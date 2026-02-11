import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';

class VerifyOtpState extends Equatable {
  final BaseState verifyOtpState;

  const VerifyOtpState({required this.verifyOtpState});
  VerifyOtpState copyWith({BaseState? verifyOtpState}){
    return VerifyOtpState(verifyOtpState: verifyOtpState ?? this.verifyOtpState);
  }

  @override
  List<Object?> get props => [verifyOtpState];

}