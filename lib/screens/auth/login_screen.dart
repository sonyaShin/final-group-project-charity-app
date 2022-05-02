import 'package:companionapp/res/app_images.dart';
import 'package:companionapp/res/app_styles.dart';
import 'package:companionapp/screens/auth/components/auth_button.dart';
import 'package:companionapp/screens/auth/components/auth_field.dart';
import 'package:companionapp/screens/auth/components/background_image.dart';
import 'package:companionapp/screens/auth/controllers/login_controller.dart';
import 'package:companionapp/screens/auth/create_account_screen.dart';
import 'package:companionapp/screens/auth/forgot_password_screen.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BackgroundImage(image: AppImages.loginBg),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const Flexible(
                  child: Center(
                    child: Text(
                      'Charity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        AuthField(
                          controller: controller.emailController,
                          icon: FontAwesomeIcons.envelope,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        AuthField(
                          controller: controller.passwordController,
                          icon: FontAwesomeIcons.lock,
                          hintText: 'Password',
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: GestureDetector(
                            onTap: () => Get.to(const ForgotPasswordScreen()),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                style: AppStyles.kBodyText,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Obx(
                          () => controller.loading.value
                              ? circularProgress()
                              : AuthButton(
                                  buttonText: 'Login',
                                  onPressed: () {
                                    if (controller.validate()) {
                                      controller.login();
                                    }
                                  },
                                ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.emailController.clear();
                    controller.passwordController.clear();
                    Get.off(const CreateAccountScreen());
                  },
                  child: Container(
                    child: const Text(
                      'Create New Account',
                      style: AppStyles.kBodyText,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
