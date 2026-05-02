import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error'}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(text: title),
    messageText: Text(message),
    snackPosition: SnackPosition.TOP,
  );
}
