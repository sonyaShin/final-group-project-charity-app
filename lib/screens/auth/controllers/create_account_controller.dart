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
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  final MainController _mainController = Get.put(MainController());

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void createAccount() async {
    try {
      loading(true);
      User? user = await AuthService.signUp(
        emailController.text.trim(),
        passwordController.text,
      );
      if (user != null) {
        UserModel userModel = UserModel(
          uid: user.uid,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );
        await UserService.saveUser(userModel);
        await LocalStorage.saveUser(userModel);
        _mainController.getCurrentUser();
        loading(false);
        Get.offAll(() => const HomeScreen());
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
    if (nameController.text.trim().isEmpty &&
        emailController.text.trim().isEmpty &&
        passwordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter all details.');
      return false;
    } else if (nameController.text.trim().isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your Name.');
      return false;
    } else if (emailController.text.trim().isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your email.');
      return false;
    } else if (passwordController.text.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please enter your password.');
      return false;
    } else if (confirmPasswordController.text != passwordController.text) {
      showSnackbar(SnackbarMessage.missing, 'Enter same password to confirm.');
      return false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      showSnackbar(SnackbarMessage.error, 'Invalid Email.');
      return false;
    } else {
      return true;
    }
  }
}
