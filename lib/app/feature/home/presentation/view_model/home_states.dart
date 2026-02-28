import 'package:equatable/equatable.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/app_tab.dart';

class HomeStates extends Equatable{
  final bool isLoggedIn;
  final AppTab currAppTab;
  const HomeStates({required this.isLoggedIn,required this.currAppTab});
  HomeStates copyWith({bool? isLoggedIn, AppTab? currAppTab}) {
    return HomeStates(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currAppTab: currAppTab ?? this.currAppTab,
    );
  }
  @override
  List<Object?> get props => [isLoggedIn, currAppTab];
}