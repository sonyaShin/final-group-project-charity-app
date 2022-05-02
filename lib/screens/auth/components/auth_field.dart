import 'package:companionapp/res/app_colors.dart';
import 'package:companionapp/res/app_styles.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  const AuthField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            cursorColor: AppColors.primaryColor,
            controller: controller,
            cursorWidth: 3,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              hintText: hintText,
              hintStyle: AppStyles.kBodyText,
            ),
            style: AppStyles.kBodyText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
          ),
        ),
      ),
    );
  }
}
