import 'package:flutter/material.dart';
import 'package:flutter_task/utils/app_color.dart';

class CustomContainerButtom extends StatelessWidget {
  const CustomContainerButtom({super.key, this.onTap, required this.text});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.blueColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
