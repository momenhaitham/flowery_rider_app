import 'package:json_annotation/json_annotation.dart';

part 'profile_photo_response.g.dart';

@JsonSerializable()
class ProfilePhotoResponse {
  @JsonKey(name: "message")
  final String? message;

  ProfilePhotoResponse({this.message});

  factory ProfilePhotoResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfilePhotoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfilePhotoResponseToJson(this);
  }
}
