import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/profile_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view/widget/profile_photo_widget.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/profile/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'profile_screen_test.mocks.dart';
@GenerateMocks([ProfileViewModel])
void main() {
  late ProfileViewModel viewModel;
late GetIt getIt;
 buildWidget(){
   return MaterialApp(
     onGenerateRoute: (settings) {
       return MaterialPageRoute(
         builder: (_) => const ProfileScreen(),
       );
     },
     home:ProfileScreen(),
   );
 }
 setUp(() {
   viewModel=MockProfileViewModel();
   getIt = GetIt.instance;
   if (getIt.isRegistered<ProfileViewModel>()) {
     getIt.unregister<ProfileViewModel>();
   }
   getIt.registerSingleton<ProfileViewModel>(viewModel);
 },);
  testWidgets('test profile init state with loading',(widgetTester)async {
    when(viewModel.state).thenReturn(ProfileState(profileState: BaseState(isLoading: true)));
    when(viewModel.stream).thenAnswer((_)=>Stream<ProfileState>.value(ProfileState(profileState: BaseState(isLoading: true))));
   await widgetTester.pumpWidget(buildWidget());
    expect(find.byKey(Key('profile_safe_area')),findsOneWidget);
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byKey(Key('profile_padding')),findsOneWidget);
    expect(find.byKey(Key('profile_expanded')),findsOneWidget);
    expect(find.byType(Column),findsNWidgets(2));
    expect(find.byType(Row),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(6));
    expect(find.byType(ListTile),findsNWidgets(2));
    expect(find.byType(Icon),findsNWidgets(5));
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
    expect(find.byKey(Key('loading_center')),findsOneWidget);
    },);
  testWidgets('test profile with error in getting profile data',(widgetTester)async {

    when(viewModel.state).thenReturn(ProfileState(profileState: BaseState(isLoading:false,error:ConnectionError(

    ))));
    when(viewModel.stream).thenAnswer((_)=>Stream<ProfileState>.value(ProfileState(profileState:
    BaseState(isLoading:false,error:ConnectionError()))));
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byKey(Key('profile_safe_area')),findsOneWidget);
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byKey(Key('profile_padding')),findsOneWidget);
    expect(find.byKey(Key('profile_expanded')),findsOneWidget);
    expect(find.byType(Column),findsNWidgets(2));
    expect(find.byType(Row),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(7));
    expect(find.byType(ListTile),findsNWidgets(2));
    expect(find.byType(Icon),findsNWidgets(5));

    expect(find.byType(CircularProgressIndicator),findsNothing);
    expect(find.byKey(Key('loading_center')),findsNothing);
    expect(find.text(AppLocale.connectionFailed.tr()),findsOneWidget);
    },);
  testWidgets('test profile with success in getting profile data',(widgetTester)async {
DriverEntity driverEntity=DriverEntity(firstName: 'ahmed',
    lastName: 'sayed',email: 's@yahoo.com',vehicleType: 'car',phone: '12345',vehicleNumber: '123',photo: 'photo');
    when(viewModel.state).thenReturn(ProfileState(profileState: BaseState(isLoading:false,data:driverEntity )));
    when(viewModel.stream).thenAnswer((_)=>Stream<ProfileState>.value(ProfileState(profileState:
    BaseState(isLoading:false,data: driverEntity))));
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byKey(Key('profile_safe_area')),findsOneWidget);
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byKey(Key('profile_padding')),findsOneWidget);
    expect(find.byKey(Key('profile_expanded')),findsOneWidget);
    expect(find.byType(Column),findsNWidgets(5));
    expect(find.byType(Row),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(12));
    expect(find.byType(CircularProgressIndicator),findsNothing);
    expect(find.byKey(Key('loading_center')),findsNothing);
    expect(find.text(AppLocale.connectionFailed.tr()),findsNothing);
    expect(find.byType(Card),findsNWidgets(2));
    expect(find.byType(ListTile),findsNWidgets(4));
    expect(find.byType(Card),findsNWidgets(2));
    expect(find.byType(Icon),findsNWidgets(7));
    expect(find.byType(ProfilePhotoWidget),findsNWidgets(1));
    expect(find.text('${driverEntity.firstName} ${driverEntity.lastName}'),findsOneWidget);
    expect(find.text(driverEntity.email??''),findsOneWidget);
    expect(find.text(driverEntity.phone??''),findsOneWidget);
    expect(find.text(driverEntity.vehicleType??''),findsOneWidget);
    expect(find.text(driverEntity.vehicleNumber??''),findsOneWidget);
    },);

}