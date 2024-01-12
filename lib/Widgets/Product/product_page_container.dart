import 'package:flutter/material.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:provider/provider.dart';

class ProductPageContainer extends StatelessWidget {
  final String heroTag;
  final Product product;
  const ProductPageContainer(
      {super.key, required this.heroTag, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
        color: MainColor(context).withOpacity(
          0.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Hero(
              tag: heroTag,
              child: Image.network(
                product.getImagePath(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0,
                  0.7,
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Text(
              product.adaptiveTitle(
                Provider.of<MainPageProvider>(context, listen: true).languages,
              ),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                  color: AccentColor(context),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ]),
            ),
          ))
        ],
      ),
    );
  }
}
