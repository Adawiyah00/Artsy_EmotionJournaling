import 'dart:async';
import 'package:flutter/material.dart';
import '../screen/SplashScreen.dart';
import '../store/AppStore.dart';
import '../store/HealthStore.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
AppStore appStore = AppStore();
HealthStore healthStore = HealthStore();

Color defaultLoaderBgColorGlobal = Colors.white;
Color? defaultLoaderAccentColorGlobal = primaryColor;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: AppName,
      theme: ThemeData(brightness: Brightness.light),
      themeMode: ThemeMode.light,
      scrollBehavior: SBehavior(),
    );
  }
}
