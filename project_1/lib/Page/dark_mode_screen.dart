// import 'package:flutter/material.dart';
//
// class DarkModePage extends StatefulWidget {
//   @override
//   _DarkModePageState createState() => _DarkModePageState();
// }
//
// class _DarkModePageState extends State<DarkModePage> {
//   bool isDarkMode = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dark Mode Settings'),
//         ),
//         body: Center(
//           child: SwitchListTile(
//             title: Text('Enable Dark Mode'),
//             value: isDarkMode,
//             onChanged: (value) {
//               setState(() {
//                 isDarkMode = value;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
