import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Helpers/double_helper.dart';
import 'package:hose_basket/Helpers/screen_height.dart';
import 'package:hose_basket/Widgets/HomePage/hexagon.dart';

class HomePageLogo extends StatefulWidget {
  final ValueNotifier<double> offset;
  const HomePageLogo({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  State<HomePageLogo> createState() => _HomePageLogoState();
}

class _HomePageLogoState extends State<HomePageLogo> {
  late Size size = MediaQuery.of(context).size;
  late double imageWidth = size.width * 0.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screenheight(context) - kToolbarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: widget.offset,
            builder: (context, child) {
              return Opacity(
                opacity: widget.offset.value < size.height * 0.5
                    ? 1 -
                        widget.offset.value.getPercentage(0, size.height * 0.5)
                    : 0,
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: 15,
                      spreadRadius: 10,
                      color: BackgroundColor(context),
                    ),
                  ]),
              width: imageWidth,
              child: Image.asset(
                "assets/logo.jpeg",
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: lerpDouble(
                  1,
                  0,
                  widget.offset.value * 0.01 < 1
                      ? widget.offset.value * 0.01
                      : 1)!,
              child: Hexagon(
                color: MainColor(context),
                size: Size(size.height * 0.075, size.height * 0.075),
                child: const LimitedBox(
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
