import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';

Widget BaseTextField(BuildContext context,
    {required String label,
    int? maxlines,
    required TextEditingController controller,
    String? errorMessage,
    TextDirection textDirection = TextDirection.ltr,
    TextInputType? keyboardType}) {
  return Directionality(
    textDirection: textDirection,
    child: TextField(
      cursorColor: MainColor(context),
      controller: controller,
      maxLines: maxlines,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MainColor(context)),
        ),
        focusColor: AccentColor(context),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AccentColor(context)),
        ),
        labelText: label,
        alignLabelWithHint: true,
        floatingLabelStyle: TextStyle(color: AccentColor(context)),
        errorText: errorMessage,
      ),
      keyboardType: keyboardType,
    ),
  );
}
