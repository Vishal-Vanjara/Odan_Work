import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/book_model.dart';
import 'book_details_page.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favoriteBooks;

    return Scaffold(
      appBar: AppBar(title: const Text('Liked Books')),
      body: favorites.isEmpty
          ? const Center(child: Text('No liked books yet'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (_, i) {
          final BookModel book = favorites[i];
          return ListTile(
            leading: Image.network(book.imagePath, width: 50, height: 70, fit: BoxFit.cover),
            title: Text(book.name),
            subtitle: Text('₹${book.price.toStringAsFixed(2)}'),
            trailing: const Icon(Icons.favorite, color: Colors.red),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookDetailsPage(book: book))),
          );
        },
      ),
    );
  }
}
