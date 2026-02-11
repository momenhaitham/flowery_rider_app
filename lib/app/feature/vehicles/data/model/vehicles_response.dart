import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicles_response.g.dart';

@JsonSerializable()
class VehiclesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "vehicles")
  final List<Vehicles>? vehicles;

  VehiclesResponse({this.message, this.metadata, this.vehicles});

  factory VehiclesResponse.fromJson(Map<String, dynamic> json) {
    return _$VehiclesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehiclesResponseToJson(this);
  }

  List<VehicleEntity>? toVehicleEntity() {
    return vehicles?.map((e) => VehicleEntity(vehicleType: e.type)).toList();
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}

@JsonSerializable()
class Vehicles {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  Vehicles({
    this.Id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) {
    return _$VehiclesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehiclesToJson(this);
  }
}
