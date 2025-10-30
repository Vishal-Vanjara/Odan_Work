import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/category_scroll.dart';
import '../widgets/search_bar_3d.dart';
import '../widgets/recommended_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/navigation_drawer.dart';
import '../models/book_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<BookModel>> getBooksStream() {
    return _firestore.collection('books').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return BookModel(
          id: doc.id,
          imagePath: data['imagePath'] ?? '',
          name: data['name'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          description: data['description'] ?? '',
          rating: (data['rating'] ?? 0).toDouble(),
          genre: data['genre'] ?? '',
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Grab your book",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const CategoryScroll(),
              const SizedBox(height: 16),
              const SearchBar3D(),
              const SizedBox(height: 24),
              const Text(
                "Recommended",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 13),
              StreamBuilder<List<BookModel>>(
                stream: getBooksStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  final books = snapshot.data ?? [];
                  if (books.isEmpty) {
                    return const Center(child: Text("No books available"));
                  }
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return RecommendedGridItem(book: books[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
