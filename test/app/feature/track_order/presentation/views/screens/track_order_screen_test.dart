import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_item_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/product_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/store_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/user_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_states.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_viewmodel.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/screens/track_order_screen.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_details_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_item_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/total_and_payment_method_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/track_order_indecator_widget.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/user_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'track_order_screen_test.mocks.dart';


@GenerateNiceMocks([MockSpec<TrackOrderViewmodel>()])
void main() {
  late MockTrackOrderViewmodel mockedViewModel;
  SharedPreferences.setMockInitialValues({});
  setUp(()async {
    mockedViewModel = MockTrackOrderViewmodel();
    await EasyLocalization.ensureInitialized();
    final sl = GetIt.instance;
    if (sl.isRegistered<TrackOrderViewmodel>()) {
      sl.unregister<TrackOrderViewmodel>();
    }
    sl.registerSingleton<TrackOrderViewmodel>(mockedViewModel);
  },);

  Widget buildTrackOrderScreen(){
    OrderDetailsModel orderDetailsModel = OrderDetailsModel(
          createdAt: "2026-01-16T21:00:17.474Z",
          orderId: "696abaf4e364ef6140470e8d",
          orderItems: [
            OrderItemModel(
              quantity: 2,
              product: ProductModel(
                productId: "673e2bd91159920171828139",
                productName: "Red Wdding Flower",
                productImage: "",
                productPrice: 250
              ),
            )
          ],
          orderNumber: "#126246",
          paymentMethod: "cash",
          store: StoreModel(
            storeAddress: "123 Fixed Address, City, Country",
            storeImage: "",
            storeName: "Elevate FlowerApp Store",
            storePhone: "1234567890",
          ),
          totalPrice: 500,
          user: UserModel(
            firstName: "Esraa",
            lastName: "samy",
            phone: "01099097432",
            profileImage: ""
          ),
          shippingAddressModel: ShippingAddressModel(street: "mohamed koraaim",city: "alexandria")
         );
      return EasyLocalization(
    supportedLocales: const [Locale('ar'),Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: Builder( // ✅ Builder بيديك context بعد EasyLocalization
      builder: (context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: BlocProvider<MockTrackOrderViewmodel>(
          create: (context) => mockedViewModel,
          child: TrackOrderScreen(orderDetailsModel: orderDetailsModel),
        ),
      ),
    ),
  );
  }


  testWidgets('track order screen with success state and Accepeted status', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() => tester.binding.setSurfaceSize(null));
    when(mockedViewModel.editOrderStateOnFireBase(1)).thenReturn(AppLocale.accepted.tr());
    when(mockedViewModel.editDeliveryStatus(1)).thenReturn(AppLocale.arrivedAtPickuppoint.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(orderState: BaseState(data: 1)));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.value(TrackOrderStates(orderState: BaseState(data: 1))));
    
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pumpAndSettle();
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(6));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1));
    expect(find.byType(Text),findsNWidgets(20));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 1;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.accepted}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.arrivedAtPickuppoint;
    },),findsNWidgets(1));
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.accepted;
    },),findsNWidgets(1));
    
  });

  testWidgets('track order screen with success state and Pick status', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() => tester.binding.setSurfaceSize(null));
    when(mockedViewModel.editOrderStateOnFireBase(2)).thenReturn(AppLocale.picked.tr());
    when(mockedViewModel.editDeliveryStatus(2)).thenReturn(AppLocale.startDeliver.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(orderState: BaseState(data: 2)));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.value(TrackOrderStates(orderState: BaseState(data: 2))));
    
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pumpAndSettle();
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(6));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1));
    expect(find.byType(Text),findsNWidgets(20));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 2;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsNWidgets(2),
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.picked}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.picked;
    },),findsNWidgets(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.startDeliver;
    },),findsNWidgets(1));
    
  });

  testWidgets('track order screen with success state and out for delivery status', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() => tester.binding.setSurfaceSize(null));
    when(mockedViewModel.editOrderStateOnFireBase(3)).thenReturn(AppLocale.outfordelivery.tr());
    when(mockedViewModel.editDeliveryStatus(3)).thenReturn(AppLocale.arrivedTotheuser.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(orderState: BaseState(data: 3)));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.value(TrackOrderStates(orderState: BaseState(data: 3))));
    
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pumpAndSettle();
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(6));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1));
    expect(find.byType(Text),findsNWidgets(20));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 3;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsNWidgets(3),
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.outfordelivery}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.outfordelivery;
    },),findsNWidgets(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.arrivedTotheuser;
    },),findsNWidgets(1));
    
  });
  
  testWidgets('track order screen with success state and arrived status', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() => tester.binding.setSurfaceSize(null));
    when(mockedViewModel.editOrderStateOnFireBase(4)).thenReturn(AppLocale.arrived.tr());
    when(mockedViewModel.editDeliveryStatus(4)).thenReturn(AppLocale.deliveredToTheUser.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(orderState: BaseState(data: 4)));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.value(TrackOrderStates(orderState: BaseState(data: 4))));
    
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pumpAndSettle();
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(6));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1));
    expect(find.byType(Text),findsNWidgets(20));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 4;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsNWidgets(4),
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.arrived}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.arrived;
    },),findsNWidgets(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.deliveredToTheUser;
    },),findsNWidgets(1));
    
  });

  testWidgets('track order screen with success state and delivered status', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() => tester.binding.setSurfaceSize(null));
    when(mockedViewModel.editOrderStateOnFireBase(5)).thenReturn(AppLocale.delivered.tr());
    when(mockedViewModel.editDeliveryStatus(5)).thenReturn(AppLocale.deliveredToTheUser.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(orderState: BaseState(data: 5)));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.value(TrackOrderStates(orderState: BaseState(data: 5))));
    
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pumpAndSettle();
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(6));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1));
    expect(find.byType(Text),findsNWidgets(20));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 5;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsNWidgets(5),
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.delivered}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.delivered;
    },),findsNWidgets(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.deliveredToTheUser &&
      widget.style == ElevatedButton.styleFrom(backgroundColor: AppColors.grayColor);
    },),findsNWidgets(1));
    
  });
  
  testWidgets('track order screen with no internet error state', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    addTearDown(() => tester.binding.setSurfaceSize(null));
    when(mockedViewModel.editOrderStateOnFireBase(1)).thenReturn(AppLocale.accepted.tr());
    when(mockedViewModel.editDeliveryStatus(1)).thenReturn(AppLocale.arrivedAtPickuppoint.tr());
    when(mockedViewModel.state).thenReturn(TrackOrderStates(orderState: BaseState(data: 1,error: Exception("no internet"))));
    when(mockedViewModel.stream).thenAnswer((_) => Stream<TrackOrderStates>.value(TrackOrderStates(orderState: BaseState(data: 1,error: Exception(AppLocale.noInternet.tr())))));
    
    await tester.pumpWidget(buildTrackOrderScreen());
    await tester.pump();
    await tester.pumpAndSettle();
    var allText = tester.widgetList<Text>(find.byType(Text));
    for (var t in allText) {
    print('TEXT FOUND: "${t.data}"');
    }
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(6));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1));
    expect(find.byType(Text),findsNWidgets(23));
    expect(find.byWidgetPredicate((widget) { 
      return widget is TrackOrderIndecatorWidget && widget.orderState == 1;
    },),findsNWidgets(1));
    expect(
      find.descendant(
        of: find.byType(TrackOrderIndecatorWidget),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).color == AppColors.successColor; 
        }),
      ),
      findsNWidgets(1),
    );
    expect(
      find.descendant(
        of: find.byType(OrderDetailsCard),
        matching: find.byWidgetPredicate((widget) {
          return widget is Text && widget.data == "${AppLocale.status.tr()} : ${AppLocale.accepted}" && widget.style!.color == AppColors.successColor;
        }),
      ),
      findsOneWidget,
    );
    
    expect(find.byWidgetPredicate((widget) { 
      return widget is OrderDetailsCard && widget.state == AppLocale.accepted;
    },),findsNWidgets(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is ElevatedButton && widget.child is Text && (widget.child as Text).data == AppLocale.arrivedAtPickuppoint;
      
    },),findsNWidgets(1));
    
    expect(find.byWidgetPredicate((widget) {
      return widget is AlertDialog && widget.content is Text && (widget.content as Text).data == "Exception: ${AppLocale.noInternet.tr()}";
      
    },),findsNWidgets(1));
  });

  
}


// "${AppLocale.status.tr()} : ${AppLocale.accepted}"
//"Exception: no internet"