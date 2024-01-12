import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Hero(
        tag: "${widget.product.id}_img",
        child: Container(
          height: size.height * 0.5,
          width: size.width * 0.7,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: BackgroundColor(context),
            borderRadius: BorderRadius.circular(
              30,
            ),
            boxShadow: [
              BoxShadow(
                color: AccentColor(context).withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Flexible(
                  child: Image.network(
                    widget.product.getImagePath(),
                    height: size.height * 0.2,
                    width: size.height * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.adaptiveTitle(
                    context.watch<MainPageProvider>().languages,
                  ),
                  style: TextStyle(
                      fontSize: 20,
                      color: AccentColor(context),
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 1,
                        ),
                      ]),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.product.adaptiveDesc(
                          context.watch<MainPageProvider>().languages,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
