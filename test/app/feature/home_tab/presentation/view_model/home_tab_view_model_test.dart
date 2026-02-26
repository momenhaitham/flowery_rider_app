import 'dart:async';

import 'package:flowery_rider_app/app/config/base_response/base_response.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/get_pending_orders_response_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/meta_data_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/home_tab/domain/use_cases/home_tab_use_case.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_events.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:flowery_rider_app/app/feature/home_tab/presentation/view_model/home_tab_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'home_tab_view_model_test.mocks.dart';

@GenerateMocks([HomeTabUseCase])
void main() {
  late HomeTabViewModel homeTabViewModel;
  late MockHomeTabUseCase mockHomeTabUseCase;
  setUpAll(() {
    provideDummy<BaseResponse<GetPendingOrdersResponseModel>>(SuccessResponse<GetPendingOrdersResponseModel>(data: GetPendingOrdersResponseModel()));
    mockHomeTabUseCase=MockHomeTabUseCase();
    homeTabViewModel=HomeTabViewModel(mockHomeTabUseCase);
  },);
  tearDownAll(() {
    homeTabViewModel.close();
  },);
  group('GetInitialOrdersEvent test cases', () {
    test('success case with success response', () async{
      final initialLimit=3;
      final dummyRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(currentPage: 1,limit: initialLimit,totalItems: 300,totalPages: 100),
        orders: [
            OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
            OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
            OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3')
        ]
      );
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponseModel>(data: dummyRes) ,
      );
      final orders = dummyRes.orders;
      final metadata = dummyRes.metadata;
      final totalItems = metadata?.totalItems ?? orders?.length;
      final hasMoreData = orders!.length < totalItems!;
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
      final subscription = homeTabViewModel.stream.listen((state) {
        states.add(state);
        if (states.length == 2) {
         completer.complete();
        }
      });
      homeTabViewModel.doIntent(GetInitialOrdersEvent());
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[0].ordersState?.isLoading, true);
      expect(states[0].ordersState?.data?.isEmpty, true);
      expect(states[0].rejectedOrderIds, <String>{});
      expect(states[1].ordersState?.isLoading, false);
      expect(states[1].ordersState?.data?.length, orders.length);
      expect(states[1].metaData, metadata);
      expect(states[1].hasMoreData, hasMoreData);
      await subscription.cancel();
    },);
    test('error case with error response',()async{
      final initialLimit=3;
      final dummyException=Exception("Network Error");
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=>ErrorResponse<GetPendingOrdersResponseModel>(error: dummyException) ,
      );
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
      final subscription = homeTabViewModel.stream.listen((state) {
        states.add(state);
        if (states.length == 2) {
          completer.complete();
        }
      });
      homeTabViewModel.doIntent(GetInitialOrdersEvent());
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[0].ordersState?.isLoading, true);
      expect(states[0].ordersState?.data?.isEmpty, true);
      expect(states[0].rejectedOrderIds, <String>{});
      expect(states[1].ordersState?.isLoading, false);
      expect(states[1].ordersState?.error, dummyException);
      await subscription.cancel();
    });
  },);
  group('LoadMoreOrdersEvent test cases', () {
    test('success case with success response', () async{
      final initialLimit=3;
      final loadMoreIncrement=5;
      final limit=initialLimit+loadMoreIncrement;
      final dummyInitialRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(
          currentPage: 1,
          limit: initialLimit,
          totalItems: 10,
          totalPages: 4
        ),
        orders: [
          OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
          OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
          OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3')
        ]
      );
      final dummyLoadedMoreRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(
          currentPage: 1,
          limit: limit,
          totalItems: 10,
          totalPages: 2
        ),
        orders: [
          OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
          OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
          OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3'),
          OrderDetailsModel(orderId: 'orderId4',orderNumber: 'orderNumber4'),
          OrderDetailsModel(orderId: 'orderId5',orderNumber: 'orderNumber5'),
          OrderDetailsModel(orderId: 'orderId6',orderNumber: 'orderNumber6'),
          OrderDetailsModel(orderId: 'orderId7',orderNumber: 'orderNumber7'),
          OrderDetailsModel(orderId: 'orderId8',orderNumber: 'orderNumber8'),
        ]
      );
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=> SuccessResponse<GetPendingOrdersResponseModel>(data: dummyInitialRes),
      );
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
      final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==4){
          completer.complete();
        }
      },);
      homeTabViewModel.doIntent(GetInitialOrdersEvent());
      await Future.delayed(Duration(milliseconds: 50));
      when(mockHomeTabUseCase.call(limit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponseModel>(data: dummyLoadedMoreRes) ,
      );
      homeTabViewModel.doIntent(LoadMoreOrdersEvent(currentLoadedCount: initialLimit,incrementBy: loadMoreIncrement));
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[0].ordersState?.isLoading, true);
      expect(states[0].ordersState?.data?.isEmpty, true);
      expect(states[0].hasMoreData, false);
      expect(states[1].ordersState?.isLoading, false);
      expect(states[1].ordersState?.data?.length, 3);
      expect(states[1].metaData, dummyInitialRes.metadata);
      expect(states[1].hasMoreData, true);
      expect(states[2].ordersState?.isLoading, true);
      expect(states[2].ordersState?.data?.length, 3); 
      expect(states[2].hasMoreData, true);
      expect(states[3].ordersState?.isLoading, false);
      expect(states[3].ordersState?.data?.length, 8);
      expect(states[3].metaData, dummyLoadedMoreRes.metadata);
      expect(states[3].hasMoreData, true); 
      expect(states[3].rejectedOrderIds, <String>{});
      await subscription.cancel();
    },);
    test('load more success case with last batch (no more data)', () async{
      final initialLimit=3;
      final loadMoreIncrement=5;
      final limit=initialLimit+loadMoreIncrement;
      final dummyInitialRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(
          currentPage: 1,
          limit: initialLimit,
          totalItems: 8,
          totalPages: 3
        ),
        orders: [
          OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
          OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
          OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3')
        ]
      );
      final dummyLoadedMoreRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(
          currentPage: 1,
          limit: limit,
          totalItems: 8,
          totalPages: 1
        ),
        orders: [
          OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
          OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
          OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3'),
          OrderDetailsModel(orderId: 'orderId4',orderNumber: 'orderNumber4'),
          OrderDetailsModel(orderId: 'orderId5',orderNumber: 'orderNumber5'),
          OrderDetailsModel(orderId: 'orderId6',orderNumber: 'orderNumber6'),
          OrderDetailsModel(orderId: 'orderId7',orderNumber: 'orderNumber7'),
          OrderDetailsModel(orderId: 'orderId8',orderNumber: 'orderNumber8'),
        ]
      );
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=> SuccessResponse<GetPendingOrdersResponseModel>(data: dummyInitialRes),
      );
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
      final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==4){
          completer.complete();
        }
      },);
      homeTabViewModel.doIntent(GetInitialOrdersEvent());
      await Future.delayed(Duration(milliseconds: 50));
      when(mockHomeTabUseCase.call(limit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponseModel>(data: dummyLoadedMoreRes) ,
      );
      homeTabViewModel.doIntent(LoadMoreOrdersEvent(currentLoadedCount: initialLimit,incrementBy: loadMoreIncrement));
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[0].ordersState?.isLoading, true);
      expect(states[0].ordersState?.data?.isEmpty, true);
      expect(states[0].hasMoreData, false);
      expect(states[1].ordersState?.isLoading, false);
      expect(states[1].ordersState?.data?.length, 3);
      expect(states[1].metaData, dummyInitialRes.metadata);
      expect(states[1].hasMoreData, true);
      expect(states[2].ordersState?.isLoading, true);
      expect(states[2].ordersState?.data?.length, 3); 
      expect(states[2].hasMoreData, true);
      expect(states[3].ordersState?.isLoading, false);
      expect(states[3].ordersState?.data?.length, 8);
      expect(states[3].metaData, dummyLoadedMoreRes.metadata);
      expect(states[3].hasMoreData, false); 
      expect(states[3].rejectedOrderIds, <String>{});
      await subscription.cancel();
    },);
    test('error on loading more content', () async{
      final initialLimit=3;
      final loadMoreIncrement=5;
      final limit=initialLimit+loadMoreIncrement;
      final dummyInitialRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(
          currentPage: 1,
          limit: initialLimit,
          totalItems: 10,
          totalPages: 4
        ),
        orders: [
          OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
          OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
          OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3')
        ]
      );
      final dummyLoadedException=Exception("Un known error");
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
      final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==4){
          completer.complete();
        }
      },);
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponseModel>(data: dummyInitialRes) ,
      );
      homeTabViewModel.doIntent(GetInitialOrdersEvent());
      await Future.delayed(Duration(milliseconds: 50));
      when(mockHomeTabUseCase.call(limit)).thenAnswer(
        (_) async=>ErrorResponse<GetPendingOrdersResponseModel>(error: dummyLoadedException) ,
      );
      homeTabViewModel.doIntent(LoadMoreOrdersEvent(currentLoadedCount: initialLimit,incrementBy: loadMoreIncrement));
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[0].ordersState?.isLoading, true);
      expect(states[0].ordersState?.data?.isEmpty, true);
      expect(states[0].hasMoreData, false);
      expect(states[1].ordersState?.isLoading, false);
      expect(states[1].ordersState?.data?.length, 3);
      expect(states[1].metaData, dummyInitialRes.metadata);
      expect(states[1].hasMoreData, true);
      expect(states[2].ordersState?.isLoading, true);
      expect(states[2].ordersState?.data?.length, 3); 
      expect(states[2].hasMoreData, true);
      expect(states[3].ordersState?.isLoading, false);
      expect(states[3].ordersState?.error, dummyLoadedException);
      await subscription.cancel();
    },);
  },);
  group('RejectOrderEvent', () {
    test('should add orderId to rejectedOrderIds set', () async{
      const orderId = 'orderId123';
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
       final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==1){
          completer.complete();
        }
      },);
      homeTabViewModel.doIntent(RejectOrderEvent(orderId: orderId));
      await completer.future.timeout(Duration(seconds: 1));
      expect(states[0].rejectedOrderIds, {orderId});
      await subscription.cancel();
    },);
    test('should add multiple orderIds to rejectedOrderIds set', () async{
      const orderId1 = 'orderId123';
      const orderId2 = 'orderId456';
      final completer = Completer<void>();
      final states = <HomeTabStates>[];
      final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==2){
          completer.complete();
        }
      },);
      homeTabViewModel.doIntent(RejectOrderEvent(orderId: orderId1));
      homeTabViewModel.doIntent(RejectOrderEvent(orderId: orderId2));
      await completer.future.timeout(Duration(seconds: 1));
      expect(states[1].rejectedOrderIds, {orderId1, orderId2});
      await subscription.cancel();
    },);
  },);
  group('RefreshOrderEvent',(){
    test('should refresh data by calling getInitialOrders again', () async{
      final initialLimit=3;
      final dummyRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(currentPage: 1, limit: initialLimit, totalItems: 10, totalPages: 4),
        orders: [
            OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
            OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
            OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3')
        ]
      );
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponseModel>(data: dummyRes) ,
      );
      final completer=Completer<void>();
      final states=<HomeTabStates>[];
      final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==2){
          completer.complete();
        }
      },);
      homeTabViewModel.doIntent(RefreshOrdersEvent());
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[0].ordersState?.isLoading, true);
      expect(states[0].ordersState?.data?.isEmpty, true);
      expect(states[1].ordersState?.isLoading, false);
      expect(states[1].ordersState?.data?.length, 3);
      verify(mockHomeTabUseCase.call(initialLimit)).called(1);
      await subscription.cancel();
    },);
    test('refresh should clear previous rejectedOrderIds', () async{
      const orderId = 'orderId123';
      homeTabViewModel.doIntent(RejectOrderEvent(orderId: orderId));
      await Future.delayed(Duration(milliseconds: 10));
      final initialLimit=3;
      final dummyRes=GetPendingOrdersResponseModel(
        metadata: MetaDataModel(currentPage: 1, limit: initialLimit, totalItems: 10, totalPages: 4),
        orders: [
            OrderDetailsModel(orderId: 'orderId1',orderNumber: 'orderNumber1'),
            OrderDetailsModel(orderId: 'orderId2',orderNumber: 'orderNumber2'),
            OrderDetailsModel(orderId: 'orderId3',orderNumber: 'orderNumber3')
        ]
      );
      when(mockHomeTabUseCase.call(initialLimit)).thenAnswer(
        (_) async=>SuccessResponse<GetPendingOrdersResponseModel>(data: dummyRes) ,
      );
      final completer=Completer<void>();
      final states=<HomeTabStates>[];
      final subscription=homeTabViewModel.stream.listen((state) {
        states.add(state);
        if(states.length==2){
          completer.complete();
        }
      },);
      homeTabViewModel.doIntent(RefreshOrdersEvent());
      await completer.future.timeout(Duration(seconds: 2));
      expect(states[1].rejectedOrderIds, <String>{});
      await subscription.cancel();
    },);
  });
  group('shouldLoadMore function test cases', () {
    test('should return true when all conditions are met', () {
      homeTabViewModel.emit(HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: false,
          data: [
            OrderDetailsModel(orderId: '1'),
            OrderDetailsModel(orderId: '2'),
            OrderDetailsModel(orderId: '3'),
          ]
        ),
        hasMoreData: true
      ));
      final result = homeTabViewModel.shouldLoadMore(2);
      expect(result, true);
    },);
    test('should return false when isLoading is true', () {
      homeTabViewModel.emit(HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: true,
          data: [
            OrderDetailsModel(orderId: '1'),
          ]
        ),
        hasMoreData: true
      ));
      final result = homeTabViewModel.shouldLoadMore(0);
      expect(result, false);
    },);
    test('should return false when hasMoreData is false', () {
      homeTabViewModel.emit(HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: false,
          data: [
            OrderDetailsModel(orderId: '1'),
          ]
        ),
        hasMoreData: false
      ));
      final result = homeTabViewModel.shouldLoadMore(0);
      expect(result, false);
    },);
    test('should return false when lastVisibleIndex is not at the end', () {
      homeTabViewModel.emit(HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: false,
          data: [
            OrderDetailsModel(orderId: '1'),
            OrderDetailsModel(orderId: '2'),
            OrderDetailsModel(orderId: '3'),
          ]
        ),
        hasMoreData: true
      ));
      final result = homeTabViewModel.shouldLoadMore(1);
      expect(result, false);
    },);
    test('should return false when ordersState is null', () {
      homeTabViewModel.emit(HomeTabStates(
        ordersState: null,
        hasMoreData: true,
      ));
      final result = homeTabViewModel.shouldLoadMore(0);
      expect(result, false);
    });
    test('should return false when data list is empty', () {
      homeTabViewModel.emit(HomeTabStates(
        ordersState: BaseState<List<OrderDetailsModel>>(
          isLoading: false,
          data: []
        ),
        hasMoreData: true,
      ));
      final result = homeTabViewModel.shouldLoadMore(-1);
      expect(result, false);
    });
  },);
}