import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDark = true.obs;

  void toggleTheme(bool v) {
    isDark.value = v;
    Get.changeThemeMode(v ? ThemeMode.dark : ThemeMode.light);
  }
}
