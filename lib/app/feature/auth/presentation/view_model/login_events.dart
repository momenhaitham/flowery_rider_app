sealed class LoginEvents {}

class LoginEvent extends LoginEvents {
  final String email;
  final String password;
  final bool rememberMe;

  LoginEvent(this.email, this.password, this.rememberMe);
}

