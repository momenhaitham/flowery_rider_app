import 'package:flowery_rider_app/app/feature/home_tab/data/models/product_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_item_dto.g.dart';
@JsonSerializable()
class OrderItemDTO {
    @JsonKey(name: "product")
    ProductDTO? product;
    @JsonKey(name: "price")
    int? price;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "_id")
    String? id;

    OrderItemDTO({
        this.product,
        this.price,
        this.quantity,
        this.id,
    });

    factory OrderItemDTO.fromJson(Map<String, dynamic> json) => _$OrderItemDTOFromJson(json);

    Map<String, dynamic> toJson() => _$OrderItemDTOToJson(this);
    OrderItemModel toDomain(){
      return OrderItemModel(
        product: product?.toDomain(),
        quantity: quantity
      );
    }
}