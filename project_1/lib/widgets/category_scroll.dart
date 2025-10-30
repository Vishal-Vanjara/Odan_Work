import 'package:flutter/material.dart';

class CategoryScroll extends StatelessWidget {
  const CategoryScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Adventure",
      "Historical",
      "Comedy",
      "Mystery",
      "Sci-Fi",
      "Magic",
      "Horror",
      "Isekai",
      "Kids",
      "Drama",
    ];

    final List<String> categoryImageUrls = const [
      "https://m.media-amazon.com/images/I/81-rKB+dPML._SY466_.jpg",
      // Adventure (using a placeholder for demonstration)
      "https://m.media-amazon.com/images/I/51w5oEAV4hL._SY445_SX342_FMwebp_.jpg",
      // Historical
      "https://m.media-amazon.com/images/I/713toGwMnqL._SY342_.jpg",
      // Comedy
      "https://m.media-amazon.com/images/I/41kRkqIt6aL._SY445_SX342_FMwebp_.jpg",
      // Mystery
      "https://m.media-amazon.com/images/I/51oApVOle4S._SY445_SX342_FMwebp_.jpg",
      // Sci-Fi
      "https://m.media-amazon.com/images/I/51Rmi3vU1HL._SY445_SX342_FMwebp_.jpg",
      // Magic
      "https://m.media-amazon.com/images/I/71Jc3BJldkL._UF1000,1000_QL80_.jpg",
      // Horror
      "https://m.media-amazon.com/images/I/818p9SIUaoL._SY466_.jpg",
      // Isekai
      "https://m.media-amazon.com/images/I/81uvCkcYSFL._SY466_.jpg",
      // Kids
      "https://m.media-amazon.com/images/I/41H42CRXloL._SY445_SX342_FMwebp_.jpg",
      // Drama
    ];

    return SizedBox(
      height: 161,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 110,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(categoryImageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  categories[index],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
