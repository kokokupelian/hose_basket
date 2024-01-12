import 'package:flutter/material.dart';
import 'package:hose_basket/Data/data.dart';
import 'package:hose_basket/Models/product.dart';
import 'package:hose_basket/Models/product_sections.dart';

class ProductPageProvider extends ChangeNotifier {
  // #region Variables
  late ProductSections _productSections;
  ProductSections get productSections {
    return _productSections;
  }

  setproductSections(ProductSections productSections) {
    _productSections = productSections;
  }

  late List<Product> _products;
  List<Product> get products {
    return _products;
  }

  setproducts(List<Product> products) {
    _products = products;
  }

  // #endregion

  Future<bool> getData() async {
    try {
      var data =
          await Future.wait([Data.GetAllProducts(), Data.GetProductSections()]);

      setproducts(data[0] as List<Product>);
      setproductSections(data[1] as ProductSections);

      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
}
