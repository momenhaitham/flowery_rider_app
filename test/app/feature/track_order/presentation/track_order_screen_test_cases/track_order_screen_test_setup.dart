import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_item_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/product_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/shipping_address_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/store_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/user_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_details_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_item_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/total_and_payment_method_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/track_order_indecator_widget.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/user_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TrackOrderScreenTestSetup {
  static OrderDetailsModel orderDetailsModel = OrderDetailsModel(
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
            storeLat: "69.123456",
            storeLong: "69.123456",
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
          shippingAddressModel: ShippingAddressModel(street: "mohamed koraaim",city: "alexandria",lat: "69.123456",long: "69.123456")
         );
  static void findConstatntWidgets(){
    expect(find.byType(OrderDetailsCard),findsNWidgets(1));
    expect(find.byType(TotalAndPaymentMethodCard),findsNWidgets(2));
    expect(find.byType(UserAddressCard),findsNWidgets(2));
    expect(find.byType(OrderItemCard),findsNWidgets(1));
    expect(find.byType(Icon),findsNWidgets(7));
    expect(find.byType(TrackOrderIndecatorWidget),findsNWidgets(1)); 
  }      
}