import 'dart:ui';

import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Widgets/Paints/half_hexagon_paint.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedHexagonContainer extends StatefulWidget {
  final Widget child;
  final String keyValue;
  final ValueNotifier<double> scrollOffset;
  const AnimatedHexagonContainer({
    Key? key,
    required this.child,
    required this.keyValue,
    required this.scrollOffset,
  }) : super(key: key);

  @override
  State<AnimatedHexagonContainer> createState() =>
      _AnimatedHexagonContainerState();
}

class _AnimatedHexagonContainerState extends State<AnimatedHexagonContainer>
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
      child: AnimatedDrawing.paths(
        [
          HalfHexagonPath(
              Size(size.width * 0.75, size.height * 0.1), size.height * 0.1),
        ],
        paints: [
          Paint()
            ..color = MainColor(context)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4
        ],
        height: size.height * 0.1,
        width: size.width * 0.75,
        duration: Duration(milliseconds: 500),
        controller: _controller,
      ),
    );
  }
}
