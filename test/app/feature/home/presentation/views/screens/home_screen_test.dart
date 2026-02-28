import 'dart:async';

import 'package:flowery_rider_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_events.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/views/screens/home_screen.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_view_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/views/screen/home_tab.dart';
import 'package:flowery_rider_app/app/feature/orders/presentation/views/screen/orders_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'home_screen_test.mocks.dart';
@GenerateMocks([HomeViewModel,HomeTabViewModel])
void main() {
  late MockHomeViewModel mockHomeViewModel;
  late MockHomeTabViewModel mockHomeTabViewModel;
  late GetIt getIt;
  setUp(() {
    mockHomeViewModel=MockHomeViewModel();
    mockHomeTabViewModel=MockHomeTabViewModel();
    getIt=GetIt.instance;
    if(getIt.isRegistered<HomeViewModel>()){
      getIt.unregister<HomeViewModel>();
    }
    if (getIt.isRegistered<HomeTabViewModel>()) {
      getIt.unregister<HomeTabViewModel>();
    }
    getIt.registerSingleton<HomeViewModel>(mockHomeViewModel);
    getIt.registerSingleton<HomeTabViewModel>(mockHomeTabViewModel);
    when(mockHomeViewModel.stream).thenAnswer((_) =>const Stream.empty() ,);
    when(mockHomeViewModel.state).thenReturn(HomeStates(isLoggedIn: true, currAppTab: AppTab.home));
    when(mockHomeViewModel.tabs).thenReturn([
      const HomeTab(),
      const OrdersScreen(),
      const ProfileScreen(),
    ]);
    when(mockHomeTabViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockHomeTabViewModel.state).thenReturn(HomeTabStates());
    when(mockHomeTabViewModel.doIntent(any)).thenAnswer((_) {});
    when(mockHomeTabViewModel.shouldLoadMore(any)).thenReturn(false);
  },);
  tearDown(() {
    if(getIt.isRegistered<HomeViewModel>()){
      getIt.unregister<HomeViewModel>();
    }
  },);
  Widget buildTestableWidget(){
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
  testWidgets('checking home screen rendering in initial state', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeTab), findsOneWidget);
    expect(find.byType(OrdersScreen), findsNothing);
    expect(find.byType(ProfileScreen), findsNothing);
    expect(find.byIcon(Icons.home_outlined),findsOneWidget);
    expect(find.byIcon(CupertinoIcons.person),findsOneWidget);
    expect(mockHomeViewModel.state.currAppTab, equals(AppTab.home));
    expect(find.byType(ImageIcon), findsOneWidget);
  });
  testWidgets('checking the case of switching between multiple tabs', (WidgetTester tester) async{
    final stateController = StreamController<HomeStates>.broadcast();
    when(mockHomeViewModel.stream).thenAnswer((_) => stateController.stream);
    when(mockHomeViewModel.state).thenReturn(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.home)
    );
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byIcon(CupertinoIcons.person));
    await tester.pump();
    final capturedIntents = verify(mockHomeViewModel.doIntent(captureAny)).captured;
    final tabChangeEvents = capturedIntents.whereType<ChangeCurrentTabEvent>();
    expect(tabChangeEvents, isNotEmpty);
    expect(tabChangeEvents.last.tab, AppTab.profile);
    stateController.add(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.profile)
    );
    await tester.pump();
    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeTab), findsNothing);
    expect(find.byType(OrdersScreen), findsNothing);
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined),findsOneWidget);
    expect(find.byIcon(CupertinoIcons.person),findsOneWidget);
    expect(find.byType(ImageIcon), findsOneWidget);
    await tester.tap(find.byType(ImageIcon));
    await tester.pump();
    final capturedIntents2 = verify(mockHomeViewModel.doIntent(captureAny)).captured;
    final tabChangeEvents2 = capturedIntents2.whereType<ChangeCurrentTabEvent>();
    expect(tabChangeEvents2, isNotEmpty);
    expect(tabChangeEvents2.last.tab, AppTab.orders);
    stateController.add(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.orders)
    );
    await tester.pump();
    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeTab), findsNothing);
    expect(find.byType(OrdersScreen), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);
    expect(find.byIcon(Icons.home_outlined),findsOneWidget);
    expect(find.byIcon(CupertinoIcons.person),findsOneWidget);
    expect(find.byType(ImageIcon), findsOneWidget);
  },);
  testWidgets('checking that tabbing the same tab for multiple times does not affect the current tab', (WidgetTester tester) async{
    final stateController = StreamController<HomeStates>.broadcast();
    when(mockHomeViewModel.stream).thenAnswer((_) => stateController.stream);
    when(mockHomeViewModel.state).thenReturn(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.home)
    );
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byIcon(CupertinoIcons.person));
    await tester.pump();
    final capturedIntents = verify(mockHomeViewModel.doIntent(captureAny)).captured;
    final tabChangeEvents = capturedIntents.whereType<ChangeCurrentTabEvent>();
    expect(tabChangeEvents, isNotEmpty);
    expect(tabChangeEvents.last.tab, AppTab.profile);
    stateController.add(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.profile)
    );
    stateController.add(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.profile)
    );
    await tester.pump();
    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeTab), findsNothing);
    expect(find.byType(OrdersScreen), findsNothing);
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined),findsOneWidget);
    expect(find.byIcon(CupertinoIcons.person),findsOneWidget);
    expect(find.byType(ImageIcon), findsOneWidget);
    await tester.tap(find.byIcon(CupertinoIcons.person));
    await tester.pump();
    final capturedIntents2 = verify(mockHomeViewModel.doIntent(captureAny)).captured;
    final tabChangeEvents2 = capturedIntents2.whereType<ChangeCurrentTabEvent>();
    expect(tabChangeEvents2, isNotEmpty);
    expect(tabChangeEvents2.last.tab, AppTab.profile);
    stateController.add(
      HomeStates(isLoggedIn: true, currAppTab: AppTab.profile)
    );
    await tester.pump();
    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeTab), findsNothing);
    expect(find.byType(OrdersScreen), findsNothing);
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined),findsOneWidget);
    expect(find.byIcon(CupertinoIcons.person),findsOneWidget);
    expect(find.byType(ImageIcon), findsOneWidget);
  },);
}