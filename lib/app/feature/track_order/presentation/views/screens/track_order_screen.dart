import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/core/resources/app_colors.dart';
import 'package:flowery_rider_app/app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:flowery_rider_app/app/feature/track_order/domain/models/order_details_model.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_events.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_states.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/view_model/track_order_viewmodel.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_details_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/order_item_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/total_and_payment_method_card.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/track_order_indecator_widget.dart';
import 'package:flowery_rider_app/app/feature/track_order/presentation/views/widgets/user_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TrackOrderScreen extends StatefulWidget{
  OrderDetailsModel? orderDetailsModel;
  TrackOrderScreen({super.key, this.orderDetailsModel});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  TrackOrderViewmodel viewmodel = getIt<TrackOrderViewmodel>();

  //int activeStep = 0;
  @override
  void initState() {
    viewmodel.doIntent(UpdateOrderStateEvent(body:{"state":"inProgress"},orderId:widget.orderDetailsModel!.orderId!));
    viewmodel.doIntent(AddOrderDocumentToFirebaseEvent(
          body:{
            "clientName":"${widget.orderDetailsModel?.user?.firstName} ${widget.orderDetailsModel?.user?.lastName}",
            "clientPhoneNumber":widget.orderDetailsModel?.user?.phone,
            "orderId":widget.orderDetailsModel?.orderId,
            "orderState":"Accepted",
          } ,
          orderId:widget.orderDetailsModel!.orderId!
          ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //ShowDialogUtils.showLoading(context);
    
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(AppLocale.orderdetails.tr(),style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: SingleChildScrollView(
        child: BlocProvider<TrackOrderViewmodel>(create: (context) => viewmodel,
        
        child:BlocConsumer<TrackOrderViewmodel,TrackOrderStates>(builder: (context, state) {
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              BlocBuilder<TrackOrderViewmodel,TrackOrderStates>(
               builder: (context, state) {
                  return TrackOrderIndecatorWidget(orderState: viewmodel.state.orderState?.data??1,);
                },
              ),
              SizedBox(height: height*0.02,),
              BlocBuilder<TrackOrderViewmodel,TrackOrderStates>(builder: (context, state) {
                return OrderDetailsCard(orderCreatedTime:widget.orderDetailsModel?.createdAt,orderId: widget.orderDetailsModel?.orderNumber,state: viewmodel.editOrderStateOnFireBase(viewmodel.state.orderState?.data),);
              },),
              SizedBox(height: height*0.02,),
              Text(AppLocale.pickupaddress.tr(),style:Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: height*0.02,),
              UserAddressCard(
                usePhoneNumber: widget.orderDetailsModel?.store?.storePhone,
                userAddress: "${widget.orderDetailsModel?.store?.storeAddress}",
                userImage: widget.orderDetailsModel?.store?.storeImage,
                userName: "${widget.orderDetailsModel?.store?.storeName}",
              ),
              SizedBox(height: height*0.02,),
              Text(AppLocale.useraddress.tr(),style:Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: height*0.02,),
              UserAddressCard(
                usePhoneNumber: widget.orderDetailsModel?.user?.phone,
                userAddress: "${widget.orderDetailsModel?.shippingAddressModel?.street},${widget.orderDetailsModel?.shippingAddressModel?.city}",
                userImage: widget.orderDetailsModel?.user?.profileImage,
                userName: "${widget.orderDetailsModel?.user?.firstName} ${widget.orderDetailsModel?.user?.lastName}",
              ),
              SizedBox(height: height*0.02,),
              Text(AppLocale.orderdetails.tr(),style:Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: height*0.02,),
              ListView.builder(itemBuilder:(context, index) {
                return OrderItemCard(
                  orderItemImage:widget.orderDetailsModel?.orderItems?[index].product?.productImage,
                  orderItemPrice: widget.orderDetailsModel?.orderItems?[index].product?.productPrice.toString(),
                  orderItemQuantity:widget.orderDetailsModel?.orderItems?[index].quantity.toString(),
                  orderItemTitle: widget.orderDetailsModel?.orderItems?[index].product?.productName,
                );
              },
              itemCount: widget.orderDetailsModel?.orderItems?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              ),
              SizedBox(height: height*0.02,),
              TotalAndPaymentMethodCard(title: AppLocale.total.tr(),value: widget.orderDetailsModel?.totalPrice.toString(),),
              SizedBox(height: height*0.02,),
              TotalAndPaymentMethodCard(title: AppLocale.paymentmethod.tr(),value: widget.orderDetailsModel?.paymentMethod,),
              SizedBox(height: height*0.02,),
              BlocBuilder<TrackOrderViewmodel,TrackOrderStates>(
               builder: (context, state) {
                  int currentOrderState = viewmodel.state.orderState?.data??1;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: currentOrderState == 5 ? AppColors.grayColor : AppColors.primaryColor),
                    onPressed: (){
                    int newOrderState = viewmodel.state.orderState?.data??1 ;
                    newOrderState++;
                    if(currentOrderState < 5){

                      viewmodel.doIntent(UpdateOrderStateOnFirebaseEvent(
                     currentOrderState:viewmodel.state.orderState!.data! , 
                     body:{
                            "clientName":"${widget.orderDetailsModel?.user?.firstName} ${widget.orderDetailsModel?.user?.lastName}",
                            "clientPhoneNumber":widget.orderDetailsModel?.user?.phone,
                            "orderId":widget.orderDetailsModel?.orderId,
                            "orderState":viewmodel.editOrderStateOnFireBase(newOrderState),
                          } ,
                    orderId:widget.orderDetailsModel!.orderId! 
                     ));
                    if(viewmodel.state.orderState!.data ==1){
                      viewmodel.doIntent(UpdateOrderStateEvent(body:{"state":"inProgress"},orderId:widget.orderDetailsModel!.orderId!));
                    } 

                    }else{
                      viewmodel.doIntent(UpdateOrderStateEvent(body:{"state":"completed"},orderId:widget.orderDetailsModel!.orderId!));
                    }  
                    
                  }, child: Text(viewmodel.editDeliveryStatus(viewmodel.state.orderState?.data)??"")
                  
                  );
                },
              ),
              SizedBox(height: height*0.04,),
            ],
          ),
        );
        }, listener: (context, state) {
          if(state.orderState?.error != null){
                    ShowDialogUtils.showMessage(context,content: state.orderState?.error.toString(),nigActionName: "ok");
          }
        },) ,
        
       ),
      ),
    );
    
    
  
  }
}