import 'package:companionapp/controllers/main_controller.dart';
import 'package:companionapp/enums/snackbar_message.dart';
import 'package:companionapp/helpers/local_storage.dart';
import 'package:companionapp/models/user_model.dart';
import 'package:companionapp/res/alert_messages.dart';
import 'package:companionapp/screens/home/home_screen.dart';
import 'package:companionapp/services/auth_service.dart';
import 'package:companionapp/services/user_service.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final MainController _mainController = Get.put(MainController());

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    try {
      loading(true);
      User? user = await AuthService.signIn(
        emailController.text.trim(),
        passwordController.text,
      );
      if (user != null) {
        UserModel? userModel = await UserService.getUserDetails(user.uid);
        if (userModel != null) {
          await LocalStorage.saveUser(userModel);
          _mainController.getCurrentUser();
          emailController.clear();
          passwordController.clear();
          loading(false);
          Get.offAll(() => const HomeScreen());
        } else {
          await FirebaseAuth.instance.signOut();
          loading(false);
          showSnackbar(SnackbarMessage.error,
              'No user record found with these credentials.');
        }
      } else {
        loading(false);
        showSnackbar(SnackbarMessage.error, AlertMessages.somethingWentWrong);
      }
    } catch (e) {
      loading(false);
      showSnackbar(SnackbarMessage.error, e.toString());
    }
  }

  bool validate() {
    if (emailController.text.trim().isEmpty &&
        passwordController.text.isEmpty) {
      showSnackbar(
          SnackbarMessage.missing, 'Please enter your email and password.');
      return false;
    } else if (emailController.text.trim().isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your email.');
      return false;
    } else if (passwordController.text.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your password.');
      return false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      showSnackbar(SnackbarMessage.error, 'Invalid Email.');
      return false;
    } else {
      return true;
    }
  }
}
