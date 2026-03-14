class ChangePasswordRequest {
  final String password;

  final String newPassword;

  ChangePasswordRequest({required this.password, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {"password": password, "newPassword": newPassword};
  }
}
