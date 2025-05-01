import 'package:flutter/material.dart';
import 'package:gift_app/data/icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/colors/button_colors.dart';
import '../data/colors/main_colors.dart';
import '../pages/product_list_page.dart';
import '../utils/list_info_home_products.dart';
import 'button_with_dialog_widget.dart';

Widget discountBox(BuildContext context){
  var screenSize = MediaQuery.sizeOf(context);
  return Container(
    height: MediaQuery.sizeOf(context).height * 0.25,
    width: MediaQuery.sizeOf(context).width,
    decoration: BoxDecoration(
        color: accentLightColor,
        borderRadius: BorderRadius.circular(20)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.03 + 10)),
            buttonProductWithDialog(
                context: context,
                width: screenSize.width * 0.28,
                height: screenSize.height * 0.15,
                product: discProducts[0],
                productImage: discProductImages[0],
                productDescription: discProductDescriptions[0],
                productPrice: discProductPrices[0],
                productStore: discProductStore[0]
            ),
            Text(
              'Цена: ${discProductPrices[0].toStringAsFixed(0)}₽  -20%',
              style: const TextStyle(
                color: accentGoldColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                shadows: [Shadow(color: accentBlueColor, blurRadius: 6)],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.03 + 10)),
            buttonProductWithDialog(
                context: context,
                width: screenSize.width * 0.28,
                height: screenSize.height * 0.15,
                product: discProducts[1],
                productImage: discProductImages[1],
                productDescription: discProductDescriptions[1],
                productPrice: discProductPrices[1],
                productStore: discProductStore[1]
            ),
            Text(
              'Цена: ${discProductPrices[1].toStringAsFixed(0)}₽  -15%',
              style: const TextStyle(
                color: accentGoldColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                shadows: [Shadow(color: accentBlueColor, blurRadius: 6)],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.03,
              margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5
              ),
              decoration: BoxDecoration(
                color: discLightColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: discLightColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProductPage()));
                },
                child: Row(
                  children: [
                    Text('Ещё', style: GoogleFonts.gowunBatang(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).height * 0.03 - 10,
                          color: Colors.white,
                        )
                    ),
                    ),
                    const Padding(padding: EdgeInsets.all(3)),
                    Image.asset(arrowIcon, fit: BoxFit.fitHeight,)
                  ],
                ),
              ),
            ),
            buttonProductWithDialog(
                context: context,
                width: screenSize.width * 0.28,
                height: screenSize.height * 0.15,
                product: discProducts[2],
                productImage: discProductImages[2],
                productDescription: discProductDescriptions[2],
                productPrice: discProductPrices[2],
                productStore: discProductStore[2]
            ),
            Text(
              'Цена: ${discProductPrices[2].toStringAsFixed(0)}₽  -10%',
              style: const TextStyle(
                color: accentGoldColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                shadows: [Shadow(color: accentBlueColor, blurRadius: 6)],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}