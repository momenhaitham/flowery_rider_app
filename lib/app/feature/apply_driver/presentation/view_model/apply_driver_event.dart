sealed class ApplyDriverEvent {}
class ApplyDriverLoadingEvent extends ApplyDriverEvent{

  ApplyDriverLoadingEvent();
}
class ApplyDriverErrorEvent extends ApplyDriverEvent{
  final Exception errorMessage;
  ApplyDriverErrorEvent({required this.errorMessage});
}
class NavigateToLoginEvent extends ApplyDriverEvent{}