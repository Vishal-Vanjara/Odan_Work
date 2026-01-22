import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/controllers/auth_controller.dart';
import 'package:project_2/firebase_options.dart';
import 'package:project_2/routes/app_pages.dart';
import 'package:project_2/theme/app_theme.dart';

import 'controllers/main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 GLOBAL CONTROLLER
  Get.put(MainController(), permanent: true);
  Get.put(AuthController(),permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "VibeX",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}






























