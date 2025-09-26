import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.emailController,
    required this.keyboardType,
    required this.hintText,
    required this.suffixIcon,
    this.validator,
    this.obscureText = false,
  });

  final TextEditingController emailController;
  final TextInputType keyboardType;
  final String hintText;
  final Widget suffixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
      ),
      validator: validator,
    );
  }
}
