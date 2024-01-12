import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hose_basket/Models/languages.dart';
import 'package:hose_basket/Models/page_type.dart';
import 'package:hose_basket/Pages/contact_page.dart';
import 'package:hose_basket/Pages/home_page.dart';
import 'package:hose_basket/Pages/products%20_page.dart';
import 'package:hose_basket/Pages/splash_screen_page.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // #region Properties
  late final MainPageProvider _provider =
      Provider.of<MainPageProvider>(context, listen: true);
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late final Animation<double> _animation =
      Tween<double>(begin: 1, end: 0).animate(_controller);
  final SplashScreenController _splashScreenController =
      SplashScreenController();
  // #endregion

  // #region Methods
  _setLangauge(SharedPreferences sharedPreferences) async {
    String? language = sharedPreferences.getString("language");
    if (language == null || language.isEmpty) {
      _provider.setlanguages(Languages.English);
    } else {
      _provider.setlanguages(
        Languages.values.firstWhere(
            (element) => element.toString().split(".")[1] == language),
      );
    }
  }

  _setTheme(SharedPreferences sharedPreferences) async {
    String? theme = sharedPreferences.getString("theme");
    switch (theme) {
      case "dark":
        _provider.setthemeMode(ThemeMode.dark);
        break;
      case "light":
        _provider.setthemeMode(ThemeMode.light);
        break;
      case "system":
      default:
        _provider.setthemeMode(ThemeMode.system);
        break;
    }
  }

  _getData() {
    _provider.mainPageData().then((value) {
      if (value) {
        _splashScreenController.start();
      } else {
        _splashScreenController.isError();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Icon(
                Icons.network_check,
              ),
              content: const Text(
                  "Please Check Your Internet Connection And Try Again."),
              actions: [
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text("Exit"),
                ),
                TextButton(
                  onPressed: () {
                    _splashScreenController.removeError();
                    Navigator.of(context).pop();
                    _getData();
                  },
                  child: const Text("Try Again"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  // #endregion

  // #region Init
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var sharedPreferences = await SharedPreferences.getInstance();
        await _setLangauge(sharedPreferences);
        await _setTheme(sharedPreferences);
        _getData();
      },
    );
    super.initState();
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Builder(
            builder: (context) {
              switch (_provider.pageType) {
                case PageType.HomePage:
                  return const HomePage();
                case PageType.Products:
                  return const ProductsPage();
                case PageType.Contact:
                  return const ContactPage();
                default:
                  return const Scaffold();
              }
            },
          ),
          const SideMenu(),
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              if (_controller.status != AnimationStatus.completed) {
                return FadeTransition(
                  opacity: _animation,
                  child: child,
                );
              } else {
                return const SizedBox();
              }
            },
            child: SplashScreenPage(
              onEnd: () {
                _controller.forward();
              },
              controller: _splashScreenController,
            ),
          ),
        ],
      ),
    );
  }
}
