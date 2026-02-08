import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/routes/route_generator.dart';
import 'package:flowery_rider_app/app/core/theme/app_theme.dart';
import 'package:flowery_rider_app/app_provider.dart';
import 'package:flowery_rider_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppProvider appProvider = getIt<AppProvider>();
  runApp(
    ChangeNotifierProvider(
      create: (context) => appProvider..getCurrentLocale(context),
      child: EasyLocalization(
      supportedLocales: [Locale('ar'),Locale('en')],
      path: 'assets/translations',
      child: MainApp()
      ),
    )
 );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      //appProvider.getCurrentLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return ScreenUtilInit(
      builder:(context, child) =>  MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: RouteGenerator.getRoutes,
        home: child,
        locale: context.locale,
        initialRoute: Routes.splash,
      ),
    );
  }
}
