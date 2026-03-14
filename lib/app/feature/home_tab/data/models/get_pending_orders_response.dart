import 'package:flowery_rider_app/app/feature/home_tab/data/models/meta_data_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/data/models/order_details_dto.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_pending_orders_response.g.dart';
@JsonSerializable()
class GetPendingOrdersResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "metadata")
    MetadataDTO? metadata;
    @JsonKey(name: "orders")
    List<OrderDetailsDTO>? orders;

    GetPendingOrdersResponse({
        this.message,
        this.metadata,
        this.orders,
    });

    factory GetPendingOrdersResponse.fromJson(Map<String, dynamic> json) => _$GetPendingOrdersResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetPendingOrdersResponseToJson(this);
    GetPendingOrdersResponseModel toDomain(){
      return GetPendingOrdersResponseModel(
        metadata: metadata?.toDomain(),
        orders: orders?.map((e) => e.toDomain(),).toList()
      );
    }
}