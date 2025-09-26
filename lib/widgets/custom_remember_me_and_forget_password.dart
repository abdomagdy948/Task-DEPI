import 'package:flutter/material.dart';

class CustomRememberMeAndForgetPassword extends StatelessWidget {
  const CustomRememberMeAndForgetPassword({
    super.key,
    required this.mainAxisAlignment,
    required this.text1,
    required this.text2,
    this.fontWeight,
    this.onTap,
  });
  final MainAxisAlignment mainAxisAlignment;
  final String text1;
  final String text2;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            text1,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueAccent,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
