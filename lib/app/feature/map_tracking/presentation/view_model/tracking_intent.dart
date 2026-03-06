sealed class TrackingIntent {}
class GetTrackingDataIntent extends TrackingIntent{
  final String trackingId;
  GetTrackingDataIntent(this.trackingId);

}