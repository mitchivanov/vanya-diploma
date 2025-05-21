import 'package:flutter/material.dart';
import 'package:gift_portal/data/icons.dart';

import '../data/colors/main_colors.dart';
import '../pages/distribution_page.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Portal',
      theme: ThemeData(scaffoldBackgroundColor: primaryLightColor),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 53,
          title: Container(
            margin: const EdgeInsets.only(right: 15),
            height: 37,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                print('Submitted: $value');
              },
              decoration: const InputDecoration(
                hintText: 'Поиск...',
                hintStyle: TextStyle(fontSize: 18),
                contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
          leading: IconButton(
            icon: Image.asset(backArrowIcon, color: accentBlueColor),
            onPressed: () {
              Navigator.of(context).pop(MaterialPageRoute(builder: (ctx) => const DistributionPage()));
            },
          ),
        ),
      ),
    );
  }
}