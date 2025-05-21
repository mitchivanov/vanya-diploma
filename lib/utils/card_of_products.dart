import 'package:flutter/material.dart';
import 'package:gift_portal/data/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.twitch.tv');

void showProductDetails(BuildContext context, String product, String productImage, String productDescription, double productPrice, String productStore) {
  var screenSize = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.tealAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(product,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: GoogleFonts.afacad(
                      textStyle: const TextStyle(fontSize: 20)),
                ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Image.asset(closeIcon, scale: 0.9)
            )
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenSize.height * 0.3,
              width: screenSize.width,
              child: Image.asset(
                productImage, fit: BoxFit.fill,),
            ),
            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(
                maxHeight: screenSize.height * 0.30
              ),
              padding: const EdgeInsets.all(10),
              // decoration: const BoxDecoration(
              //   color: Colors.green
              // ),
              child: RawScrollbar(
                thumbColor: Colors.teal,
                thickness: 7,
                radius: const Radius.circular(10),
                thumbVisibility: true,
                child: SingleChildScrollView(
                    child: Text(productDescription,
                        style: GoogleFonts.afacad(
                            textStyle: const TextStyle(fontSize: 18))
                    )
                ),
              )
            ),
            const SizedBox(height: 10),
            Text('Цена: \$${productPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            InkWell(
              child: Text('Вы можете преобрести в "$productStore"',
              style: const TextStyle(color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 17
              )),
              onTap: () async {
                if (await canLaunchUrl(_url)) {
                  await launchUrl(_url, mode: LaunchMode.inAppBrowserView);
                } else {
                  throw 'Не удалось открыть $_url';
                }
              },
            )
          ],
        ),
      );
    },
  );
}