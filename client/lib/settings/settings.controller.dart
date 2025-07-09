import 'package:client/settings/board_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDark = true.obs;
  var selectedColorScheme = boardColorSchemes.first.obs;

  void changeColorScheme(BoardColorScheme scheme) {
    selectedColorScheme.value = scheme;
  }

  void toggleTheme(bool v) {
    isDark.value = v;
    Get.changeThemeMode(v ? ThemeMode.dark : ThemeMode.light);
  }
}
