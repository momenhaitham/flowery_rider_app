import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  @JsonKey(name: "status")
  final String? status;
  VerifyOtpResponse ({
    this.status,
  });
  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return _$VerifyOtpResponseFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$VerifyOtpResponseToJson(this);
  }
}


