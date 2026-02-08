import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowery_rider_app/app/config/di/di.dart';
import 'package:flowery_rider_app/app/core/routes/app_page.dart';
import 'package:flowery_rider_app/app/core/routes/app_route.dart';
import 'package:flowery_rider_app/app/core/theme/app_theme.dart';
import 'package:flowery_rider_app/app_provider.dart';
import 'package:flowery_rider_app/firebase_options.dart';
import 'package:flutter/material.dart';
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
      create: (context) => appProvider,
      child: EasyLocalization(
      supportedLocales: [Locale('en'),Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      appProvider.getCurrentLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.getRoutes,
      locale: Locale(appProvider.currentLocale!),
      initialRoute: Routes.splash,
    );
  }
}
