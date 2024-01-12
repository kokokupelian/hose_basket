import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/languages.dart';
import 'package:hose_basket/Data/staticLanguages.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_slide_animation.dart';
import 'package:provider/provider.dart';

class HomePageIntro extends StatefulWidget {
  final ValueNotifier<double> valueNotifier;
  const HomePageIntro({
    Key? key,
    required this.valueNotifier,
  }) : super(key: key);

  @override
  State<HomePageIntro> createState() => _HomePageIntroState();
}

class _HomePageIntroState extends State<HomePageIntro> {
  AutoSizeGroup autoSizeGroup = AutoSizeGroup();

  Widget _textWidget({
    required int index,
    required String text,
    required SlideDirection slideDirection,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: HomePageSlideAnimation(
        keyValue: index.toString(),
        scrollOffset: widget.valueNotifier,
        slideDirection: slideDirection,
        child: Padding(
          padding: slideDirection == SlideDirection.RTL
              ? const EdgeInsets.fromLTRB(35, 0, 10, 0)
              : const EdgeInsets.fromLTRB(10, 0, 35, 0),
          child: AutoSizeText(
            text.trim(),
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? BackgroundColor(context)
                  : Colors.white,
            ),
            textDirection:
                context.watch<MainPageProvider>().languages == Languages.Arabic
                    ? TextDirection.rtl
                    : null,
            softWrap: true,
          ),
        ),
      ),
    );
  }

  List<Widget> _widgets() {
    List<Widget> output = [];
    MainPageProvider provider =
        Provider.of<MainPageProvider>(context, listen: true);

    if (provider.isInit) {
      List<String> data = provider.about.adaptive(provider.languages);
      for (var i = 0; i < data.length; i++) {
        output.add(
          Flexible(
            child: _textWidget(
              index: i,
              text: data[i],
              slideDirection:
                  i % 2 == 0 ? SlideDirection.RTL : SlideDirection.LTR,
            ),
          ),
        );
      }
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Consumer<MainPageProvider>(
                builder: (context, value, child) {
                  return Text(
                    StaticLanguages.About[value.languages] ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AccentColor(context),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          ..._widgets()
        ],
      ),
    );
  }
}
