import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:injectable/injectable.dart';
import '../../../data/model/verify_otp_response.dart';
import '../../../domain/request/verify_otp_request.dart';
import '../../../domain/use_case/verify_otp_use_case.dart';
import 'verify_otp_event.dart';
import 'verify_otp_intent.dart';
import 'verify_otp_state.dart';
@injectable
class VerifyOtpViewModel extends CustomCubit<VerifyOtpEvent,VerifyOtpState> {
  final VerifyOtpUseCase _verifyOtpUseCase;
  VerifyOtpViewModel(this._verifyOtpUseCase):super(VerifyOtpState
    (verifyOtpState: BaseState()));
  void _verifyOtp(VerifyOtpRequest otpRequest) async{
    emit(state.copyWith(verifyOtpState: BaseState(isLoading: true)));
    final result = await _verifyOtpUseCase.invoke(otpRequest);
   switch(result){
     case SuccessResponse<VerifyOtpResponse>():
       emit(state.copyWith(verifyOtpState: BaseState(data: result.data)));
       break;
     case ErrorResponse<VerifyOtpResponse>():
       emit(state.copyWith(verifyOtpState: BaseState(error: result.error)));
       break;
   }
  }
  void doIntent(VerifyOtpIntent intent){
    switch(intent){
      case VerifyOtpAction():
        _verifyOtp(intent.verifyOtpRequest);
        break;

      case BackNavigation():
        streamController.add(BackNavigationEvent());
        break;
    }
  }
}
