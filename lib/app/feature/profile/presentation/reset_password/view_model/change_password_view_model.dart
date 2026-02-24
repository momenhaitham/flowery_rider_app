
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/base_state/custom_cubit.dart';
import '../../../domain/request/change_password_request.dart';
import '../../../domain/use_case/change_password_use_case.dart';
import 'change_password_event.dart';
import 'change_password_intent.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordViewModel
    extends CustomCubit<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(ChangePasswordState(changePasswordState: BaseState()));

  void _changePassword(ChangePasswordRequest changePasswordRequest) async {
    emit(state.copyWith(changePasswordState: BaseState(isLoading: true)));
    final result = await _changePasswordUseCase.invoke(changePasswordRequest);
    switch (result) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(changePasswordState: BaseState(data: result.data)),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(changePasswordState: BaseState(error: result.error)),
        );
        break;
    }
  }

  void doIntent(ChangePasswordIntent intent) {
    switch (intent) {
      case ChangePasswordAction():
        _changePassword(intent.changePasswordRequest);
        break;
      case BackToEditProfileNavigationAction():
        streamController.add(BackToEditProfileNavigationEvent());
        break;
    }
  }
}
