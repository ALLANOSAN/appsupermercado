import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/shared_prefs.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider() {
    _loadProducts();
  }

  void _loadProducts() async {
    _products = await SharedPrefs().getProducts();
    notifyListeners();
  }

  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((product) => product.categoryId == categoryId).toList();
  }

  void addProduct(Product product) async {
    await SharedPrefs().addProduct(product);
    _products.add(product);
    notifyListeners();
  }

  List<Product> filterAndSortProducts(String categoryId, String query, bool ascending) {
    List<Product> filteredProducts = _products.where((product) => product.categoryId == categoryId && product.name.toLowerCase().contains(query.toLowerCase())).toList();
    filteredProducts.sort((a, b) => ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    return filteredProducts;
  }
}
