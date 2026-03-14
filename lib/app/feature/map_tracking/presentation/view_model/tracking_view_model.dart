import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/custom_cubit.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/domain/model/tracking_model.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_event.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_intent.dart';
import 'package:flowery_rider_app/app/feature/map_tracking/presentation/view_model/tracking_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/use_case/get_tracking_data_use_case.dart';
@injectable
class TrackingViewModel  extends CustomCubit<TrackingEvent,TrackingState>{
  final GetTrackingDataUseCase _getTrackingDataUseCase;
  TrackingViewModel(this._getTrackingDataUseCase) :
        super(TrackingState(trackingState: BaseState(),
      userAddress: BaseState(),
      storeAddress: BaseState(),
      ));
  void doIntent(TrackingIntent intent){
    switch(intent){
      case GetTrackingDataIntent():
        _getTrackingData(intent.trackingId);
        break;
      case GoToWhatsAppIntent():
        _openWhatsApp(intent.phoneNumber, intent.message);
        break;
      case GoToPhoneDialerIntent():
        _makePhoneCall(intent.phoneNumber);
        break;
    }

  }

  void _getTrackingData(String trackingId) async{
    emit(state.copyWith(trackingState: BaseState(isLoading: true)));
    final response =await _getTrackingDataUseCase.invoke(trackingId);
    switch (response) {
      case SuccessResponse<TrackingModel>():
        emit(
          state.copyWith(
            trackingState: BaseState(isLoading: false, data: response.data),
          ));
        await  _getAddressFromLatLng(userLat:
        double.parse(response.data.clientLat??'0'),
    userLng: double.parse(response.data.clientLong??'0'),
             storeLat:double.parse(response.data.storeLat??'0'),
    storeLng: double.parse(response.data.storeLong??'0'));
        break;
      case ErrorResponse<TrackingModel>():
        emit(
          state.copyWith(
            trackingState: BaseState(isLoading: false, error: response.error),
          ));
        break;
    }
  }


   Future<void> _getAddressFromLatLng({required double userLat,required double userLng,
   required double storeLat,required double storeLng
   }) async {
    try {
      // 1. Fetch userPlace marks from coordinates
      List<Placemark> userPlacemarks = await placemarkFromCoordinates(userLat,userLng);
      List<Placemark> storePlacemarks = await placemarkFromCoordinates(storeLat,storeLng);

      // 2. Pick the first result (usually the most accurate)
      Placemark userPlace = userPlacemarks[0];
      Placemark storePlace = storePlacemarks[0];

      // 3. Construct the address string based on your Figma design needs
      // You can access: street, subLocality, locality, administrativeArea, country, etc.
      emit(state.copyWith(
          userAddress:BaseState(data:  "${userPlace.street}, ${userPlace.subLocality}, ${userPlace.locality}"),
          storeAddress:BaseState(data: "${storePlace.street}, ${storePlace.subLocality}, ${storePlace.locality}")
      ));

    } catch (e,s) {
      emit(state.copyWith(addressError: e.toString()));
    }
  }
  Future<void> _openWhatsApp(String phoneNumber, String message) async {
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    final uri = Uri.parse(url);

    // Check if the URL can be launched
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Crucial for Android 11+
      );
    } else {
      print("Could not launch $url");
    }
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    // The 'tel' scheme opens the dialer
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {

      print('Could not launch dialer for $phoneNumber');
    }
  }
}