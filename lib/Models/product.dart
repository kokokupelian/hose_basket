import 'dart:convert';

import 'package:hose_basket/Helpers/dateTime_helper.dart';
import 'package:hose_basket/Models/languages.dart';

class Product {
  String? id;
  String? titleEn;
  String? titleAr;
  String? titleArm;
  String? titleRu;
  String? descEn;
  String? descAr;
  String? descArm;
  String? descRu;
  String? category;
  String? hash;
  String? img;
  String? tags;
  DateTime? registerDate;

  Product({
    this.id,
    this.titleEn,
    this.titleAr,
    this.titleArm,
    this.titleRu,
    this.descEn,
    this.descAr,
    this.descArm,
    this.descRu,
    this.category,
    this.hash,
    this.img,
    this.tags,
    this.registerDate,
  });

  String getImagePath() {
    return "https://hosebasket.com/cloud/${img}";
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    titleArm = json['title_arm'];
    titleRu = json['title_ru'];
    descEn = json['desc_en'];
    descAr = json['desc_ar'];
    descArm = json['desc_arm'];
    descRu = json['desc_ru'];
    category = json['category'];
    hash = json['hash'];
    img = json['img'];
    tags = json['tags'];
    registerDate = StringToDate(json['register_date'].toString());
  }

  static List<Product> ListFromJson(String body) {
    List<dynamic> data = json.decode(body);
    List<Product> output = [];
    for (Map<String, dynamic> element in data) {
      output.add(Product.fromJson(element));
    }
    return output;
  }

  String adaptiveTitle(Languages languages) {
    switch (languages) {
      case Languages.English:
        return titleEn ?? "";
      case Languages.Arabic:
        return titleAr ?? "";
      case Languages.Armenian:
        return titleArm ?? "";
      case Languages.Russian:
        return titleRu ?? "";
    }
  }

  String adaptiveDesc(Languages languages) {
    switch (languages) {
      case Languages.English:
        return descEn ?? "";
      case Languages.Arabic:
        return descAr ?? "";
      case Languages.Armenian:
        return descArm ?? "";
      case Languages.Russian:
        return descRu ?? "";
    }
  }
}
