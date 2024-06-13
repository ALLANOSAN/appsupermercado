import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_screen.dart';
import '../providers/category_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supermercado'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categoryProvider.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                          categoryId: categoryProvider.categories[index].id),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Center(
                    child: Text(categoryProvider.categories[index].name,
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
