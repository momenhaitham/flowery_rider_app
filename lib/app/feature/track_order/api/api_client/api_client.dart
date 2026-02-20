import 'package:dio/dio.dart';
import 'package:flowery_rider_app/app/core/endpoint/app_endpoint.dart';
import 'package:flowery_rider_app/app/feature/track_order/data/models/update_order_state_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class TrackOrderApiClient {
  @factoryMethod
  factory TrackOrderApiClient(Dio dio) = _TrackOrderApiClient;

  


  @PUT(AppEndPoint.updateOrderState)
  Future<UpdateOrderStateDto> updateOrderState({@Body() Map<String,dynamic>? body,@Path("orderId") String? orderId});

}