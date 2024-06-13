import 'package:appsupermercado/models/product.dart';
import 'package:appsupermercado/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  // Add a key parameter to your constructor
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.imageUrl),
            const SizedBox(height: 10),
            Text('R\$ ${product.price}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text(product.description),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Produto adicionado ao carrinho')),
                );
              },
              child: const Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}