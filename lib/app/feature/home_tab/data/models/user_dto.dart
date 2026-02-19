import 'package:flowery_rider_app/app/feature/home_tab/domain/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';
@JsonSerializable()
class UserDTO {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "firstName")
    String? firstName;
    @JsonKey(name: "lastName")
    String? lastName;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "gender")
    String? gender;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "photo")
    String? photo;
    @JsonKey(name: "passwordChangedAt")
    DateTime? passwordChangedAt;
    @JsonKey(name: "passwordResetCode")
    String? passwordResetCode;
    @JsonKey(name: "passwordResetExpires")
    DateTime? passwordResetExpires;
    @JsonKey(name: "resetCodeVerified")
    bool? resetCodeVerified;

    UserDTO({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.phone,
        this.photo,
        this.passwordChangedAt,
        this.passwordResetCode,
        this.passwordResetExpires,
        this.resetCodeVerified,
    });

    factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

    Map<String, dynamic> toJson() => _$UserDTOToJson(this);
    UserModel toDomain(){
      return UserModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        profileImage: 'https://flower.elevateegy.com/uploads/$photo'
      );
    }
}