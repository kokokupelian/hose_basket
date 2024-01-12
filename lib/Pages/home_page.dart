import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Helpers/double_helper.dart';
import 'package:hose_basket/Helpers/screen_height.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_footer.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_intro.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_logo.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_mission_page.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_title_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  late var backgroundOpacity = 0.7;
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000));
  late Size size = MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _adjustment();
    });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _adjustment() {
    _valueNotifier.value = _scrollController.offset;
    if (_scrollController.offset <= size.height * 0.5) {
      setState(() {
        backgroundOpacity = lerpDouble(0.7, 0.05,
            _scrollController.offset.getPercentage(0, size.height * 0.5))!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: BackgroundColor(context),
          child: Stack(
            children: [
              Positioned(
                height: Screenheight(context),
                width: size.width,
                child: Opacity(
                  opacity: backgroundOpacity,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Container(
                            height: size.height,
                            width: size.width,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  colors: [
                                    Colors.transparent,
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? MainColor(context)
                                        : AccentColor(context).withOpacity(0.3),
                                  ],
                                  center: Alignment.center,
                                  radius: lerpDouble(
                                          3, 0, _animationController.value) ??
                                      0,
                                  stops: [0, 1]),
                            ),
                          );
                        },
                      ),
                      Image.asset(
                        "assets/hex_background.png",
                        fit: BoxFit.cover,
                        height: size.height,
                        width: size.width,
                        color: BackgroundColor(context),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HomePageLogo(
                      offset: _valueNotifier,
                    ),
                    HomePageIntro(
                      valueNotifier: _valueNotifier,
                    ),
                    HomePageTitlePage(
                      scrollOffset: _valueNotifier,
                    ),
                    HomePageMissionPage(
                      scrollOffset: _valueNotifier,
                    ),
                    const HomePageFooter()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
