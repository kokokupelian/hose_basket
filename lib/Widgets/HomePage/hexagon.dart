import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Widgets/Paints/half_hexagon_paint.dart';
import 'package:hose_basket/Widgets/Paints/hexagon_paint.dart';
import 'dart:math' as math;

class Hexagon extends StatefulWidget {
  final Size size;
  final double rotation;
  final Alignment alignment;
  final Widget? child;
  final Offset offset;
  final HalfHexagon? halfHexagon;
  final Color color;
  const Hexagon(
      {required this.size,
      this.rotation = 0,
      required this.color,
      this.alignment = Alignment.center,
      this.child,
      this.offset = Offset.zero,
      this.halfHexagon});

  @override
  State<Hexagon> createState() => _HexagonState();
}

class _HexagonState extends State<Hexagon> with SingleTickerProviderStateMixin {
  late GlobalKey key = GlobalKey();
  double opacity = 0;
  double widgetDyOffset = 0;

  _getLocation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
      widgetDyOffset = renderBox.localToGlobal(Offset.zero).dy;
    });
  }

  Alignment _halfHexagonAlignemnt() {
    switch (widget.halfHexagon) {
      case HalfHexagon.top:
        return Alignment.bottomCenter;
      case HalfHexagon.bottom:
        return Alignment.topCenter;
      case HalfHexagon.left:
        return Alignment.center;
      case HalfHexagon.right:
        return Alignment.center;
      default:
        return Alignment.center;
    }
  }

  double _halfHexagonRotateDegree() {
    switch (widget.halfHexagon) {
      case HalfHexagon.top:
        return math.pi;
      case HalfHexagon.bottom:
        return 0;
      case HalfHexagon.left:
        return math.pi / 2;
      case HalfHexagon.right:
        return (math.pi * 3) / 2;
      default:
        return 0;
    }
  }

  double _halfHexagonRadius() {
    switch (widget.halfHexagon) {
      case HalfHexagon.top:
      case HalfHexagon.bottom:
        return widget.size.width * 1 / 2;
      case HalfHexagon.left:
      case HalfHexagon.right:
        return widget.size.height * 1 / 2;
      default:
        return widget.size.height;
    }
  }

  Offset _halfHexagonOffset() {
    switch (widget.halfHexagon) {
      case HalfHexagon.left:
        return Offset(widget.size.height / 4, -widget.size.height / 4);
      case HalfHexagon.right:
        return Offset(-widget.size.height / 4, widget.size.height / 4);
      case HalfHexagon.top:
        return Offset(-widget.size.height / 4, widget.size.height / 4);

      case HalfHexagon.bottom:
        return Offset(widget.size.height / 4, -widget.size.height / 4);

      default:
        return Offset.zero;
    }
  }

  Size _halfHexagonSize() {
    switch (widget.halfHexagon) {
      case HalfHexagon.left:
      case HalfHexagon.right:
        return Size(widget.size.width / 2, widget.size.height);
      case HalfHexagon.top:
      case HalfHexagon.bottom:
        return Size(widget.size.width, widget.size.height / 2);
      default:
        return widget.size;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.halfHexagon == null) {
      return Container(
        height: widget.size.height,
        width: widget.size.width,
        alignment: widget.alignment,
        child: Transform.translate(
          offset: widget.offset,
          child: Transform.rotate(
            alignment: Alignment.center,
            angle: widget.rotation,
            origin: Offset.zero,
            child: ClipPath(
              clipper: HexagonClipper(),
              child: Container(
                color: widget.color,
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: -widget.rotation,
                  origin: Offset.zero,
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: widget.size.width + widget.offset.dx * 2 - 10,
                      child: widget.child),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: _halfHexagonSize().height,
        width: _halfHexagonSize().width,
        child: Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: _halfHexagonOffset(),
            child: Transform.rotate(
              angle: _halfHexagonRotateDegree(),
              alignment: Alignment.center,
              child: CustomPaint(
                size: widget.size,
                painter: HalfHexagonPainter(
                    radius: _halfHexagonRadius(),
                    color: MainColor(context),
                    paintingStyle: PaintingStyle.fill),
              ),
            ),
          ),
        ),
      );
    }
  }
}
