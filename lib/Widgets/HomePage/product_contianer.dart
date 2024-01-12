import 'dart:ui';

import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final String imagePath, title;
  final Alignment alignment;
  const ProductContainer(
      {Key? key,
      required this.imagePath,
      required this.title,
      this.alignment = Alignment.topCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.network(imagePath, fit: BoxFit.cover)),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.black54,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: alignment == Alignment.topCenter ? 25 : 0,
                bottom: alignment == Alignment.bottomCenter ? 25 : 0,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
