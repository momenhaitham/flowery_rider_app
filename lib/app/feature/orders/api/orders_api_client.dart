import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/endpoint/app_endpoint.dart';
import '../data/model/driver_orders_response.dart';

part 'orders_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class OrdersApiClient {
  factory OrdersApiClient(Dio dio) = _OrdersApiClient;

  @GET(AppEndPoint.driverOrders)
  Future<DriverOrdersResponseDto> getDriverOrders(@Query('page') int page);
}
