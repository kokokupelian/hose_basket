import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Pages/product_detail_page.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Provider/product_page_provider.dart';
import 'package:hose_basket/Widgets/Product/product_page_container.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late var future =
      Provider.of<ProductPageProvider>(context, listen: false).getData();

  bool get isTablet {
    final data = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.first);
    if (data.size.shortestSide < 600) {
      return false;
    } else {
      return true;
    }
  }

  List<Widget> _widget(List<Product> data) {
    List<Widget> output = [];

    for (var i = 0; i < data.length; i++) {
      String herotag = "${data[i].id}_img";

      output.add(
        AnimationConfiguration.staggeredGrid(
          duration: const Duration(milliseconds: 500),
          position: i,
          columnCount: isTablet ? 3 : 2,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      barrierColor: Colors.black87,
                      opaque: false,
                      barrierDismissible: true,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ProductDetailPage(
                          product: data[i],
                        );
                      },
                    ),
                  );
                },
                child: ProductPageContainer(
                  heroTag: herotag,
                  product: data[i],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor(context),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Image.asset("assets/logo.jpeg", height: 50),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<ProductPageProvider>(
          builder: (context, value, child) {
            return FutureBuilder<bool>(
              future: future,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: (snapshot.connectionState == ConnectionState.done)
                        ? (snapshot.data!)
                            ? Column(
                                key: const Key("ProductLoaded"),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Consumer<MainPageProvider>(
                                        builder: (context, mainValue, child) {
                                      return Text(
                                        value.productSections
                                            .adaptive(mainValue.languages)
                                            .join(" - ")
                                            .replaceAll("\n", ""),
                                        textAlign: TextAlign.center,
                                      );
                                    }),
                                  ),
                                  Expanded(
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        crossAxisCount: isTablet ? 3 : 2,
                                        padding: const EdgeInsets.all(10),
                                        children: [
                                          ..._widget(value.products),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                key: const Key("ProductError"),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "Please Check Your Internet Connection And Try Again."),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          future =
                                              Provider.of<ProductPageProvider>(
                                                      context,
                                                      listen: false)
                                                  .getData();
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: AccentColor(context),
                                      ),
                                      child: const Text("Try Again"),
                                    ),
                                  ],
                                ),
                              )
                        : Center(
                            key: const Key("ProductLoading"),
                            child: SpinKitCubeGrid(color: AccentColor(context)),
                          ));
              },
            );
          },
        ),
      ),
    );
  }
}
