import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_rider_app/app/config/base_state/base_state.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view/apply_driver_screen.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_event.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_state.dart';
import 'package:flowery_rider_app/app/feature/apply_driver/presentation/view_model/apply_driver_view_model.dart';
import 'package:flowery_rider_app/app/feature/countries/domain/model/country_entity.dart';
import 'package:flowery_rider_app/app/feature/vehicles/domain/model/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockApplyDriverViewModel extends Mock implements ApplyDriverViewModel {}

class MockStreamController extends Mock
    implements StreamController<ApplyDriverEvent> {}

void main() {
  late MockApplyDriverViewModel mockViewModel;
  late MockStreamController mockStreamController;
  late StreamController<ApplyDriverEvent> actualStreamController;

  setUpAll(() {
    // Register fallback values for any() matchers
    registerFallbackValue(const ApplyDriverState());
  });

  setUp(() {
    mockViewModel = MockApplyDriverViewModel();
    mockStreamController = MockStreamController();
    actualStreamController = StreamController<ApplyDriverEvent>();

    // Setup default stubs
    when(
      () => mockViewModel.streamController,
    ).thenReturn(actualStreamController);
    when(() => mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockViewModel.state).thenReturn(
      ApplyDriverState(
        countriesState: BaseState(data: const [], isLoading: false),
        vehiclesState: BaseState(data: const [], isLoading: false),
      ),
    );
  });

  tearDown(() {
    actualStreamController.close();
  });

  Widget createTestWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: BlocProvider<ApplyDriverViewModel>(
            create: (_) => mockViewModel,
            child: child,
          ),
        ),
      ),
    );
  }

  group('ApplyDriverScreen Widget Tests', () {
    testWidgets('should display app bar with correct title', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Apply'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('should display welcome section', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Welcome!!'), findsOneWidget);
      expect(
        find.textContaining('You want to be a delivery man?'),
        findsOneWidget,
      );
    });

    testWidgets('should display all form input fields', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert - Check field labels
      expect(find.text('Country'), findsOneWidget);
      expect(find.text('First legal name'), findsOneWidget);
      expect(find.text('Second legal name'), findsOneWidget);
      expect(find.text('Vehicle type'), findsOneWidget);
      expect(find.text('Vehicle number'), findsOneWidget);
      expect(find.text('Vehicle license'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Phone number'), findsOneWidget);
      expect(find.text('ID number'), findsOneWidget);
      expect(find.text('ID image'), findsOneWidget);
      expect(find.text('Password'), findsAtLeastNWidgets(1));
      expect(find.text('Confirm password'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
    });

    testWidgets('should display gender options', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Female'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
    });

    testWidgets('should display Continue button', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Continue'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    });

    testWidgets('should display countries in selector when loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockViewModel.state).thenReturn(
        ApplyDriverState(
          countriesState: BaseState(
            data: const [
              CountryEntity(name: 'Egypt', flag: '🇪🇬'),
              CountryEntity(name: 'USA', flag: '🇺🇸'),
            ],
            isLoading: false,
          ),
          vehiclesState: BaseState(data: const [], isLoading: false),
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Country'), findsOneWidget);
      // Selector should be present
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('should display vehicles in dropdown when loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockViewModel.state).thenReturn(
        ApplyDriverState(
          countriesState: BaseState(data: const [], isLoading: false),
          vehiclesState: BaseState(
            data: const [
              VehicleEntity(vehicleType: 'Car'),
              VehicleEntity(vehicleType: 'Motorcycle'),
              VehicleEntity(vehicleType: 'Bicycle'),
            ],
            isLoading: false,
          ),
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Vehicle type'), findsOneWidget);
      expect(find.byType(DropdownButton<VehicleEntity>), findsOneWidget);
    });

    testWidgets('should show loading indicator when countries are loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockViewModel.state).thenReturn(
        ApplyDriverState(
          countriesState: BaseState(isLoading: true, data: const []),
          vehiclesState: BaseState(data: const [], isLoading: false),
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    });

    testWidgets('should show loading indicator when vehicles are loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(() => mockViewModel.state).thenReturn(
        ApplyDriverState(
          countriesState: BaseState(data: const [], isLoading: false),
          vehiclesState: BaseState(isLoading: true, data: const []),
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
    });

    testWidgets('should toggle password visibility when icon is tapped', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Find visibility off icons (initially passwords are hidden)
      final visibilityOffIcons = find.byIcon(Icons.visibility_off);
      expect(
        visibilityOffIcons,
        findsAtLeastNWidgets(2),
      ); // Password + Confirm password

      // Tap the first password visibility icon
      await tester.tap(visibilityOffIcons.first);
      await tester.pumpAndSettle();

      // Assert - At least one icon should now be visibility (not visibility_off)
      expect(find.byIcon(Icons.visibility), findsAtLeastNWidgets(1));
    });

    testWidgets('should show all TextFormField widgets', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert - Should have multiple text input fields
      expect(find.byType(TextFormField), findsAtLeastNWidgets(8));
    });

    testWidgets('should display image upload fields with upload icons', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert - Check for upload icons
      expect(find.byIcon(Icons.upload_outlined), findsAtLeastNWidgets(2));
      expect(find.text('Upload license photo'), findsOneWidget);
      expect(find.text('Upload ID image'), findsOneWidget);
    });

    testWidgets('should render the entire form without overflow', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert - No overflow errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('should have SingleChildScrollView for scrolling', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should have Form widget with FormKey', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('should display BlocBuilder for state management', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.byType(BlocBuilder<ApplyDriverViewModel, ApplyDriverState>),
        findsOneWidget,
      );
    });
  });

  group('ApplyDriverScreen Interaction Tests', () {
    testWidgets('should select gender when tapped', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Find and tap Female option
      final femaleOption = find.text('Female');
      expect(femaleOption, findsOneWidget);

      await tester.tap(femaleOption);
      await tester.pumpAndSettle();

      // No assertion needed - just verify no crash
      expect(tester.takeException(), isNull);
    });

    testWidgets('should allow text input in form fields', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Find first name field by placeholder
      final firstNameField = find.widgetWithText(
        TextFormField,
        'Enter first legal name',
      );

      // Enter text
      await tester.enterText(firstNameField, 'John');
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('John'), findsOneWidget);
    });

    testWidgets('should render continue button as ElevatedButton', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(createTestWidget(const ApplyDriverScreen()));
      await tester.pumpAndSettle();

      // Find Continue button
      final continueButton = find.widgetWithText(ElevatedButton, 'Continue');
      expect(continueButton, findsOneWidget);

      // Assert button is enabled (can be tapped)
      final button = tester.widget<ElevatedButton>(continueButton);
      expect(button.onPressed, isNotNull);
    });
  });
}
