import 'package:flutter/material.dart';
import 'package:project_2/routes/app_routes.dart';
import '../../services/auth_services.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obsecurePassword = true;

  bool isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await AuthService().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // ✅ Solve
      Get.offAllNamed(AppRoutes.main);

      // TODO: Navigate to home/chat screen
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Email required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: _obsecurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obsecurePassword = !_obsecurePassword;
                      });
                    },
                    icon: Icon(
                      _obsecurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) =>
                    value!.length < 6 ? "Min 6 characters" : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.forgetPassword);
                },
                child: const Text('Forgot Password?'),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/register');
                  Get.toNamed(AppRoutes.register);
                },
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

//<----------------------------------------------Another Login Page Design--------------------------------->
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color(0xFF0F766E), // teal background
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 40),
  //
  //             // Header
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 24),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: const [
  //                   Text(
  //                     "Hello!",
  //                     style: TextStyle(
  //                       fontSize: 32,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Text(
  //                     "Welcome back",
  //                     style: TextStyle(color: Colors.white70),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             const SizedBox(height: 40),
  //
  //             // White Card
  //             Container(
  //               padding: const EdgeInsets.all(24),
  //               margin: const EdgeInsets.symmetric(horizontal: 20),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(28),
  //               ),
  //               child: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   children: [
  //                     const Text(
  //                       "Login",
  //                       style: TextStyle(
  //                         fontSize: 22,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 24),
  //
  //                     // Email Field
  //                     TextFormField(
  //                       controller: _emailController,
  //                       decoration: InputDecoration(
  //                         hintText: "Email",
  //                         prefixIcon: const Icon(Icons.email_outlined),
  //                         filled: true,
  //                         fillColor: Colors.grey.shade100,
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(30),
  //                           borderSide: BorderSide.none,
  //                         ),
  //                       ),
  //                       validator: (value) =>
  //                       value!.isEmpty ? "Email required" : null,
  //                     ),
  //
  //                     const SizedBox(height: 16),
  //
  //                     // Password Field
  //                     TextFormField(
  //                       controller: _passwordController,
  //                       obscureText: true,
  //                       decoration: InputDecoration(
  //                         hintText: "Password",
  //                         prefixIcon: const Icon(Icons.lock_outline),
  //                         suffixIcon:
  //                         const Icon(Icons.visibility_off_outlined),
  //                         filled: true,
  //                         fillColor: Colors.grey.shade100,
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(30),
  //                           borderSide: BorderSide.none,
  //                         ),
  //                       ),
  //                       validator: (value) =>
  //                       value!.length < 6 ? "Min 6 characters" : null,
  //                     ),
  //
  //                     const SizedBox(height: 8),
  //
  //                     Align(
  //                       alignment: Alignment.centerRight,
  //                       child: TextButton(
  //                         onPressed: () {
  //                           Get.toNamed(AppRoutes.forgetPassword);
  //                         },
  //                         child: const Text("Forgot Password?"),
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 12),
  //
  //                     // Login Button
  //                     SizedBox(
  //                       width: double.infinity,
  //                       height: 50,
  //                       child: ElevatedButton(
  //                         onPressed: isLoading ? null : _login,
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color(0xFF0F766E),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(30),
  //                           ),
  //                         ),
  //                         child: isLoading
  //                             ? const CircularProgressIndicator(
  //                           color: Colors.white,
  //                         )
  //                             : const Text(
  //                           "Login",
  //                           style: TextStyle(fontSize: 16),
  //                         ),
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 24),
  //
  //                     const Text("or login with"),
  //
  //                     const SizedBox(height: 16),
  //
  //                     // Social Buttons
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: const [
  //                         Icon(Icons.facebook, size: 32),
  //                         SizedBox(width: 20),
  //                         Icon(Icons.g_mobiledata, size: 40),
  //                         SizedBox(width: 20),
  //                         Icon(Icons.apple, size: 32),
  //                       ],
  //                     ),
  //
  //                     const SizedBox(height: 24),
  //
  //                     // Register
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         const Text("Don't have account? "),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Get.toNamed(AppRoutes.register);
  //                           },
  //                           child: const Text(
  //                             "Sign Up",
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               color: Color(0xFF0F766E),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
