import 'package:flutter/material.dart';

class CustomRegisterWithIcon extends StatelessWidget {
  const CustomRegisterWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook, color: Colors.blueAccent, size: 50),
        SizedBox(width: 10),
        Icon(Icons.g_mobiledata, color: Colors.red, size: 50),
        SizedBox(width: 10),
        Icon(Icons.apple, color: Colors.black, size: 50),
      ],
    );
  }
}
