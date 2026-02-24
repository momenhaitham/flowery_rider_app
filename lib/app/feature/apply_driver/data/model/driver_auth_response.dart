import 'package:json_annotation/json_annotation.dart';

import '../../../profile/domain/model/driver_entity.dart';

part 'driver_auth_response.g.dart';

@JsonSerializable()
class DriverAuthResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "driver")
  final Driver? driver;
  @JsonKey(name: "token")
  final String? token;

  DriverAuthResponse({this.message, this.driver, this.token});

  factory DriverAuthResponse.fromJson(Map<String, dynamic> json) {
    return _$DriverAuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverAuthResponseToJson(this);
  }
  DriverEntity toDriverEntity() {
    return DriverEntity(
      firstName: driver?.firstName,
      email: driver?.email,
      photo: driver?.photo,
      phone: driver?.phone,
      lastName: driver?.lastName,
      vehicleType: driver?.vehicleType,
      vehicleNumber: driver?.vehicleNumber,
      gender: driver?.gender,
    );
  }
}

@JsonSerializable()
class Driver {
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;
  @JsonKey(name: "NID")
  final String? nationalIdNumber;
  @JsonKey(name: "NIDImg")
  final String? nationalIdImage;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Driver({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nationalIdNumber,
    this.nationalIdImage,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.createdAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return _$DriverFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverToJson(this);
  }
}
