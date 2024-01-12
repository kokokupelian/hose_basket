import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:hose_basket/Widgets/Paints/hexagon_paint.dart';

import 'package:visibility_detector/visibility_detector.dart';

class AnimatedHexagon extends StatefulWidget {
  final Size size;
  final double rotation, scrollOffset;
  final Alignment alignment;
  final Widget? child;
  final Offset offset;
  const AnimatedHexagon({
    super.key,
    required this.size,
    this.rotation = 0,
    this.alignment = Alignment.center,
    this.child,
    this.offset = Offset.zero,
    required this.scrollOffset,
  });

  @override
  State<AnimatedHexagon> createState() => _AnimatedHexagonState();
}

class _AnimatedHexagonState extends State<AnimatedHexagon>
    with SingleTickerProviderStateMixin {
  late GlobalKey key = GlobalKey();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  double opacity = 0;
  double widgetDyOffset = 0;
  bool _isShown = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {
          opacity = 1;
        });
      } else if (_controller.value == 0) {
        setState(() {
          opacity = 0;
        });
      }
    });
  }

  _getLocation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
      widgetDyOffset = renderBox.localToGlobal(Offset.zero).dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: ((info) {
        if (info.visibleFraction > 0.25 && !_isShown) {
          _controller.forward();
          _isShown = true;
        }
      }),
      child: Align(
        alignment: widget.alignment,
        child: Transform.translate(
          offset: widget.offset,
          child: Transform.rotate(
            alignment: Alignment.center,
            angle: widget.rotation,
            origin: Offset.zero,
            child: SizedBox(
              height: widget.size.height,
              width: widget.size.width,
              child: Stack(
                children: [
                  AnimatedDrawing.paths(
                    [
                      HexagonPath(widget.size),
                    ],
                    paints: [
                      Paint()
                        ..strokeWidth = 3
                        ..color = AccentColor(context)
                        ..style = PaintingStyle.stroke
                        ..strokeJoin = StrokeJoin.round
                    ],
                    controller: _controller,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 2, bottom: 2, left: 2.5),
                    child: AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 500),
                      child: ClipPath(
                        clipper: HexagonClipper(),
                        child: Container(
                          color: MainColor(context),
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: -widget.rotation,
                            origin: Offset.zero,
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: widget.size.width +
                                    widget.offset.dx * 2 -
                                    10,
                                child: widget.child),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
