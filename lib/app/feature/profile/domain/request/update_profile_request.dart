class UpdateProfileRequest {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;

  UpdateProfileRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
  });
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }
}
