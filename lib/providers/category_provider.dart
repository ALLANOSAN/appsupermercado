import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../utils/shared_prefs.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;
  

  CategoryProvider() {
    _loadCategories();
  }

  void _loadCategories() async {
    _categories = await SharedPrefs().getCategories();
    notifyListeners();
  }

  void addCategory(String name) async {
    final newCategory = Category(id: const Uuid().v4(), name: name, image: '');
    await SharedPrefs().addCategory(newCategory);
    _categories.add(newCategory);
    notifyListeners();
  }

  void removeCategory(String id) async {
    _categories.removeWhere((category) => category.id == id);
    await SharedPrefs().removeCategory(id);
    notifyListeners();
  }
}
