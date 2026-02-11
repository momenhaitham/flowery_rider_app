import 'dart:io';

class ApplyDriverRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String rePassword;
  final String gender;
  final String country;
  final String nationalIdNumber;
  final File nationalIdImage;
  final String vehicleType;
  final String vehicleNumber;
  final File vehicleLicenseImage;
  ApplyDriverRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.rePassword,
    required this.gender,
    required this.country,
    required this.nationalIdNumber,
    required this.nationalIdImage,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicenseImage,
  });
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "password": password,
      "rePassword": rePassword,
      "gender": gender,
      "country": country,
      "NID": nationalIdNumber,
      "NIDImg": nationalIdImage,
      "vehicleType": vehicleType,
      "vehicleNumber": vehicleNumber,
      "vehicleLicense": vehicleLicenseImage,
    };
  }
}
