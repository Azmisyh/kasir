import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String name;
  final double price;
  final int quantity;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity];
}

// State untuk CartCubit
class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get totalPrice =>
      items.fold(0, (total, item) => total + item.price * item.quantity);

  @override
  List<Object?> get props => [items, totalPrice];
}

// Cubit untuk mengelola keranjang
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  // Tambah item ke keranjang
  void addItem(CartItem item) {
    final index = state.items.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      // Jika item sudah ada, tambah quantity
      final updatedItem =
          state.items[index].copyWith(quantity: state.items[index].quantity + 1);
      final updatedItems = List<CartItem>.from(state.items)
        ..[index] = updatedItem;
      emit(CartState(items: updatedItems));
    } else {
      emit(CartState(items: List.from(state.items)..add(item)));
    }
  }

  // Hapus item dari keranjang
  void removeItem(String id) {
    final updatedItems = state.items.where((item) => item.id != id).toList();
    emit(CartState(items: updatedItems));
  }

  // Ubah quantity item
  void updateQuantity(String id, int quantity) {
    if (quantity <= 0) {
      removeItem(id);
      return;
    }
    final index = state.items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      final updatedItem = state.items[index].copyWith(quantity: quantity);
      final updatedItems = List<CartItem>.from(state.items)
        ..[index] = updatedItem;
      emit(CartState(items: updatedItems));
    }
  }

  // Bersihkan keranjang
  void clearCart() {
    emit(const CartState());
  }
}
