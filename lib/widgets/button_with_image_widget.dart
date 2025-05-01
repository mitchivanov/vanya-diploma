import 'package:flutter/material.dart';

import '../data/colors/main_colors.dart';

Widget buttonWithImg({
    required BuildContext context,
    required double width,
    required double height,
    required String img,
    required Widget targetClass
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero
            ),
            child: Ink.image(
              image: AssetImage(img),
              fit: BoxFit.fill,
              width: width,
              height: height,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => targetClass));
                },
                splashColor: accentLightColor.withOpacity(0.3),
                highlightColor: accentLightColor.withOpacity(0.1),
              ),
            )
        )
    ),
  );
}