import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';

import 'reset_password_event.dart';
import 'package:injectable/injectable.dart';
import 'reset_password_intent.dart';

import '../../../data/model/reset_password_response.dart';
import '../../../domain/request/reset_password_request.dart';
import '../../../domain/use_case/reset_password_use_case.dart';
import 'reset_password_state.dart';
@injectable
class ResetPasswordViewModel extends CustomCubit<ResetPasswordEvent,ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordViewModel(this._resetPasswordUseCase):super(ResetPasswordState
    (resetPasswordState: BaseState()));
  void _resetPassword(ResetPasswordRequest resetPasswordRequest) async{
    emit(state.copyWith(resetPasswordState: BaseState(isLoading: true)));
    final result = await _resetPasswordUseCase.invoke(resetPasswordRequest);
   switch(result){
     case SuccessResponse<ResetPasswordResponse>():
       emit(state.copyWith(resetPasswordState: BaseState(data: result.data)));
       break;
     case ErrorResponse<ResetPasswordResponse>():
       emit(state.copyWith(resetPasswordState: BaseState(error: result.error)));
       break;
   }
  }
  void doIntent(ResetPasswordIntent intent){
    switch(intent){
      case ResetPasswordAction():
        _resetPassword(intent.resetPasswordRequest);
        break;
      case BackNavigationAction():
        streamController.add(BackNavigationEvent());
        break;

    }
  }
}
