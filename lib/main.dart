import 'package:appsupermercado/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/category_provider.dart';
import 'providers/product_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(      
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      
      child: Consumer<ThemeProvider>(        
        builder: (context, themeProvider, child) {
          return MaterialApp(     
            debugShowCheckedModeBanner: false,
            title: 'Supermercado',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
