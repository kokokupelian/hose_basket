import 'package:flutter/material.dart';

double Screenheight(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}
