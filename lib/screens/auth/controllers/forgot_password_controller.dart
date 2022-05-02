import 'package:companionapp/enums/snackbar_message.dart';
import 'package:companionapp/res/alert_messages.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  late final TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void sendResetPasswordLink() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.back();
      showSnackbar(SnackbarMessage.success, AlertMessages.resetPasswordSuccess);
    } catch (e) {
      showSnackbar(SnackbarMessage.error, e.toString());
    }
  }

  bool validate() {
    if (emailController.text.trim().isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your email.');
      return false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      showSnackbar(SnackbarMessage.error, 'Invalid Email.');
      return false;
    } else {
      return true;
    }
  }
}
