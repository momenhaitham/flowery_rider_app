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
  final double? driverLat;
  final double? driverLong;
  final String? userPhone;
  final String? storePhone;
  TrackingModel({this.orderId,
    this.orderState,this.clientName,
    this.clientPhoto,this.clientLat,this.clientLong,this.storeName,this.storePhoto,
    this.storeLat,this.storeLong,this.driverLat,
    this.driverLong,this.userPhone,this.storePhone});
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
      driverLat: json['driverLat'],
      driverLong: json['driverLong'],
      userPhone: json['clientPhoneNumber'],
      storePhone: json['storePhoneNumber'],
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
      'driverLat': driverLat,
      'driverLong': driverLong,
      'clientPhoneNumber': userPhone,
      'storePhoneNumber': storePhone,
    };
  }
}
