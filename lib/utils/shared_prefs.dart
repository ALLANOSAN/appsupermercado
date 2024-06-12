import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/product.dart';
import 'dart:convert';

class SharedPrefs {
  Future<List<Category>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesData = prefs.getString('categories') ?? '[]';
    final List<dynamic> jsonData = json.decode(categoriesData);
    return jsonData.map((json) => Category.fromJson(json)).toList();
  }

  Future<void> addCategory(Category category) async {
    final prefs = await SharedPreferences.getInstance();
    final categories = await getCategories();
    categories.add(category);
    prefs.setString('categories', json.encode(categories));
  }

  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsData = prefs.getString('products') ?? '[]';
    final List<dynamic> jsonData = json.decode(productsData);
    return jsonData.map((json) => Product.fromJson(json)).toList();
  }

  Future<void> addProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final productsData = prefs.getString('products') ?? '[]';
    final List<dynamic> jsonData = json.decode(productsData);
    jsonData.add(product.toJson());
    prefs.setString('products', json.encode(jsonData));
  }

  Future<List<Product>> getCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart') ?? '[]';
    final List<dynamic> jsonData = json.decode(cartData);
    return jsonData.map((json) => Product.fromJson(json)).toList();
  }

  Future<void> addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart') ?? '[]';
    final List<dynamic> jsonData = json.decode(cartData);
    jsonData.add(product.toJson());
    prefs.setString('cart', json.encode(jsonData));
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', '[]');
  }
}
