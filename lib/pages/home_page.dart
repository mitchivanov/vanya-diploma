import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/colors/main_colors.dart';
import '../data/icons.dart';
import '../widgets/abs_widget.dart';
import '../widgets/discount_widget.dart';
import '../widgets/ideas_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/transition_clipper.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  Route _createRoute(){
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => const SearchWidget(),
      transitionDuration: const Duration(milliseconds: 1000),
      reverseTransitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var screenSize = MediaQuery.sizeOf(context);
        var centerCircleClipper = Offset(screenSize.width - 50, 20);

        double beginRadius = 0.0;
        double endRadius = screenSize.height*1.2;

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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift app',
      theme: ThemeData(scaffoldBackgroundColor: primaryLightColor),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 53,
          backgroundColor: accentLightColor,
          title: Text('Gift app',
            style: GoogleFonts.merriweather(
              textStyle: const TextStyle(fontSize: 28, color: accentGoldColor, fontWeight: FontWeight.bold, shadows: [Shadow(color: accentBlueColor, blurRadius: 8, offset: Offset(0, 0))]),
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
          actions: <Widget>[
            Padding(padding: const EdgeInsets.only(right: 26.0),
              child: IconButton(
                icon: Image.asset(searchIcon, color: accentBlueColor),
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
              ),
            )
          ],
        ),
        body: Column(
            children: [
              // Abs widget
              absBox(context),
              const Padding(padding: EdgeInsets.only(top: 7)),
              // Discount widget
              discountBox(context),
              const Padding(padding: EdgeInsets.only(top: 7)),
              // Idea widget
              ideasBox(context),
            ]
        ),
      ),
    );
  }
}