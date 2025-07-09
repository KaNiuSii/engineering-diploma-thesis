import 'package:client/settings/settings.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  Get.put(SettingsController(), permanent: true);
  runApp(const KWChessApp());
}

class KWChessApp extends StatelessWidget {
  const KWChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KW Chess',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFFF5F5F7),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFF18161A),
        ),
        themeMode:
            settingsController.isDark.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: AppRoutes.home,
        getPages: AppPages.pages,
      ),
    );
  }
}
