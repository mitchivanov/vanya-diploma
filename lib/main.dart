//Import main packages
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Import pages
import 'package:gift_app/pages/login_page.dart';
import 'package:gift_app/widgets/transition_clipper.dart';

import 'pages/distribution_page.dart';
import 'package:gift_app/data/colors/main_colors.dart';
import 'utils/cart_model.dart';
import 'utils/favorite_model.dart';

//Start class with starter
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainWindow());
}

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: primaryLightColor,
        primaryColor: accentLightColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: accentLightColor,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: accentGoldColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(accentGoldColor),
            foregroundColor: MaterialStatePropertyAll(ironManRed),
            overlayColor: MaterialStatePropertyAll(accentBlueColor.withOpacity(0.2)),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: accentBlueColor, width: 2),
              ),
            ),
            elevation: MaterialStatePropertyAll(6),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: accentGoldColor),
          titleLarge: TextStyle(color: accentBlueColor, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: ironManMetal,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: accentBlueColor, width: 2),
          ),
          labelStyle: TextStyle(color: accentGoldColor),
        ),
      ),
      builder: (context, child) => FavoriteModel(child: CartModel(child: child ?? const SizedBox.shrink())),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  Route _createRoute({required Widget targetClass}) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) => targetClass,
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var screenSize = MediaQuery.sizeOf(context);
        var centerCircleClipper = Offset(
            screenSize.width / 2, screenSize.height / 2);

        double beginRadius = 0.0;
        double endRadius = screenSize.height * 1.2;

        var radiusTween = Tween(begin: beginRadius, end: endRadius);
        var radiusTweenAnimation = animation.drive(radiusTween);

        return ClipPath(
          clipper: TransitionClipper(
            centerCircleClipper,
            radiusTweenAnimation.value,
          ),
          child: child,
        );
      },
    );
  }

  @override
  void initState(){
    super.initState();
    _resetSession();
    checkLoginStatus();
  }

  void _resetSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
  }

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(_createRoute(targetClass: const DistributionPage()));
    } else {
      Navigator.of(context).pushReplacement(_createRoute(targetClass: const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
