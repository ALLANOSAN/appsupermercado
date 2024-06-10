import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appsupermercado/services/product_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supermercado'),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (context, index) {
          final product = productService.products[index];
          return ListTile(
            leading: product.imagePath.isNotEmpty ? Image.file(File(product.imagePath)) : null,
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('R\$ ${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
