import 'package:flutter/material.dart';

class MyAddressPage extends StatefulWidget {
  const MyAddressPage({super.key});

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildUpdateProfile()],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: ElevatedButton(onPressed: () {}, child: Text('Update')),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscuretext = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscuretext,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildUpdateProfile() {
    return Column(
      children: [
        _buildTextField(
          label: 'Email',
          hint: 'ex :- xyz@gmail.com',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),

        _buildTextField(
          label: 'Full Name',
          hint: 'Enter your Full Name',
          icon: Icons.person_outline,
        ),

        _buildTextField(
          label: 'Phone Number',
          hint: 'Enter Your Phone Number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.number,
        ),

        _buildTextField(
          label: 'Address',
          hint: 'Enter your address',
          icon: Icons.home_outlined,
        ),
      ],
    );
  }
}
