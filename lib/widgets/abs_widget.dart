import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/colors/main_colors.dart';

final Uri _url = Uri.parse('https://steamcommunity.com/id/hyperbeast228_337/');

Widget absBox(BuildContext context){

  return Container(
      height: MediaQuery.sizeOf(context).height * 0.27,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: accentLightColor,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
          margin: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 85,
              bottom: 7
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero
                ),
                child: Ink.image(
                  image: const AssetImage('lib/assets/pictures/abs.jpg'),
                  fit: BoxFit.fill,
                  height: MediaQuery.sizeOf(context).height * 0.27,
                  width: MediaQuery.sizeOf(context).width,
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(_url)) {
                        await launchUrl(_url, mode: LaunchMode.inAppBrowserView);
                      } else {
                        throw 'Не удалось открыть $_url';
                      }
                    },
                    splashColor: accentLightColor.withOpacity(0.3),
                    highlightColor: accentLightColor.withOpacity(0.1),
                  ),
                )
            )
          )
      )
  );
}
