import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Widgets/Paints/hexagon_container_paint.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePageSlideAnimation extends StatefulWidget {
  final Widget child;
  final SlideDirection slideDirection;
  final String keyValue;
  final ValueNotifier<double> scrollOffset;
  const HomePageSlideAnimation({
    Key? key,
    required this.child,
    this.slideDirection = SlideDirection.LTR,
    required this.keyValue,
    required this.scrollOffset,
  }) : super(key: key);

  @override
  State<HomePageSlideAnimation> createState() => _HomePageSlideAnimationState();
}

class _HomePageSlideAnimationState extends State<HomePageSlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  double yPosition = 0;
  late final Key _key = Key(widget.keyValue);
  bool isShown = false;
  late GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.scrollOffset.addListener(() {
      _getYPosition();
      if (widget.scrollOffset.value < yPosition) {
        isShown = true;
      } else {
        isShown = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getYPosition() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox box =
          _globalKey.currentContext?.findRenderObject() as RenderBox;
      yPosition = box.localToGlobal(Offset.zero).dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: ((info) {
        if (info.visibleFraction > 0.5 &&
            _controller.status != AnimationStatus.completed) {
          _controller.forward();
        } else if (info.visibleFraction < 0.5) {
          if (isShown) {
            _controller.value = 0;
          }
        }
      }),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return LayoutBuilder(builder: (context, constraints) {
            return Transform.translate(
              offset: Offset(
                  lerpDouble(
                      (widget.slideDirection == SlideDirection.LTR ? -1 : 1) *
                          (size.width / 2),
                      widget.slideDirection == SlideDirection.LTR
                          ? 0
                          : size.width * 0.25,
                      _controller.value)!,
                  0),
              child: Opacity(
                key: _globalKey,
                opacity: _controller.value,
                child: ClipPath(
                  clipper: HexagonContainerPath(
                      slideDirection: widget.slideDirection),
                  child: Container(
                    width: size.width * 0.75,
                    alignment: Alignment.center,
                    color: AccentColor(context),
                    padding: EdgeInsets.fromLTRB(
                        widget.slideDirection == SlideDirection.LTR ? 0 : 2,
                        2,
                        widget.slideDirection == SlideDirection.RTL ? 0 : 2,
                        2),
                    child: ClipPath(
                      clipper: HexagonContainerPath(
                          slideDirection: widget.slideDirection),
                      child: Container(
                        width: size.width * 0.75,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        color: MainColor(context),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

enum SlideDirection { LTR, RTL }
