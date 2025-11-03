import 'package:flutter/material.dart';
import 'add_book_form.dart';

class BookInventoryPage extends StatefulWidget {
  const BookInventoryPage({super.key});

  @override
  State<BookInventoryPage> createState() => _BookInventoryPageState();
}

class _BookInventoryPageState extends State<BookInventoryPage> {
  final TextEditingController _searchController = TextEditingController();

  // Sample book data
  final List<Map<String, dynamic>> books = [
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'isbn': '9780743273565',
      'category': 'Classic',
      'price': 299,
      'stock': 45,
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'isbn': '9780061120084',
      'category': 'Fiction',
      'price': 249,
      'stock': 8,
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'isbn': '9780451524935',
      'category': 'Dystopian',
      'price': 199,
      'stock': 0,
    },
  ];

  String _getStatus(int stock) {
    if (stock == 0) return 'Out of Stock';
    if (stock < 10) return 'Low Stock';
    return 'In Stock';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Out of Stock':
        return Colors.red.shade400;
      case 'Low Stock':
        return Colors.orange.shade300;
      default:
        return Colors.green.shade400;
    }
  }

  void _openAddBookForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const AddBookForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _horizontalScrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Inventory"),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Inventory",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Manage your book collection",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _openAddBookForm,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Book"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search books by title, author, or category",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Scrollable Data Table with Scrollbar
            Expanded(
              child: Scrollbar(
                controller: _horizontalScrollController,
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 8,
                radius: const Radius.circular(4),
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor:
                    WidgetStateProperty.all(Colors.grey[200]),
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columns: const [
                      DataColumn(label: Text("Title & Author")),
                      DataColumn(label: Text("ISBN")),
                      DataColumn(label: Text("Category")),
                      DataColumn(label: Text("Price")),
                      DataColumn(label: Text("Stock")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows: books.map((book) {
                      final status = _getStatus(book['stock']);
                      return DataRow(cells: [
                        DataCell(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(book['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(book['author'],
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        DataCell(Text(book['isbn'])),
                        DataCell(Text(book['category'])),
                        DataCell(Text("₹${book['price']}")),
                        DataCell(Text(book['stock'].toString())),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        )),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 18),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              onPressed: () {},
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
