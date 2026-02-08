import 'package:flowery_rider_app/app/config/base_state/base_state.dart';

class SplashState {
  final BaseState<String> splashState;

  SplashState({required this.splashState});

  SplashState copyWith({BaseState<String>? splashState}) =>
      SplashState(splashState: splashState ?? this.splashState);
}
