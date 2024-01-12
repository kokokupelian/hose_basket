import 'dart:convert';

import 'package:hose_basket/Helpers/dateTime_helper.dart';

class Carousel {
  late String id, alt_en, alt_ar, alt_arm, alt_ru, img;
  late DateTime? register_date;

  Carousel({
    required this.id,
    required this.alt_ar,
    required this.alt_arm,
    required this.alt_en,
    required this.alt_ru,
    this.register_date,
    required this.img,
  });

  static Carousel fromJson(Map<String, dynamic> element) {
    return Carousel(
      id: element['id'],
      alt_ar: element['alt_ar'],
      alt_arm: element['alt_arm'],
      alt_en: element['alt_en'],
      alt_ru: element['alt_ru'],
      img: element['img'],
      register_date: StringToDate(
        element['register_date'],
      ),
    );
  }

  static List<Carousel> ListFromJSON(String body) {
    List<Carousel> output = [];
    List<dynamic> data = json.decode(body);
    for (Map<String, dynamic> element in data) {
      output.add(fromJson(element));
    }
    return output;
  }
}
