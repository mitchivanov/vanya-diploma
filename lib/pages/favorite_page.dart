import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/icons.dart';

class FavoritePage extends StatelessWidget{
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift app',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF00FFF0)),
      home: Scaffold(
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        appBar: AppBar(
          toolbarHeight: 53,
          title: Text('Favorite',
            style: GoogleFonts.merriweather(
              textStyle: const TextStyle(fontSize: 28),
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
                icon: Image.asset(searchIcon),
                onPressed: () {  },
              ),
            )
          ],
        ),
      ),
    );
  }
}