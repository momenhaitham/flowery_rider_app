class MapTrackingArgument{
  String orderId;
  ChoosableEnum choosableEnum;
  MapTrackingArgument({required this.orderId,this.choosableEnum=ChoosableEnum.isUser});
}
enum ChoosableEnum {
  isUser,
  isStore;
}