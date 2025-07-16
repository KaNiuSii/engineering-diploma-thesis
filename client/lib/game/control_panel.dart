import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chess/chess.dart' as ch;
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
          const SizedBox(height: 12),

          Obx(
            () => DropdownButton<bool>(
              value: c.playerWhite.value,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: true, child: Text('Play White')),
                DropdownMenuItem(value: false, child: Text('Play Black')),
              ],
              onChanged: (x) => c.changeSide(),
            ),
          ),

          const Divider(height: 32),

          Obx(
            () => SwitchListTile.adaptive(
              title: const Text('Flip board'),
              value: !c.whiteAtBottom.value,
              onChanged: (_) => c.flipBoard(),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),

          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: c.reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset game'),
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
                          final ply = i + 1;
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
