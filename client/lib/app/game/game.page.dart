import 'package:client/app/game/chess_board.dart';
import 'package:client/app/game/control_panel.dart';
import 'package:client/app/settings/settings.controller.dart';
import 'package:client/app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game.controller.dart';

class GamePage extends GetView<GameController> {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Obx(
                () => ChessBoard(
                  game: controller.game.value,
                  colorScheme:
                      Get.find<SettingsController>().selectedColorScheme.value,
                  madeMove: controller.madeMove,
                  orientationWhite: controller.whiteAtBottom.value,
                  historyCount: controller.historyVersion.value,
                  gameStarted: controller.gameStarted.value,
                ),
              ),
            ),
          ),
          ControlPanel(),
        ],
      ),
    );
  }
}
