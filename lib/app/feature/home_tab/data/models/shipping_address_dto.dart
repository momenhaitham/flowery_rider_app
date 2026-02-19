import 'package:flowery_rider_app/app/feature/home_tab/domain/models/shipping_address_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shipping_address_dto.g.dart';
@JsonSerializable()
class ShippingAddressDTO {
    @JsonKey(name: "street")
    String? street;
    @JsonKey(name: "city")
    String? city;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "lat")
    String? lat;
    @JsonKey(name: "long")
    String? long;

    ShippingAddressDTO({
        this.street,
        this.city,
        this.phone,
        this.lat,
        this.long,
    });

    factory ShippingAddressDTO.fromJson(Map<String, dynamic> json) => _$ShippingAddressDTOFromJson(json);

    Map<String, dynamic> toJson() => _$ShippingAddressDTOToJson(this);
    ShippingAddressModel toDomain(){
      return ShippingAddressModel(
        city: city,
        street: street
      );
    }
}