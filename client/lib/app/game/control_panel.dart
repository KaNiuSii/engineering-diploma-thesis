import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'game.controller.dart';

class ControlPanel extends StatelessWidget {
  ControlPanel({super.key});

  final GameController c = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Controls', style: textTheme.titleLarge),
          const Divider(height: 32),
          Text('Game', style: textTheme.titleMedium),

          Obx(
            () => Center(
              child: DropdownButton<bool>(
                value: c.playerWhite.value,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: true, child: Text('Play White')),
                  DropdownMenuItem(value: false, child: Text('Play Black')),
                ],
                onChanged: c.gameStarted.value ? null : (x) => c.changeSide(),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Obx(
            () => Center(
              child: FilledButton.icon(
                onPressed: c.gameStarted.value ? null : () => c.startGame(),
                label: Text('Start'),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Obx(
            () => Center(
              child: SwitchListTile.adaptive(
                title: const Text('Flip board'),
                value: !c.whiteAtBottom.value,
                onChanged: (_) => c.flipBoard(),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: FilledButton.icon(
              onPressed: c.reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset game'),
            ),
          ),

          Obx(
            () =>
                c.aiThinking.value
                    ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 200,
                      ),
                    )
                    : SizedBox.shrink(),
          ),

          const Divider(height: 32),

          Text('Moves', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(
              () =>
                  c.historyVersion.value == 0
                      ? SizedBox.shrink()
                      : ListView.builder(
                        itemCount: c.game.value.getHistory().length,
                        itemBuilder: (_, i) {
                          final prefix =
                              (i.isEven) ? '${(i ~/ 2) + 1}. ' : '   … ';
                          return Text(
                            '$prefix${c.game.value.getHistory()[i]}',
                            style: textTheme.bodyMedium,
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
