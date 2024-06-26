import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(cartProvider.cartProducts[index].image),
                      title: Text(cartProvider.cartProducts[index].name),
                      subtitle: Text('R\$ ${cartProvider.cartProducts[index].price.toString()}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Total: R\$ ${cartProvider.totalPrice}', style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        cartProvider.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Compra finalizada!')),
                        );
                      },
                      child: const Text('Finalizar Compra'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
