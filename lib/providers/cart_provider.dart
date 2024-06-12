import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/shared_prefs.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartProducts = [];

  List<Product> get cartProducts => _cartProducts;

  double get totalPrice => _cartProducts.fold(0, (sum, item) => sum + item.price);

  CartProvider() {
    _loadCart();
  }

  void _loadCart() async {
    _cartProducts = await SharedPrefs().getCartProducts();
    notifyListeners();
  }

  void addToCart(Product product) async {
    await SharedPrefs().addToCart(product);
    _cartProducts.add(product);
    notifyListeners();
  }

  void clearCart() async {
    await SharedPrefs().clearCart();
    _cartProducts.clear();
    notifyListeners();
  }
}
