import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/get_token_use_case.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_events.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/screen/home_tab.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/views/screen/orders_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class HomeViewModel extends Cubit<HomeStates>{
  final GetTokenUseCase _getTokenUseCase;
  HomeViewModel(this._getTokenUseCase):super(HomeStates(isLoggedIn: false, currAppTab: AppTab.home));
  List<Widget> tabs=[
    HomeTab(),
    OrdersScreen(),
    ProfileScreen()
  ];
  void doIntent(HomeEvents event){
    switch(event){
      
      case GetTokenEvent():
        _getUserToken();
      case ChangeCurrentTabEvent():
        _switchTab(event.tab);
    }
  }
  Future<void> _getUserToken()async{
    final token = await _getTokenUseCase.invoke();
    if(token!=null && token.isNotEmpty){
      emit(state.copyWith(isLoggedIn: true));
    }else{
      emit(state.copyWith(isLoggedIn: false,currAppTab: AppTab.home));
    }
  }
  void _switchTab(AppTab tab){
    emit(state.copyWith(currAppTab: tab));
  }
}