import 'package:flowery_rider_app/app/feature/home_tab/domain/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_dto.g.dart';
@JsonSerializable()
class ProductDTO {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "slug")
    String? slug;
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "imgCover")
    String? imgCover;
    @JsonKey(name: "images")
    List<String>? images;
    @JsonKey(name: "price")
    int? price;
    @JsonKey(name: "priceAfterDiscount")
    int? priceAfterDiscount;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "category")
    String? category;
    @JsonKey(name: "occasion")
    String? occasion;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;
    @JsonKey(name: "sold")
    int? sold;
    @JsonKey(name: "isSuperAdmin")
    bool? isSuperAdmin;
    @JsonKey(name: "rateAvg")
    int? rateAvg;
    @JsonKey(name: "rateCount")
    int? rateCount;

    ProductDTO({
        this.id,
        this.title,
        this.slug,
        this.description,
        this.imgCover,
        this.images,
        this.price,
        this.priceAfterDiscount,
        this.quantity,
        this.category,
        this.occasion,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.sold,
        this.isSuperAdmin,
        this.rateAvg,
        this.rateCount,
    });

    factory ProductDTO.fromJson(Map<String, dynamic> json) => _$ProductDTOFromJson(json);

    Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
    ProductModel toDomain(){
      return ProductModel(
        productId: id,
        productImage: 'https://flower.elevateegy.com/uploads/$imgCover',
        productName: title,
        productPrice: price,
      );
    }
}