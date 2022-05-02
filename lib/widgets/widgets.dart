import 'package:companionapp/enums/snackbar_message.dart';
import 'package:companionapp/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget circularProgress({Color color = AppColors.primaryColor}) {
  return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color));
}

void showSnackbar(SnackbarMessage messageType, String msg,
    {Color textolor = Colors.white}) {
  Get.snackbar(
    messageType == SnackbarMessage.error
        ? 'Error'
        : messageType == SnackbarMessage.success
            ? 'Success'
            : 'Missing',
    msg,
    backgroundColor: messageType == SnackbarMessage.error
        ? Colors.red
        : messageType == SnackbarMessage.success
            ? Colors.green
            : Colors.orangeAccent,
    colorText: textolor,
  );
}
