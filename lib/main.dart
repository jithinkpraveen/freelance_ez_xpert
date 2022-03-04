import 'package:ez_xpert/screen/auth/login/login_screen.dart';
import 'package:ez_xpert/screen/home_main/home_page.dart';
import 'package:ez_xpert/utils/locator.dart';
import 'package:ez_xpert/utils/share_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  setupLocator();
  await locator<SharedPrefs>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentContext!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: locator<SharedPrefs>().isLogin
          ? const HomePageMain()
          : const LoginScreen(),
    );
  }
}
