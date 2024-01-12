import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';

class HomePageTitleBox extends StatelessWidget {
  final double height, width, value;
  final String text;
  final bool isFirst, isLast;
  HomePageTitleBox({
    Key? key,
    required this.height,
    required this.width,
    this.value = 1,
    required this.text,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  final AutoSizeGroup autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
        gradient: LinearGradient(
          colors: [MainColor(context), const Color.fromARGB(255, 8, 38, 84)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.black54,
          width: 2,
        ),
        image: DecorationImage(
          image: const AssetImage(
            "assets/hex_pattern.png",
          ),
          fit: BoxFit.cover,
          opacity: 1,
          isAntiAlias: true,
          colorFilter: ColorFilter.mode(
              MainColor(context).withOpacity(0.85), BlendMode.hardLight),
        ),
      ),
      height: height,
      width: width,
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Center(
        child: AutoSizeText(
          text,
          group: autoSizeGroup,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
