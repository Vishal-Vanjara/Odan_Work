import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🔹 Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // 🔹 Auth check (ONE TIME ONLY)
    _checkAuthOnce();
  }

  Future<void> _checkAuthOnce() async {
    // Splash delay
    await Future.delayed(const Duration(seconds: 3));

    // Wait for Firebase to resolve auth state ONCE
    final User? user =
    await FirebaseAuth.instance.authStateChanges().first;

    if (!mounted) return;

    if (user != null) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27B0A5),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 90,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'VibeX Chat',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Connect. Chat. Vibe.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../routes/app_routes.dart';
// import '../../services/auth_services.dart';
//
// class SplashView extends StatefulWidget {
//   const SplashView({super.key});
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//
//   final AuthService _authService = AuthService();
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _scaleAnimation =
//         Tween<double>(begin: 0.6, end: 1.0).animate(
//           CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
//         );
//
//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(
//           CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//         );
//
//     _controller.forward();
//
//     // _navigateNext(); ---------------------->
//
//     StreamSubscription<User?>? _authSub;
//
//     @override
//     void initState() {
//       super.initState();
//
//       _controller = AnimationController(
//         vsync: this,
//         duration: const Duration(seconds: 2),
//       );
//
//       _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
//       );
//
//       _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//       );
//
//       _controller.forward();
//
//       _listenAuthState();
//     }
//
//     void _listenAuthState() {
//       _authSub = FirebaseAuth.instance.authStateChanges().listen((user) async {
//         await Future.delayed(const Duration(seconds: 3));
//
//         if (!mounted) return;
//
//         if (user != null) {
//           Get.offAllNamed(AppRoutes.main);
//         } else {
//           Get.offAllNamed(AppRoutes.login);
//         }
//       });
//     }
//
//
//   }
//
//   Future<void> _navigateNext() async {
//     try {
//       await Future.delayed(const Duration(seconds: 3));
//
//       // final user = await _authService.getCurrentUser();
//
//       // if (user != null) {
//       //   Get.offAllNamed(AppRoutes.home);
//       // } else {
//       //   Get.offAllNamed(AppRoutes.login);
//       // }
//       if (user != null) {
//         // TEMP until HomeView is created
//         Get.offAllNamed(AppRoutes.main);
//       } else {
//         Get.offAllNamed(AppRoutes.login);
//       }
//     } catch (e) {
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }
//
//
//   @override
//   void dispose() {
//     _authSub?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF27B0A5),
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Icon(
//                   Icons.chat_bubble_outline,
//                   size: 90,
//                   color: Colors.white,
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'VibeX Chat',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Connect. Chat. Vibe.',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
