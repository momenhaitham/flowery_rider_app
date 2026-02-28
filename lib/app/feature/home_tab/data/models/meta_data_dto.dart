import 'package:flowery_rider_app/app/feature/home_tab/domain/models/meta_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'meta_data_dto.g.dart';
@JsonSerializable()
class MetadataDTO {
    @JsonKey(name: "currentPage")
    int? currentPage;
    @JsonKey(name: "totalPages")
    int? totalPages;
    @JsonKey(name: "totalItems")
    int? totalItems;
    @JsonKey(name: "limit")
    int? limit;

    MetadataDTO({
        this.currentPage,
        this.totalPages,
        this.totalItems,
        this.limit,
    });

    factory MetadataDTO.fromJson(Map<String, dynamic> json) => _$MetadataDTOFromJson(json);

    Map<String, dynamic> toJson() => _$MetadataDTOToJson(this);
    MetaDataModel toDomain(){
      return MetaDataModel(
        currentPage: currentPage,
        limit: limit,
        totalItems: totalItems,
        totalPages: totalPages
      );
    }
}