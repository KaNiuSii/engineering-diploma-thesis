import 'package:client/app/settings/board_color_scheme.dart';
import 'package:client/app/settings/color_scheme_preview.dart';
import 'package:client/app/widgets/app_scaffold.dart';
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
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: Text(
                    'Chess board color',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        boardColorSchemes.map((scheme) {
                          final isSelected =
                              controller.selectedColorScheme.value == scheme;
                          return ColorSchemePreview(
                            scheme: scheme,
                            selected: isSelected,
                            onTap: () => controller.changeColorScheme(scheme),
                          );
                        }).toList(),
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
