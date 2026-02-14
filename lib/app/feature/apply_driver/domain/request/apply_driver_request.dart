import 'dart:io';

class ApplyDriverRequest {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? rePassword;
  final String? gender;
  final String? country;
  final String? nationalIdNumber;
  final File? nationalIdImage;
  final String? vehicleType;
  final String? vehicleNumber;
  final File? vehicleLicenseImage;
  ApplyDriverRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.rePassword,
    this.gender,
    this.country,
    this.nationalIdNumber,
    this.nationalIdImage,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicenseImage,

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
