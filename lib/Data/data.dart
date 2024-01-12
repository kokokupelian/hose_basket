import 'dart:convert';

import 'package:hose_basket/Models/about.dart';
import 'package:hose_basket/Models/carousel.dart';
import 'package:hose_basket/Models/category.dart';
import 'package:hose_basket/Models/choose_us.dart';
import 'package:hose_basket/Models/link.dart';
import 'package:hose_basket/Models/mission.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Models/product_sections.dart';
import 'package:hose_basket/Models/services.dart';
import 'package:http/http.dart' as http;

class Data {
  static Uri _getLink(String sub) {
    return Uri.parse("${_link}${sub}");
  }

  static String get _link {
    return "https://en.hosebasket.com/Api/";
  }

  static String get _getAllCarousels {
    return "get_all_carousel.php";
  }

  static String get _getAllCategories {
    return "get_all_categories.php";
  }

  static String get _getAllLinks {
    return "get_all_links.php";
  }

  static String get _getAllProducts {
    return "get_all_products.php";
  }

  static String get _getAllAbout {
    return "get_all_static.php?section=about";
  }

  static String get _getAllChooseUs {
    return "get_all_choose_us.php";
  }

  static String get _getAllServices {
    return "get_all_static.php?section=services";
  }

  static String get _getProductSections {
    return "get_all_static.php?section=products";
  }

  static String get _getAllMission {
    return "get_all_static.php?section=mission";
  }

  static String get _getHomePageProduct {
    return "get_all_services.php";
  }

  static String get _sendMessage {
    return "send_msg.php";
  }

  static Future<List<Carousel>> GetAllCarousel() async {
    var response = await http.Client().get(_getLink(_getAllCarousels));
    if (response.statusCode == 200) {
      return Carousel.ListFromJSON(response.body);
    } else {
      return [];
    }
  }

  static Future<List<Category>> GetAllCategories() async {
    var response = await http.Client().get(_getLink(_getAllCategories));
    if (response.statusCode == 200) {
      return Category.ListFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<List<Product>> GetAllProducts() async {
    var response = await http.Client().get(_getLink(_getAllProducts));
    if (response.statusCode == 200) {
      return Product.ListFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<List<Link>> GetAllLinks() async {
    var response = await http.Client().get(_getLink(_getAllLinks));
    if (response.statusCode == 200) {
      return Link.ListFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<About> GetAllAbout() async {
    var response = await http.Client().get(_getLink(_getAllAbout));
    if (response.statusCode == 200) {
      return About.fromMap(json.decode(response.body) as Map<String, dynamic>);
    } else {
      return const About(english: [], arabic: [], armenian: [], russian: []);
    }
  }

  static Future<ChooseUs> GetAllChooseUS() async {
    var response = await http.Client().get(_getLink(_getAllChooseUs));
    if (response.statusCode == 200) {
      return ChooseUs.fromMap(json.decode(response.body) as List<dynamic>);
    } else {
      return const ChooseUs(english: [], arabic: [], armenian: [], russian: []);
    }
  }

  static Future<Services> GetAllServices() async {
    var response = await http.Client().get(_getLink(_getAllServices));
    if (response.statusCode == 200) {
      return Services.fromMap(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      return const Services(english: [], arabic: [], armenian: [], russian: []);
    }
  }

  static Future<Mission> GetAllMission() async {
    var response = await http.Client().get(_getLink(_getAllMission));
    if (response.statusCode == 200) {
      return Mission.fromMap(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      return const Mission(english: "", arabic: "", armenian: "", russian: "");
    }
  }

  static Future<List<Product>> GetAllHomePageProduct() async {
    var response = await http.Client().get(_getLink(_getHomePageProduct));
    if (response.statusCode == 200) {
      return Product.ListFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<ProductSections> GetProductSections() async {
    var response = await http.Client().get(_getLink(_getProductSections));
    if (response.statusCode == 200) {
      return ProductSections.fromMap(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      return ProductSections(
          english: [], arabic: [], armenian: [], russian: []);
    }
  }

  static Future<bool> SendMessage(Object data) async {
    var response = await http.Client().post(_getLink(_sendMessage), body: data);

    return ((json.decode(response.body) as Map<String, dynamic>)['success']
            .toString() ==
        'true');
  }
}
