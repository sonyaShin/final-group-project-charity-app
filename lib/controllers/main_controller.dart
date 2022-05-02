import 'package:companionapp/enums/snackbar_message.dart';
import 'package:companionapp/helpers/local_storage.dart';
import 'package:companionapp/models/user_model.dart';
import 'package:companionapp/screens/auth/login_screen.dart';
import 'package:companionapp/screens/home/home_screen.dart';
import 'package:companionapp/services/user_service.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  // Reads current user data from prefs and stores in currentUser varaible
  // which will be accessible throughout the app
  void getCurrentUser() {
    UserModel userModel = LocalStorage.readUser();
    currentUser(userModel);
  }

  Future<bool> refreshCurrentUser() async {
    try {
      UserModel? userModel =
          await UserService.getUserDetails(currentUser.value!.uid);
      if (userModel != null) {
        await LocalStorage.saveUser(userModel);
        getCurrentUser();
      }
      return true;
    } catch (e) {
      // Failed to refresh user
      return false;
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await LocalStorage.removeCurrentUser();
      currentUser(null);
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      showSnackbar(SnackbarMessage.error, e.toString());
    }
  }

  Widget getInitialScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginScreen();
    } else {
      if (LocalStorage.hasCurrentUser()) {
        getCurrentUser();
        return const HomeScreen();
      } else {
        FirebaseAuth.instance.signOut();
        return const LoginScreen();
      }
    }
  }
}
