import 'package:client/app/game/game.bindings.dart';
import 'package:client/app/game/game.page.dart';
import 'package:client/app/history/history.bindings.dart';
import 'package:client/app/history/history.page.dart';
import 'package:client/app/home/home.bindings.dart';
import 'package:client/app/home/home.page.dart';
import 'package:client/app/settings/settings.bindings.dart';
import 'package:client/app/settings/settings.page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.game,
      page: () => const GamePage(),
      binding: GameBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryPage(),
      binding: HistoryBindings(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBindings(),
    ),
  ];
}
