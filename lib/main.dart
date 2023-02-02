import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/theme.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences applicationPreference;
  bool isFirstTime;
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      applicationPreference = pref;
      isFirstTime = pref.getBool("isFirstTime");
      if (isFirstTime == null) {
        print("firstTime");
        applicationPreference.setBool("isFirstTime", false);
        applicationPreference.setBool("isDarkTheme", false);
        isDarkTheme = false;
      } else {
        isDarkTheme = applicationPreference.getBool("isDarkTheme");
        if (isDarkTheme) {
          Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: isDarkTheme
          ? 'assets/splash-screen-dark.png'
          : 'assets/splash-screen.png',
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      nextScreen: HomePage(),
      splashTransition: SplashTransition.scaleTransition,
      splashIconSize: 250,
    );
  }
}
