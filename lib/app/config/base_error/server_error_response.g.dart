// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerErrorResponse _$ServerErrorResponseFromJson(Map<String, dynamic> json) =>
    ServerErrorResponse(
      error: json['error'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ServerErrorResponseToJson(
  ServerErrorResponse instance,
) => <String, dynamic>{'error': instance.error, 'message': instance.message};
