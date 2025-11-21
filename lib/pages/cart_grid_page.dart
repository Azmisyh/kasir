import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';

class CartGridPage extends StatelessWidget {
  const CartGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text('Keranjang kosong'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 item per baris
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: item.name.isNotEmpty
                                  ? Center(child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)))
                                  : const SizedBox(),
                            ),
                            Text('Harga: \$${item.price.toStringAsFixed(2)}'),
                            Text('Jumlah: ${item.quantity}'),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Tombol tambah quantity
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .updateQuantity(item.id, item.quantity + 1);
                                  },
                                ),
                                // Tombol kurangi quantity
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .updateQuantity(item.id, item.quantity - 1);
                                  },
                                ),
                                // Tombol hapus item
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    context.read<CartCubit>().removeItem(item.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Keranjang telah dibersihkan')),
                        );
                      },
                      child: const Text('Bersihkan Keranjang'),
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
