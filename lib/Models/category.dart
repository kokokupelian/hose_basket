import 'dart:convert';

import 'package:hose_basket/Helpers/dateTime_helper.dart';

class Category {
  late String id;
  late String? title_en,
      title_ar,
      title_arm,
      title_ru,
      desc_en,
      desc_ar,
      desc_arm,
      desc_ru,
      img;
  late DateTime? register_date;

  Category({
    required this.id,
    this.title_ar,
    this.title_arm,
    this.title_en,
    this.title_ru,
    this.desc_ar,
    this.desc_arm,
    this.desc_en,
    this.desc_ru,
    this.img,
    this.register_date,
  });

  static Category fromJson(Map<String, dynamic> element) {
    return Category(
      id: element['id'],
      title_ar: element['title_ar'],
      title_arm: element['title_arm'],
      title_en: element['title_en'],
      title_ru: element['title_ru'],
      desc_ar: element['desc_ar'],
      desc_arm: element['desc_arm'],
      desc_en: element['desc_en'],
      desc_ru: element['desc_ru'],
      img: element['img'],
      register_date: StringToDate(
        element['register_date'],
      ),
    );
  }

  static List<Category> ListFromJson(String body) {
    List<dynamic> data = json.decode(body);
    List<Category> output = [];
    for (Map<String, dynamic> element in data) {
      output.add(fromJson(element));
    }
    return output;
  }
}
