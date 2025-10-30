// import 'package:flutter/material.dart';
// import 'dark_mode_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   final List<Map<String, String>> categories = [
//     {'name': 'Fiction', 'image': 'assets/images/book1.jpg'},
//     {'name': 'Non-Fiction', 'image': 'assets/images/book2.jpg'},
//     {'name': 'Comics', 'image': 'assets/images/book3.jpg'},
//     {'name': 'Fiction', 'image': 'assets/images/book1.jpg'},
//     {'name': 'Non-Fiction', 'image': 'assets/images/book2.jpg'},
//     {'name': 'Comics', 'image': 'assets/images/book3.jpg'},
//   ];
//
//   final List<Map<String, String>> popularBooks = [
//     {
//       'title': 'The Great Gatsby',
//       'author': 'F. Scott Fitzgerald',
//       'price': '\R\s 350',
//       'image': 'assets/images/book4.jpg'
//     },
//     {
//       'title': '1984',
//       'author': 'George Orwell',
//       'price': '\R\s 250',
//       'image': 'assets/images/book5.jpg'
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grab your book'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.dark_mode),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => DarkModePage()),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.shopping_cart_outlined),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Text(
//               'Grab your book',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             // Categories
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: categories
//                     .map((cat) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                                         children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.asset(
//                           cat['image']!,
//                           width: 100,
//                           height: 170,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(cat['name']!),
//                                         ],
//                                       ),
//                     ))
//                     .toList(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Popular section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Popular',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text('View more'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 300,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: popularBooks.length,
//                 itemBuilder: (context, index) {
//                   final book = popularBooks[index];
//                   return Container(
//                     width: 180,
//                     margin: const EdgeInsets.only(right: 15),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.brown.shade100,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15)),
//                           child: Image.asset(
//                             book['image']!,
//                             height: 180,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 book['title']!,
//                                 style: const TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                               Text(book['author']!,
//                                   style: TextStyle(color: Colors.grey[700])),
//                               const SizedBox(height: 5),
//                               Text(book['price']!,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }
