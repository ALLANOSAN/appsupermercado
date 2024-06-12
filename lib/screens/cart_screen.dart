import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
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
                      leading: Image.network(cartProvider.cartProducts[index].imageUrl),
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
                    Text('Total: R\$ ${cartProvider.totalPrice}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        cartProvider.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Compra finalizada!')),
                        );
                      },
                      child: Text('Finalizar Compra'),
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
