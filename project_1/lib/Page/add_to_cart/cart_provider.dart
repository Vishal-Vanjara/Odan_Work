import 'package:flutter/foundation.dart';
import '../../models/book_model.dart';
import 'cart_item_model.dart';
// import '../models/book_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addBook(BookModel book) {
    final index = _items.indexWhere((i) => i.id == book.id.toString());
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(
        id: book.id.toString(),
        name: book.name,
        imageUrl: book.imagePath,
        price: book.price,
      ));
    }
    notifyListeners();
  }

  void increment(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrement(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
