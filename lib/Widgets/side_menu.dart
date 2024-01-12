import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/page_type.dart';
import 'package:hose_basket/Pages/language_page.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Widgets/HomePage/hexagon.dart';
import 'package:hose_basket/Widgets/Paints/half_hexagon_paint.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 750),
  );
  late final Animation<double> _cornerRadiusAnimation =
      Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.5, curve: Curves.ease),
    ),
  );
  late final Animation<double> _heightAnimation =
      Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1, curve: Curves.ease),
    ),
  );
  late final MainPageProvider _provider =
      Provider.of<MainPageProvider>(context, listen: false);

  late double width =
      window.physicalSize.shortestSide / window.devicePixelRatio;
  late double prefferedWidth = width * 0.5;

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _controller.value -= details.primaryDelta! / prefferedWidth;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() {
      if (_controller.isAnimating ||
          _controller.status == AnimationStatus.completed) return;

      final double flingVelocity =
          details.velocity.pixelsPerSecond.dx / prefferedWidth;
      if (flingVelocity < 0.0) {
        _controller.fling(velocity: math.max(2.0, -flingVelocity));
      } else if (flingVelocity > 0.0) {
        _controller.fling(velocity: math.min(-2.0, -flingVelocity));
      } else {
        _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
          return false;
        } else {
          return true;
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  child: _controller.status == AnimationStatus.forward ||
                          _controller.status == AnimationStatus.completed
                      ? GestureDetector(
                          onTap: () {
                            if (_controller.status ==
                                AnimationStatus.completed) {
                              _controller.reverse();
                            }
                          },
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.black54),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                ),
              ),
              Positioned(
                bottom: lerpDouble(size.height * 0.3, size.height * 0.1,
                    _heightAnimation.value),
                right: lerpDouble(-size.height * 0.05, size.width * 0.05,
                    _cornerRadiusAnimation.value),
                child: GestureDetector(
                  onTap: () {
                    if (_controller.status == AnimationStatus.dismissed) {
                      _controller.forward();
                    }
                  },
                  onHorizontalDragUpdate: _handleDragUpdate,
                  onHorizontalDragEnd: _handleDragEnd,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Hexagon(
                            size: Size(
                              size.height * 0.1,
                              size.height * 0.1,
                            ),
                            color: MainColor(context),
                            halfHexagon: HalfHexagon.top,
                          ),
                          Material(
                            child: Container(
                              color: MainColor(context),
                              height: lerpDouble(
                                  0, size.height * 0.6, _heightAnimation.value),
                              width: size.height * 0.1,
                              child: Opacity(
                                  opacity: _controller.value,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: IconButton(
                                          onPressed: () {
                                            _provider
                                                .setpageType(PageType.HomePage);
                                            _controller.reverse();
                                          },
                                          icon: Icon(
                                            Icons.home,
                                            color: AccentColor(context),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: IconButton(
                                          onPressed: () {
                                            _provider
                                                .setpageType(PageType.Products);
                                            _controller.reverse();
                                          },
                                          icon: Icon(
                                            Icons.category_rounded,
                                            color: AccentColor(context),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.message,
                                            color: AccentColor(context),
                                          ),
                                          onPressed: () {
                                            _provider
                                                .setpageType(PageType.Contact);
                                            _controller.reverse();
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: IconButton(
                                          icon: Icon(Icons.language,
                                              color: AccentColor(context)),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        BackgroundColor(
                                                            context),
                                                    content:
                                                        const LanguagePage(),
                                                    title:
                                                        const Text("Language"),
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: Consumer<MainPageProvider>(
                                          builder: (context, value, child) {
                                            return IconButton(
                                              icon: Icon(
                                                  value.themeMode ==
                                                          ThemeMode.dark
                                                      ? Icons.dark_mode
                                                      : value.themeMode ==
                                                              ThemeMode.light
                                                          ? Icons.light_mode
                                                          : Icons
                                                              .brightness_auto,
                                                  color: AccentColor(context)),
                                              onPressed: () async {
                                                SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                switch (value.themeMode) {
                                                  case ThemeMode.dark:
                                                    value.setthemeMode(
                                                        ThemeMode.light);
                                                    sharedPreferences.setString(
                                                        "theme", "light");
                                                    break;
                                                  case ThemeMode.light:
                                                    value.setthemeMode(
                                                        ThemeMode.system);
                                                    sharedPreferences.setString(
                                                        "theme", "system");
                                                    break;
                                                  case ThemeMode.system:
                                                    value.setthemeMode(
                                                        ThemeMode.dark);
                                                    sharedPreferences.setString(
                                                        "theme", "dark");
                                                    break;
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Hexagon(
                            size: Size(
                              size.height * 0.1,
                              size.height * 0.1,
                            ),
                            color: MainColor(context),
                            halfHexagon: HalfHexagon.bottom,
                          ),
                        ],
                      ),
                      Positioned(
                        left: -size.height * 0.05 + 15,
                        right: 0,
                        child: Opacity(
                          opacity: lerpDouble(1, 0, _controller.value)!,
                          child: _controller.value == 1
                              ? const SizedBox()
                              : Icon(
                                  Icons.menu,
                                  size: 25,
                                  color: AccentColor(context),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
