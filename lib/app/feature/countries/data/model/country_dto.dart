import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_dto.g.dart';

@JsonSerializable()
class CountryDto {
  @JsonKey(name: "isoCode")
  final String? isoCode;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "phoneCode")
  final String? phoneCode;
  @JsonKey(name: "flag")
  final String? flag;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: "longitude")
  final String? longitude;
  @JsonKey(name: "timezones")
  final List<Timezones>? timezones;

  CountryDto ({
    this.isoCode,
    this.name,
    this.phoneCode,
    this.flag,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
  });

  factory CountryDto.fromJson(Map<String, dynamic> json) {
    return _$CountryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CountryDtoToJson(this);
  }
  CountryEntity toCountryEntity(){
    return CountryEntity(
      flag: flag,
      name: name
    );
  }
}

@JsonSerializable()
class Timezones {
  @JsonKey(name: "zoneName")
  final String? zoneName;
  @JsonKey(name: "gmtOffset")
  final int? gmtOffset;
  @JsonKey(name: "gmtOffsetName")
  final String? gmtOffsetName;
  @JsonKey(name: "abbreviation")
  final String? abbreviation;
  @JsonKey(name: "tzName")
  final String? tzName;

  Timezones ({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory Timezones.fromJson(Map<String, dynamic> json) {
    return _$TimezonesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TimezonesToJson(this);
  }
}


