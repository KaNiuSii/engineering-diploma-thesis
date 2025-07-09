import 'package:client/widgets/app_scaffold.dart';
import 'package:client/widgets/chess_board.dart';
import 'package:client/widgets/side_menu.dart';
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
            child: GetBuilder<GameController>(
              builder: (_) => Center(child: ChessBoard(game: controller.game)),
            ),
          ),
        ],
      ),
    );
  }
}
