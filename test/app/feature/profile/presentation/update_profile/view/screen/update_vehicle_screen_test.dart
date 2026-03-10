import 'package:flowery_rider_app/app/config/base_error/custom_exceptions.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/core/app_locale/app_locale.dart';
import 'package:flowery_rider_app/app/feature/profile/domain/model/driver_entity.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view/screen/update_vehicle_screen.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_event.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_state.dart';
import 'package:flowery_rider_app/app/feature/profile/presentation/update_profile/view_model/update_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_vehicle_screen_test.mocks.dart';
@GenerateMocks([UpdateProfileViewModel])
void main() {
  late UpdateProfileViewModel viewModel;
  late GetIt getIt;
  late   DriverEntity driverEntity;
  buildWidget(){
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => UpdateVehicleScreen(driver: driverEntity),
        );
      },
      home:UpdateVehicleScreen(driver: driverEntity),
    );
  }
  setUp(() {
    viewModel=MockUpdateProfileViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<UpdateProfileViewModel>()) {
      getIt.unregister<UpdateProfileViewModel>();
    }
    getIt.registerSingleton<UpdateProfileViewModel>(viewModel);
    driverEntity=DriverEntity(firstName: 'ahmed',
        lastName: 'sayed',email: 's@yahoo.com',vehicleType: 'car',phone: '12345',vehicleNumber: '123',photo: 'photo');
  },);
  testWidgets('test update vehicle init state with loading',(widgetTester)async {
    when(viewModel.state).thenReturn(UpdateProfileState(profileState: BaseState(isLoading: true),
        profilePhotoState: BaseState(isLoading: true), vehiclesState: BaseState(isLoading: true)));
    when(viewModel.stream).thenAnswer((_)=>Stream<UpdateProfileState>.value(
        UpdateProfileState(profileState: BaseState(isLoading: true,),
          vehiclesState: BaseState(isLoading: true), profilePhotoState: BaseState(isLoading: true))));

    when(viewModel.cubitStream).thenAnswer((_)=>Stream<UpdateProfileEvent>.value(NavigateToProfileEvent()));
    await widgetTester.pumpWidget(buildWidget());
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byType(AppBar),findsOneWidget);
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
    expect(find.byType(TextFormField),findsOneWidget);
    expect(find.byType(ElevatedButton),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(7));

    // expect(find.byType(Column),findsNWidgets(2));
    // expect(find.byType(Row),findsOneWidget);
    // expect(find.byType(Text),findsNWidgets(6));
    // expect(find.byType(ListTile),findsNWidgets(2));
    // expect(find.byType(Icon),findsNWidgets(5));
    // expect(find.byType(CircularProgressIndicator),findsOneWidget);
    // expect(find.byKey(Key('loading_center')),findsOneWidget);
  },);
  testWidgets('test update vehicle success state ',(widgetTester)async {
    when(viewModel.state).thenReturn(UpdateProfileState(profileState: BaseState(data: 'success'),
        profilePhotoState: BaseState(isLoading: true), vehiclesState: BaseState(isLoading: true)));
    when(viewModel.stream).thenAnswer((_)=>Stream<UpdateProfileState>.value(
        UpdateProfileState(profileState: BaseState(data: 'success',),
            vehiclesState: BaseState(isLoading: true), profilePhotoState: BaseState(isLoading: true))));

    when(viewModel.cubitStream).thenAnswer((_)=>Stream<UpdateProfileEvent>.value(NavigateToProfileEvent()));
    await widgetTester.pumpWidget(buildWidget());
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pump();
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byType(AppBar),findsOneWidget);
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
    expect(find.byType(TextFormField),findsOneWidget);
    expect(find.byType(ElevatedButton),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(8));
    expect(find.byType(SnackBar),findsOneWidget);
    },);
  testWidgets('test update vehicle error state ',(widgetTester)async {
    when(viewModel.state).thenReturn(UpdateProfileState(profileState: BaseState(error: UnexpectedError()),
        profilePhotoState: BaseState(isLoading: true), vehiclesState: BaseState(isLoading: true)));
    when(viewModel.stream).thenAnswer((_)=>Stream<UpdateProfileState>.value(
        UpdateProfileState(profileState: BaseState(error: UnexpectedError()),
            vehiclesState: BaseState(isLoading: true), profilePhotoState: BaseState(isLoading: true))));

    when(viewModel.cubitStream).thenAnswer((_)=>Stream<UpdateProfileEvent>.value(NavigateToProfileEvent()));
    await widgetTester.pumpWidget(buildWidget());
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pump();
    expect(find.byType(Scaffold),findsOneWidget);
    expect(find.byType(AppBar),findsOneWidget);
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
    expect(find.byType(TextFormField),findsOneWidget);
    expect(find.byType(ElevatedButton),findsOneWidget);
    expect(find.byType(Text),findsNWidgets(8));
    expect(find.text('${AppLocale.update_profile_error} some thing went error'),findsOneWidget);
    expect(find.byType(SnackBar),findsOneWidget);
  },);

}