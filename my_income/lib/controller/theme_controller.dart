import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  static const String _isDarkModeKey = 'isDarkMode';
  var box = GetStorage();

  Future<void> init() async {
    isDarkMode.value = box.read(_isDarkModeKey) ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeTheme() async {
    isDarkMode.value = !isDarkMode.value;
    box.write(_isDarkModeKey, isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
