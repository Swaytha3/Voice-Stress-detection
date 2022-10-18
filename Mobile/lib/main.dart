import 'package:flutter/material.dart';
import 'package:relax/app_config.dart';
import 'package:relax/db/dbHelper.dart';
import 'package:relax/my_theme.dart';
import 'package:relax/screen/other/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

int? initScreen;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   runApp(MyApp());
// }
// void main() => runApp(MyApp());

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Dbhelper.initDb();
  await GetStorage.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.05),
      statusBarColor: Colors.black.withOpacity(0.05),
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.app_name,
      theme: ThemeData(
        primaryColor: MyTheme.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: MyTheme.accent_color,
        // the below code is getting fonts from http
        // textTheme: GoogleFonts.sourceSansProTextTheme(textTheme).copyWith(
        //   bodyText1: GoogleFonts.sourceSansPro(textStyle: textTheme.bodyText1),
        //   bodyText2: GoogleFonts.sourceSansPro(
        //       textStyle: textTheme.bodyText2, fontSize: 12),
        // ),
      ),
      home: Splash(initScreen:initScreen),
    );
  }
}