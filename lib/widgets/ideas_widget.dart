import 'package:flutter/material.dart';
import 'package:gift_portal/utils/list_info_home_products.dart';

import '../data/colors/main_colors.dart';
import 'button_with_dialog_widget.dart';

Widget ideasBox(BuildContext context){
  var screenSize = MediaQuery.sizeOf(context);
  return Container(
      height: MediaQuery.sizeOf(context).height - ((MediaQuery.sizeOf(context).height * 0.27) + (MediaQuery.sizeOf(context).height * 0.25)) - 54,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: accentLightColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                buttonProductWithDialog(
                    context: context,
                    width: screenSize.width / 2 - 24,
                    height: (screenSize.height - ((screenSize.height * 0.27) + (screenSize.height * 0.25)) - 72) / 2 - 14,
                    product: ideasProducts[0],
                    productImage: ideasProductImages[0],
                    productDescription: ideasProductDescriptions[0],
                    productPrice: ideasProductPrices[0],
                    productStore: ideasProductStore[0]
                ),
                const Padding(padding: EdgeInsets.all(4)),
                buttonProductWithDialog(
                    context: context,
                    width: screenSize.width / 2 - 24,
                    height: (screenSize.height - ((screenSize.height * 0.27) + (screenSize.height * 0.25)) - 72) / 2 - 14,
                    product: ideasProducts[1],
                    productImage: ideasProductImages[1],
                    productDescription: ideasProductDescriptions[1],
                    productPrice: ideasProductPrices[1],
                    productStore: ideasProductStore[1]
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(11)),
            Column(
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                buttonProductWithDialog(
                    context: context,
                    width: screenSize.width / 2 - 24,
                    height: (screenSize.height - ((screenSize.height * 0.27) + (screenSize.height * 0.25)) - 72) / 2 - 14,
                    product: ideasProducts[2],
                    productImage: ideasProductImages[2],
                    productDescription: ideasProductDescriptions[2],
                    productPrice: ideasProductPrices[2],
                    productStore: ideasProductStore[2]
                ),
                const Padding(padding: EdgeInsets.all(4)),
                buttonProductWithDialog(
                    context: context,
                    width: screenSize.width / 2 - 24,
                    height: (screenSize.height - ((screenSize.height * 0.27) + (screenSize.height * 0.25)) - 72) / 2 - 14,
                    product: ideasProducts[3],
                    productImage: ideasProductImages[3],
                    productDescription: ideasProductDescriptions[3],
                    productPrice: ideasProductPrices[3],
                    productStore: ideasProductStore[3]
                ),
              ],
            ),
          ]
      )
  );
}