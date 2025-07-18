import 'package:get/get.dart';
import 'settings.controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<SettingsController>(() => SettingsController());
}
