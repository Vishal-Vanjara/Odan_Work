import 'package:flutter/foundation.dart';
import '../models/book_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<BookModel> _favoriteBooks = [];

  List<BookModel> get favoriteBooks => List.unmodifiable(_favoriteBooks);

  bool isFavorite(BookModel book) {
    return _favoriteBooks.any((b) => b.id == book.id);
  }

  void toggleFavorite(BookModel book) {
    final exists = isFavorite(book);
    if (exists) {
      _favoriteBooks.removeWhere((b) => b.id == book.id);
    } else {
      _favoriteBooks.add(book);
    }
    notifyListeners();
  }
}
