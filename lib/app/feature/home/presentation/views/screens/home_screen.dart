import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/resources/assets_manager.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_events.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel=getIt<HomeViewModel>();
  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetTokenEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: viewModel,
      child: BlocBuilder<HomeViewModel,HomeStates>(
        builder: (context, state) {
          List<BottomNavigationBarItem>bottomNavBarItems = buildNavItems(
              context, viewModel.state);
          return Scaffold(
            body: IndexedStack(
              index: state.currAppTab.index,
              children: viewModel.tabs,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.borderBottomNavBarColor,width: 1))
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.whiteColor,
                currentIndex: state.currAppTab.index,
                onTap: (index) {
                  final tab=AppTab.values[index];
                  context.read<HomeViewModel>().doIntent(
                      ChangeCurrentTabEvent(tab));
                },
                items: bottomNavBarItems
              ),
            ),
          );
        },
      ),
    );
  }
  List<BottomNavigationBarItem> buildNavItems(BuildContext context,
      HomeStates state) {
    final items = [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
          label: AppLocale.home.tr()),
      BottomNavigationBarItem(icon: ImageIcon(AssetImage(AssetsImage.orderIconBottomTab)),
          label: AppLocale.orders.tr()),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person), label: AppLocale.profile.tr()),
    ];
    return items;
  }
}