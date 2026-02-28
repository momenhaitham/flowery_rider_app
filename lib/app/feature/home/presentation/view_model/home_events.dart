import 'package:flowery_rider_app/app/feature/home/presentation/view_model/app_tab.dart';

sealed class HomeEvents {}
class GetTokenEvent extends HomeEvents{}
class ChangeCurrentTabEvent extends HomeEvents{
  final AppTab tab;
  ChangeCurrentTabEvent(this.tab);
}