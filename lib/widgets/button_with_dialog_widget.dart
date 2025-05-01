import 'package:flutter/material.dart';

import '../data/colors/main_colors.dart';
import '../utils/card_of_products.dart';

Widget buttonProductWithDialog({
  required BuildContext context,
  required double width,
  required double height,
  required String product,
  required String productImage,
  required String productDescription,
  required double productPrice,
  required String productStore
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
              image: AssetImage(productImage),
              fit: BoxFit.fill,
              width: width,
              height: height,
              child: InkWell(
                onTap: () {
                  showProductDetails(context, product, productImage, productDescription, productPrice, productStore);
                },
                splashColor: accentLightColor.withOpacity(0.3),
                highlightColor: accentLightColor.withOpacity(0.1),
              ),
            )
        )
    ),
  );
}