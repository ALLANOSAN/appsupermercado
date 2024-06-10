import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

class ProductService extends ChangeNotifier {
  List<Product> _products = [];

  ProductService() {
    _loadProducts();
  }

  List<Product> get products => _products;

  void _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsData = prefs.getString('products');
    if (productsData != null) {
      _products = (json.decode(productsData) as List)
          .map((item) => Product.fromMap(item))
          .toList();
      notifyListeners();
    }
  }

  void addProduct(Product product) async {
    _products.add(product);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('products', json.encode(_products.map((item) => item.toMap()).toList()));
    notifyListeners();
  }
}
