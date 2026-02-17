import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:injectable/injectable.dart';
import '../../../data/model/forget_password_response.dart';
import '../../../domain/request/forget_password_request.dart';
import '../../../domain/use_case/forget_password_use_case.dart';
import 'forget_password_event.dart';
import 'forget_password_intent.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends CustomCubit<ForgetPasswordEvent,ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
   ForgetPasswordViewModel(this._forgetPasswordUseCase):super(ForgetPasswordState
    (forgetPasswordState: BaseState()));

  void _forgetPassword(ForgetPasswordRequest forgetPasswordRequest) async{
    emit(state.copyWith(forgetPasswordState: BaseState(isLoading: true)));
    final result = await _forgetPasswordUseCase.invoke(forgetPasswordRequest);
   switch(result){
     case SuccessResponse<ForgetPasswordResponse>():
       emit(state.copyWith(forgetPasswordState: BaseState(data: result.data)));
       break;
     case ErrorResponse<ForgetPasswordResponse>():
       emit(state.copyWith(forgetPasswordState: BaseState(error: result.error)));
       break;
   }
  }
  void doIntent(ForgetPasswordIntent intent){
    switch(intent){
      case ForgetPasswordAction():
        _forgetPassword(intent.forgetPasswordRequest);
        break;
      case BackToLoginNavigation():
        streamController.add(BackToLoginNavigationEvent());
        break;

    }
  }
}
