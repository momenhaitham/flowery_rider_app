class DriverEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? phone;
  String? photo;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  String? gender;


  DriverEntity({this.firstName, this.email, this.phone, this.photo,required this.id,
    this.lastName,this.vehicleType,this.vehicleNumber,this.gender,this.vehicleLicense});
}
