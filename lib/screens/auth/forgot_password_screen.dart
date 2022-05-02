import 'package:companionapp/res/app_images.dart';
import 'package:companionapp/screens/auth/components/auth_button.dart';
import 'package:companionapp/screens/auth/components/auth_field.dart';
import 'package:companionapp/screens/auth/components/background_image.dart';
import 'package:companionapp/screens/auth/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BackgroundImage(image: AppImages.loginBg),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    SizedBox(
                      width: size.width * 0.8,
                      child: const Text(
                        'Enter your email we will send instructions to reset'
                        ' your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                      controller: controller.emailController,
                      icon: FontAwesomeIcons.envelope,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      onPressed: () {
                        if (controller.validate()) {
                          controller.sendResetPasswordLink();
                        }
                      },
                      buttonText: 'Send',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
