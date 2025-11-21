import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../models/product_model.dart';
import 'cart_grid_page.dart';

class CartHomePage extends StatelessWidget {
  CartHomePage({super.key});

  // Contoh daftar produk
  final List<ProductModel> products = [
    ProductModel(id: 'p1', name: 'Jaket Half Zipper', price: 10000, description: 'Deskripsi A',),
    ProductModel(id: 'p2', name: 'Jaket Bomber', price: 15000, description: 'Deskripsi B'),
    ProductModel(id: 'p3', name: 'Jaket Parka', price: 20000, description: 'Deskripsi C'),
    ProductModel(id: 'p4', name: 'Hoodie', price: 25000, description: 'Deskripsi D'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartGridPage()),
              );
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text('Harga: Rp ${product.price.toStringAsFixed(0)}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      final cartItem = CartItem(
                        id: product.id,
                        name: product.name,
                        price: product.price,
                        quantity: 1,
                      );
                      context.read<CartCubit>().addItem(cartItem);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} ditambahkan ke keranjang')),
                      );
                    },
                    child: const Text('Tambah ke Keranjang'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
