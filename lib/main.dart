import 'package:flutter/material.dart';
import 'package:appsupermercado/pages/home_page.dart';
import 'package:appsupermercado/pages/categories_page.dart';
import 'package:appsupermercado/pages/search_page.dart';
import 'package:appsupermercado/widgets/bottom_nav_bar.dart';
import 'package:appsupermercado/services/product_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductService(),
      child: MaterialApp(
        title: 'Supermercado App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    AddProductPage(), // Aqui você instancia a página, não chama um método
    SearchPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Add Product Page'),
      ),
    );
  }
}