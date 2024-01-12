import 'package:flutter/material.dart';
import 'dart:math' as math;

enum HalfHexagon { top, bottom, left, right }

Path HalfHexagonPath(Size size, double radius) {
  Offset center = Offset(size.height * 0.5, size.height * 0.5);
  final path = Path();
  var angle = (math.pi * 2) / 6;
  Offset firstPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
  path.moveTo(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
  for (int i = 1; i <= 3; i++) {
    double x = radius * math.cos(angle * i) + center.dx;
    double y = radius * math.sin(angle * i) + center.dy;
    path.lineTo(x, y);
  }
  return path;
}

class HalfHexagonPainter extends CustomPainter {
  late PaintingStyle paintingStyle;
  late double radius;
  late Color color;
  late double strokeWidth;

  HalfHexagonPainter(
      {required this.radius,
      required this.color,
      this.paintingStyle = PaintingStyle.stroke,
      this.strokeWidth = 4});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(HalfHexagonPath(size, radius), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
