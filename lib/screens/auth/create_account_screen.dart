import 'package:companionapp/res/app_colors.dart';
import 'package:companionapp/res/app_images.dart';
import 'package:companionapp/res/app_styles.dart';
import 'package:companionapp/screens/auth/components/auth_button.dart';
import 'package:companionapp/screens/auth/components/auth_field.dart';
import 'package:companionapp/screens/auth/components/background_image.dart';
import 'package:companionapp/screens/auth/controllers/create_account_controller.dart';
import 'package:companionapp/screens/auth/login_screen.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends GetView<CreateAccountController> {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreateAccountController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BackgroundImage(image: AppImages.registerBg),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        AuthField(
                          controller: controller.nameController,
                          icon: FontAwesomeIcons.user,
                          hintText: 'Name',
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
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
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                        ),
                        AuthField(
                          controller: controller.confirmPasswordController,
                          icon: FontAwesomeIcons.lock,
                          hintText: 'Confirm Password',
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => controller.loading.value
                              ? circularProgress()
                              : AuthButton(
                                  buttonText: 'Create',
                                  onPressed: () {
                                    if (controller.validate()) {
                                      controller.createAccount();
                                    }
                                  },
                                ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: AppStyles.kBodyText,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.off(const LoginScreen());
                              },
                              child: Text(
                                'Login',
                                style: AppStyles.kBodyText.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
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
