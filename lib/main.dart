import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/views/home.dart';
import 'package:provider/provider.dart';
import 'helper/theme.dart';
import 'views/home.dart';

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
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/splash-screen.png',
      nextScreen: HomePage(),
      splashTransition: SplashTransition.scaleTransition,
      splashIconSize: 250,
    );
  }
}
