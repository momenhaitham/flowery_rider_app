import 'package:json_annotation/json_annotation.dart';

part 'server_error_response.g.dart';

@JsonSerializable()
class ServerErrorResponse {
  @JsonKey(name: "error")
  final String? error;
  @JsonKey(name: "message")
  final String? message;


  ServerErrorResponse ({
    this.error,
    this.message
  });

  factory ServerErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$ServerErrorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServerErrorResponseToJson(this);
  }
}