import 'package:client/game/chess_board.dart';
import 'package:client/game/control_panel.dart';
import 'package:client/settings/settings.controller.dart';
import 'package:client/widgets/app_scaffold.dart';
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
                  game: controller.game,
                  colorScheme:
                      Get.find<SettingsController>().selectedColorScheme.value,
                  madeMove: controller.madeMove,
                  orientationWhite: controller.whiteAtBottom.value,
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
