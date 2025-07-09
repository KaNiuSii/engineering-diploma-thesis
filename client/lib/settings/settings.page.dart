import 'package:client/widgets/app_scaffold.dart';
import 'package:client/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings.controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Obx(
                  () => SwitchListTile(
                    title: const Text('Dark Mode'),
                    value: controller.isDark.value,
                    onChanged: controller.toggleTheme,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
