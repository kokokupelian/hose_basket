import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hose_basket/Pages/main_page.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Provider/product_page_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return MainPageProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ProductPageProvider();
          },
        )
      ],
      child: Consumer<MainPageProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: value.themeMode,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
