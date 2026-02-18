class ResetPasswordRequest {

  final String email;

  final String newPassword;

  ResetPasswordRequest ({
    required this.email,
    required this.newPassword,
  });



  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "newPassword": newPassword,
    };
  }
}


