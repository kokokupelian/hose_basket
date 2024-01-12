import 'package:flutter/material.dart';

import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Widgets/HomePage/home_page_slide_animation.dart';

Path _hexagonContainerPath(Size size, SlideDirection slideDirection) {
  Path path = Path();

  switch (slideDirection) {
    case SlideDirection.LTR:
      path.moveTo(0, 0);
      path.lineTo(size.width - (size.height * 1 / 4), 0);
      path.lineTo(size.width, size.height * 1 / 3);
      path.lineTo(size.width, size.height * 2 / 3);
      path.lineTo(size.width - (size.height * 1 / 4), size.height);
      path.lineTo(0, size.height);
      path.close();

      break;
    case SlideDirection.RTL:
      path.moveTo(size.width, 0);
      path.lineTo(size.height * 1 / 4, 0);
      path.lineTo(0, size.height * 1 / 3);
      path.lineTo(0, size.height * 2 / 3);
      path.lineTo(size.height * 1 / 4, size.height);
      path.lineTo(size.width, size.height);
      path.close();

      break;
  }

  return path;
}

class HexagonContainerPath extends CustomClipper<Path> {
  late final SlideDirection slideDirection;
  HexagonContainerPath({this.slideDirection = SlideDirection.LTR});

  @override
  Path getClip(Size size) {
    return _hexagonContainerPath(size, slideDirection);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HexagonContainerPaint extends CustomPainter {
  late final SlideDirection slideDirection;
  late final BuildContext context;
  HexagonContainerPaint(BuildContext context,
      {this.slideDirection = SlideDirection.LTR});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = MainColor(context)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawPath(_hexagonContainerPath(size, slideDirection), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
