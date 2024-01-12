import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePageFooter extends StatefulWidget {
  const HomePageFooter({super.key});

  @override
  State<HomePageFooter> createState() => _HomePageFooterState();
}

class _HomePageFooterState extends State<HomePageFooter> {
  late Size size = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        Container(
          width: size.width,
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Consumer<MainPageProvider>(
              builder: (context, value, child) {
                if (value.isInit) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: null,
                        child: Row(
                          children: [
                            Icon(
                              Icons.pin_drop,
                              color: AccentColor(context),
                              size: 30,
                            ),
                            Text(
                              value.link.adaptive(value.languages),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrlString("tel://${value.link.phonenumber}",
                              mode: LaunchMode.platformDefault);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: AccentColor(context),
                              size: 30,
                            ),
                            Text(
                              value.link.phonenumber ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrlString("mailto:${value.link.email}");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: AccentColor(context),
                              size: 30,
                            ),
                            Text(
                              value.link.email ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Developed By ULCode | Powered by UNLimitedWorld",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
