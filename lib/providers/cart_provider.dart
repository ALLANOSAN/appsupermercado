import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/product.dart'; // Import your Product model

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

 
  void removeItem(String id) {
    _cartItems.remove(id);
    _saveCartItems();
    notifyListeners();
  }
  
  List<Category> _categories = [];
  final List<Product> _cart = []; // Add a cart list to hold Products

  CartProvider() {
    _loadCategories();
  }

  List<Category> get categories => _categories;
  List<Product> get cartProducts => _cart; // Getter for the cart list

  double get totalPrice => _cart.fold(0, (sum, item) => sum + item.price); // Calculate total price

  void addCategory(Category category) {
    _categories.add(category);
    _saveCategories();
    notifyListeners();
  }

  void addToCart(Product product) { // Add a product to the cart
    _cart.add(product);
    notifyListeners();
  }

  void clearCart() { // Clear the cart
    _cart.clear();
    notifyListeners();
  }

  void _saveCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesJson = _categories.map((category) => json.encode(category.toJson())).toList();
    await prefs.setStringList('categories', categoriesJson);
  }

  void _loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesJson = prefs.getStringList('categories');
    if (categoriesJson != null) {
      _categories = categoriesJson.map((jsonStr) => Category.fromJson(json.decode(jsonStr))).toList();
    }
    notifyListeners();
  }
}