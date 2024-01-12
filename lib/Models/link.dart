import 'dart:convert';

import 'package:hose_basket/Models/languages.dart';

class Link {
  String? id;
  String? locEn;
  String? locAr;
  String? locArm;
  String? locRu;
  String? phonenumber;
  String? email;
  String? fb;
  String? insta;
  String? wtsp;
  String? telegram;

  Link(
      {this.id,
      this.locEn,
      this.locAr,
      this.locArm,
      this.locRu,
      this.phonenumber,
      this.email,
      this.fb,
      this.insta,
      this.wtsp,
      this.telegram});

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locEn = json['loc_en'];
    locAr = json['loc_ar'];
    locArm = json['loc_arm'];
    locRu = json['loc_ru'];
    phonenumber = json['phonenumber'];
    email = json['email'];
    fb = json['fb'];
    insta = json['insta'];
    wtsp = json['wtsp'];
    telegram = json['telegram'];
  }

  static List<Link> ListFromJson(String body) {
    List<dynamic> data = json.decode(body);
    List<Link> output = [];
    for (var element in data) {
      output.add(Link.fromJson(element));
    }
    return output;
  }

  String adaptive(Languages languages) {
    switch (languages) {
      case Languages.English:
        return locEn ?? "";
      case Languages.Arabic:
        return locAr ?? "";
      case Languages.Armenian:
        return locArm ?? "";
      case Languages.Russian:
        return locRu ?? "";
    }
  }
}
