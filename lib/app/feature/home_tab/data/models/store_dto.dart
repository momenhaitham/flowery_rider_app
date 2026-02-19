import 'package:flowery_rider_app/app/feature/home_tab/domain/models/store_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'store_dto.g.dart';
@JsonSerializable()
class StoreDTO {
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "image")
    String? image;
    @JsonKey(name: "address")
    String? address;
    @JsonKey(name: "phoneNumber")
    String? phoneNumber;
    @JsonKey(name: "latLong")
    String? latLong;

    StoreDTO({
        this.name,
        this.image,
        this.address,
        this.phoneNumber,
        this.latLong,
    });

    factory StoreDTO.fromJson(Map<String, dynamic> json) => _$StoreDTOFromJson(json);

    Map<String, dynamic> toJson() => _$StoreDTOToJson(this);
    StoreModel toDomain(){
      return StoreModel(
        storeAddress: address,
        storeImage: 'https://flower.elevateegy.com/uploads/$image',
        storeName: name,
        storePhone: phoneNumber,
      );
    }
}