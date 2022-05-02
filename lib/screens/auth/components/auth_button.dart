import 'package:companionapp/res/app_colors.dart';
import 'package:companionapp/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthButton extends GetView {
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundColor;
  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        minimumSize: MaterialStateProperty.all<Size>(Size(
          size.width * 0.8,
          size.height * 0.08,
        )),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
      child: Text(
        buttonText,
        style: AppStyles.kBodyText.copyWith(fontWeight: FontWeight.bold),
      ),
    );
    // return Container(
    //   height: size.height * 0.08,
    //   width: size.width * 0.8,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16),
    //     color: AppColors.primaryColor,
    //   ),
    //   child: TextButton(
    //     onPressed: () {},
    //     child: Text(
    //       buttonText,
    //       style: AppStyles.kBodyText.copyWith(fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // );
  }
}
