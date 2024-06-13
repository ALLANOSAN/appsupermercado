import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'add_category_screen.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    AddCategoryScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    var iconColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: iconColor),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: iconColor),
            label: 'Adicionar Categoria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: iconColor),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brightness_6, color: iconColor),
            label: 'Tema',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 3) {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
