import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/languages.dart';
import 'package:hose_basket/Models/page_type.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Data/staticLanguages.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Widgets/HomePage/animated_hexagon.dart';
import 'package:hose_basket/Widgets/HomePage/product_contianer.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePageMissionPage extends StatefulWidget {
  final ValueNotifier<double> scrollOffset;
  const HomePageMissionPage({Key? key, required this.scrollOffset})
      : super(key: key);

  @override
  State<HomePageMissionPage> createState() => _HomePageMissionPageState();
}

class _HomePageMissionPageState extends State<HomePageMissionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size size = MediaQuery.of(context).size;

  ValueNotifier<bool> visibility = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Widget> _topCarrousel() {
    MainPageProvider provider =
        Provider.of<MainPageProvider>(context, listen: true);
    List<Widget> output = [];

    if (provider.isInit) {
      List<Product> products = provider.homePageProducts;

      for (var i = 0; i < products.length / 2; i++) {
        String title = products[i].adaptiveTitle(provider.languages);
        output.add(ProductContainer(
          imagePath: products[i].getImagePath(),
          title: title,
        ));
      }
    }

    return output;
  }

  List<Widget> _bottomCarrousel() {
    MainPageProvider provider =
        Provider.of<MainPageProvider>(context, listen: true);
    List<Widget> output = [];

    if (provider.isInit) {
      List<Product> products = provider.homePageProducts;

      for (var i = products.length ~/ 2.toInt(); i < products.length; i++) {
        String title = products[i].adaptiveTitle(provider.languages);
        output.add(ProductContainer(
          imagePath: products[i].getImagePath(),
          title: title,
          alignment: Alignment.bottomCenter,
        ));
      }
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Consumer<MainPageProvider>(
            builder: (context, value, child) {
              return Text(
                StaticLanguages.Product[value.languages] ?? "",
                style: TextStyle(
                    color: AccentColor(context),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        AnimatedHexagon(
          size: Size(
            size.height * 0.45,
            size.height * 0.45,
          ),
          scrollOffset: widget.scrollOffset.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: CarouselSlider(
                  items: [..._topCarrousel()],
                  disableGesture: true,
                  options: CarouselOptions(
                    height: size.height * 0.1,
                    disableCenter: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    autoPlay: true,
                    scrollDirection: Axis.vertical,
                    autoPlayCurve: Curves.ease,
                  ),
                ),
              ),
              Divider(color: AccentColor(context), thickness: 3, height: 3),
              Expanded(
                child: CarouselSlider(
                  items: [..._bottomCarrousel()],
                  disableGesture: true,
                  options: CarouselOptions(
                    height: size.height * 0.1,
                    disableCenter: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    reverse: true,
                    autoPlay: true,
                    scrollDirection: Axis.vertical,
                    autoPlayCurve: Curves.ease,
                  ),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MainPageProvider>(context, listen: false)
                .setpageType(PageType.Products);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MainColor(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            "See All Products",
            style: TextStyle(
              color: AccentColor(context),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Consumer<MainPageProvider>(
            builder: (context, value, child) {
              return Text(
                StaticLanguages.Mission[value.languages] ?? "",
                style: TextStyle(
                  color: AccentColor(context),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: VisibilityDetector(
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0) {
                visibility.value = true;
              }
            },
            key: Key("MissionAndVision"),
            child: Consumer<MainPageProvider>(
              builder: (context, value, child) {
                if (value.isInit) {
                  return Stack(
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Text(
                          value.mission.adaptive(value.languages),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: visibility,
                        builder: (context, child) {
                          return visibility.value ? child! : Container();
                        },
                        child: AnimatedTextKit(
                          key: ValueKey<Languages>(value.languages),
                          animatedTexts: [
                            TyperAnimatedText(
                              value.mission.adaptive(value.languages),
                              textStyle: const TextStyle(fontSize: 18),
                              textAlign: value.languages == Languages.Arabic
                                  ? TextAlign.right
                                  : TextAlign.left,
                              speed: const Duration(
                                milliseconds: 20,
                              ),
                            )
                          ],
                          repeatForever: false,
                          isRepeatingAnimation: false,
                          totalRepeatCount: 1,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
