class TrackingModel {
  final String? orderId;
  final String? orderState;
  final String? clientName;
  final String? clientPhoto;
  final String? clientLat;
  final String? clientLong;
  final String? storeName;
  final String? storePhoto;
  final String? storeLat;
  final String? storeLong;

  TrackingModel({this.orderId,
    this.orderState,this.clientName,
    this.clientPhoto,this.clientLat,this.clientLong,this.storeName,this.storePhoto,this.storeLat,this.storeLong});
  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      orderId: json['orderId'],
      orderState: json['orderState'],
      clientName: json['clientName'],
      clientPhoto: json['clientPhoto'],
      clientLat: json['clientLat'],
      clientLong: json['clientLong'],
      storeName: json['storeName'],
      storePhoto: json['storePhoto'],
      storeLat: json['storeLat'],
      storeLong: json['storeLong'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderState': orderState,
      'clientName': clientName,
      'clientPhoto': clientPhoto,
      'clientLat': clientLat,
      'clientLong': clientLong,
      'storeName': storeName,
      'storePhoto': storePhoto,
      'storeLat': storeLat,
      'storeLong': storeLong,
    };
  }
}
class Address {
  final double? lat;
  final double? long;
  final String? name;
  final String? photo;
  Address({this.lat, this.long, this.name, this.photo});
  factory Address.fromJson({required String tag,required Map<String, dynamic> json}) {
    return Address(
      lat: json['${tag}Lat'],
      long: json['${tag}Long'],
      name: json['${tag}Name'],
      photo: json['${tag}Photo'],
    );
  }
  Map<String, dynamic> toJson({required String tag}) {
    return {
      '${tag}Lat': lat,
      '${tag}Long': long,
      '${tag}Name': name,
      '${tag}Photo': photo,
    };
  }
}