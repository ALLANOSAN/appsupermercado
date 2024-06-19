import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_screen.dart';
import '../providers/category_provider.dart';
import 'dart:io';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supermercado'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                onLongPress: () {
                  var categoryProvider =
                      Provider.of<CategoryProvider>(context, listen: false);
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Remover categoria'),
                      content: const Text(
                          'Você tem certeza que deseja remover esta categoria?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            categoryProvider.removeCategory(
                                categoryProvider.categories[index].id);
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Expanded(
                        child: _imageFileWidget(
                            categoryProvider.categories[index].image),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categoryProvider.categories[index].name,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _imageFileWidget(String imagePath) {
    if (imagePath.isEmpty) {
      return Container();
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
  }
}
