import 'package:flutter/material.dart';

import '../pages/product_list_page.dart';
import 'button_with_image_widget.dart';

Widget categoriesList(BuildContext context){
  var screenSize = MediaQuery.sizeOf(context);
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //First column of the list
        Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea1.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea1.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea1.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea1.jpg',
                targetClass: ProductPage()
            ),
          ],
        ),
        //Second column of the list
        Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea2.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea2.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea2.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea2.jpg',
                targetClass: ProductPage()
            ),
          ],
        ),
        //Third column of the list
        Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea3.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea3.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea3.jpg',
                targetClass: ProductPage()
            ),
            const Padding(padding: EdgeInsets.only(top: 7)),
            buttonWithImg(
                context: context,
                width: screenSize.width*0.28,
                height: screenSize.height*0.16,
                img: 'lib/assets/pictures/idea3.jpg',
                targetClass: ProductPage()
            ),
          ],
        ),
      ],
    ),
  );
}