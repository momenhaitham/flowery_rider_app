import 'package:flowery_rider_app/app/feature/home_tab/domain/models/meta_data_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';

class GetPendingOrdersResponseModel {
  MetaDataModel? metadata;
  List<OrderDetailsModel>? orders;
  GetPendingOrdersResponseModel({this.metadata,this.orders});
}