import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Data/staticLanguages.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Widgets/HomePage/hexagon_staggered_widget.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_title_box.dart';
import 'package:provider/provider.dart';

class HomePageTitlePage extends StatefulWidget {
  final ValueNotifier<double> scrollOffset;
  const HomePageTitlePage({Key? key, required this.scrollOffset})
      : super(key: key);

  @override
  State<HomePageTitlePage> createState() => _HomePageTitlePageState();
}

class _HomePageTitlePageState extends State<HomePageTitlePage>
    with SingleTickerProviderStateMixin {
  double topIncrement = 0;
  late Size size = MediaQuery.of(context).size;

  List<Widget> _services() {
    MainPageProvider provider =
        Provider.of<MainPageProvider>(context, listen: true);

    List<Widget> output = [];

    if (provider.isInit) {
      List<String> _services = provider.services.adaptive(provider.languages);

      for (var i = 0; i < _services.length; i++) {
        output.add(
          HomePageTitleBox(
            height: size.width * 0.6,
            width: size.width * 0.6,
            text: _services[i].trim(),
          ),
        );
      }
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Center(
            child: Consumer<MainPageProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 30),
                  child: Text(
                    StaticLanguages.ChooseUs[value.languages] ?? "",
                    style: TextStyle(
                        color: AccentColor(context),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Consumer<MainPageProvider>(builder: (context, value, child) {
              return value.isInit
                  ? HexagonStaggeredWidget(
                      scrollOffset: widget.scrollOffset.value,
                      data: value.chooseUs.adaptive(value.languages))
                  : Container();
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: Consumer<MainPageProvider>(
                builder: (context, value, child) {
                  return Text(
                    StaticLanguages.Services[value.languages] ?? "",
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
          CarouselSlider(
            items: [..._services()],
            options: CarouselOptions(
              height: size.width * 0.6,
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              autoPlay: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              enlargeFactor: 0.5,
              autoPlayCurve: Curves.linearToEaseOut,
            ),
          ),
        ],
      ),
    );
  }
}
