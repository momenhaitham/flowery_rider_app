import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/read_and_write_tokin_usecase.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/model/auth_model.dart';
import 'package:flowery_rider_app/app/feature/auth/domain/use_case/get_auth_use_case.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_events.dart';
import 'package:flowery_rider_app/app/feature/auth/presentation/view_model/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel(this._authUseCase,this._readAndWriteTokinUsecase) : super(LoginStates());

  final LoginUserUseCase _authUseCase;
  final ReadAndWriteTokinUsecase _readAndWriteTokinUsecase;

  void doIntent(LoginEvents event) {
    switch (event) {
      case LoginEvent():
        _login(event.email, event.password, event.rememberMe);
        return;
    }
  }

  Future<void> _login(String email, String password, bool rememberMe) async {
    emit(
      state.copyWith(loginState: BaseState<AuthModel>(isLoading: true)),
    );

    final loginResponse = await _authUseCase.invoke(
        email, password, rememberMe: rememberMe);
    if (isClosed) return;

    switch (loginResponse) {
      case SuccessResponse<AuthModel>():
      if (rememberMe == true) {
        _readAndWriteTokinUsecase.storageDataSourceContract.addToken(loginResponse.data.token!);
      }

        emit(
          state.copyWith(
            loginState: BaseState<AuthModel>(
              data: loginResponse.data,
              isLoading: false,
            ),
          ),
        );
        return;

      case ErrorResponse<AuthModel>():
        emit(
          state.copyWith(
            loginState: BaseState<AuthModel>(
              error: loginResponse.error,
              isLoading: false,
            ),
          ),
        );
        return;
    }
  }
}
