
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/get_remember_me_use_case.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/view_model/splash_event.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/view_model/splash_intent.dart';
import 'package:flowery_rider_app/app/feature/splash/presentation/view_model/splash_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel extends CustomCubit<SplashEvent, SplashState> {
  final GetRememberMeUseCase _getRememberMeUseCase;

  SplashViewModel(this._getRememberMeUseCase)
    : super(SplashState(splashState: BaseState()));

  void doIntent(SplashIntent intent) {
    switch (intent) {
      case NavigateAction():
        {
          _initSplash();
        }
    }
  }

  Future<void> _initSplash() async {
    final rememberMeResult = _getRememberMeUseCase.invoke();
    if (rememberMeResult != null && rememberMeResult == true) {
      _navToHome();
    } else {
      _navToLogin();
    }
  }

  void _navToLogin() {
    Future.delayed(
      const Duration(seconds: 2),
      () => streamController.add(NavigateToLoginEvent()),
    );
  }

  void _navToHome() {
    Future.delayed(
      const Duration(seconds: 2),
      () => streamController.add(NavigateToMainFlowEvent()),
    );
  }
}
