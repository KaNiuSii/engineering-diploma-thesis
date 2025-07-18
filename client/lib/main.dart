import 'package:client/app/settings/settings.controller.dart';
import 'package:client/db/model/game_history.dart';
import 'package:client/db/service/game_history.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  Get.put(SettingsController(), permanent: true);

  // ================ HIVE ==================

  await Hive.initFlutter();

  Hive.registerAdapter(GameHistoryAdapter());

  await Get.putAsync<GameHistoryService>(() => GameHistoryService().init());

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
