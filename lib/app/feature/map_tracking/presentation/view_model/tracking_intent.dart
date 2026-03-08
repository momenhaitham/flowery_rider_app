sealed class TrackingIntent {}
class GetTrackingDataIntent extends TrackingIntent{
  final String trackingId;
  GetTrackingDataIntent(this.trackingId);

}
class GoToWhatsAppIntent extends TrackingIntent{
  final String phoneNumber;
  final String message;
  GoToWhatsAppIntent(this.phoneNumber,this.message);
}
class GoToPhoneDialerIntent extends TrackingIntent{
  final String phoneNumber;

  GoToPhoneDialerIntent(this.phoneNumber);
}
