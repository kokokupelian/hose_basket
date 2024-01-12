import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialMediaTab extends StatelessWidget {
  const SocialMediaTab({super.key});

  String whatsapp(String number) {
    if (Platform.isAndroid) {
      return "whatsapp://send?phone=$number";
    } else if (Platform.isIOS) {
      return "https://wa.me/$number";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? null
            : Colors.black54,
        gradient: Theme.of(context).brightness == Brightness.light
            ? LinearGradient(
                colors: [
                  Colors.grey.shade800,
                  Colors.grey.shade900,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0,
                  0.7,
                ],
              )
            : null,
      ),
      child: Consumer<MainPageProvider>(builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    launchUrlString("https://facebook.com/");
                  },
                  icon: Image.asset(
                    "assets/Icons/facebook.png",
                    color: AccentColor(context),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrlString(whatsapp(value.link.wtsp ?? ""));
                  },
                  icon: Image.asset(
                    "assets/Icons/whatsapp.png",
                    color: AccentColor(context),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrlString("https://instagram.com/");
                  },
                  icon: Image.asset(
                    "assets/Icons/instagram.png",
                    color: AccentColor(context),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrlString("https://www.t.me/${value.link.telegram}");
                  },
                  icon: Image.asset(
                    "assets/Icons/telegram.png",
                    color: AccentColor(context),
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
