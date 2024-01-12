import 'package:flutter/material.dart';
import 'package:hose_basket/Data/data.dart';
import 'package:hose_basket/Models/about.dart';
import 'package:hose_basket/Models/choose_us.dart';
import 'package:hose_basket/Models/languages.dart';
import 'package:hose_basket/Models/link.dart';
import 'package:hose_basket/Models/mission.dart';
import 'package:hose_basket/Models/page_type.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Models/services.dart';

class MainPageProvider extends ChangeNotifier {
  // #region Properties
  PageType _pageType = PageType.HomePage;
  PageType get pageType {
    return _pageType;
  }

  setpageType(PageType pageType) {
    _pageType = pageType;
    notifyListeners();
  }

  late Languages _languages = Languages.English;
  Languages get languages {
    return _languages;
  }

  setlanguages(Languages languages) {
    _languages = languages;
    notifyListeners();
  }

  late About _about;
  About get about {
    return _about;
  }

  setabout(About about) {
    _about = about;
  }

  late ChooseUs _chooseUs;
  ChooseUs get chooseUs {
    return _chooseUs;
  }

  setchooseUs(ChooseUs chooseUs) {
    _chooseUs = chooseUs;
  }

  late Services _services;
  Services get services {
    return _services;
  }

  setservices(Services services) {
    _services = services;
  }

  List<Product> _products = [];
  List<Product> get products {
    return _products;
  }

  setproducts(List<Product> products) {
    _products = products;
  }

  late Mission _mission;
  Mission get mission {
    return _mission;
  }

  setmission(Mission mission) {
    _mission = mission;
  }

  late List<Product> _homePageProducts;
  List<Product> get homePageProducts {
    return _homePageProducts;
  }

  sethomePageProducts(List<Product> homePageProducts) {
    _homePageProducts = homePageProducts;
  }

  bool _isInit = false;
  bool get isInit {
    return _isInit;
  }

  setisInit(bool isInit) {
    _isInit = isInit;
    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode {
    return _themeMode;
  }

  setthemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  late Link _link;
  Link get link {
    return _link;
  }

  setlink(Link link) {
    _link = link;
  }

  // #endregion

  Future<bool> mainPageData() async {
    try {
      var response = await Future.wait([
        Data.GetAllAbout(),
        Data.GetAllChooseUS(),
        Data.GetAllServices(),
        Data.GetAllMission(),
        Data.GetAllHomePageProduct(),
        Data.GetAllLinks(),
      ]);

      setabout(response[0] as About);
      setchooseUs(response[1] as ChooseUs);
      setservices(response[2] as Services);
      setmission(response[3] as Mission);
      sethomePageProducts(response[4] as List<Product>);
      setlink((response[5] as List<Link>)[0]);

      setisInit(true);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
