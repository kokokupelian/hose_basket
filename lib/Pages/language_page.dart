import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/languages.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late final MainPageProvider _provider =
      Provider.of<MainPageProvider>(context, listen: false);

  Color _selectedLanguage(Languages languages) {
    return _provider.languages == languages
        ? AccentColor(context)
        : Theme.of(context).brightness == Brightness.light
            ? MainColor(context)
            : Colors.white;
  }

  late SharedPreferences _sharedPreferences;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _sharedPreferences = await SharedPreferences.getInstance();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              _sharedPreferences.setString("language", "English");
              _provider.setlanguages(Languages.English);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(),
            child: Text(
              "English",
              style: TextStyle(
                color: _selectedLanguage(Languages.English),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _sharedPreferences.setString("language", "Arabic");

              _provider.setlanguages(Languages.Arabic);
              Navigator.of(context).pop();
            },
            child: Text(
              "عربي",
              style: TextStyle(
                color: _selectedLanguage(Languages.Arabic),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _sharedPreferences.setString("language", "Armenian");

              _provider.setlanguages(Languages.Armenian);
              Navigator.of(context).pop();
            },
            child: Text(
              "Հայերէն",
              style: TextStyle(
                color: _selectedLanguage(Languages.Armenian),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _sharedPreferences.setString("language", "Russian");

              _provider.setlanguages(Languages.Russian);
              Navigator.of(context).pop();
            },
            child: Text(
              "русский",
              style: TextStyle(
                color: _selectedLanguage(Languages.Russian),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
