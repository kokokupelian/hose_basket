import 'package:flutter/material.dart';

Color MainColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF020e26)
      : const Color.fromARGB(255, 12, 29, 58);
}

Color AccentColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFff7101)
      : const Color.fromARGB(255, 180, 104, 46);
}

Color BackgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFcacaca)
      : const Color(0xFF121212);
}
