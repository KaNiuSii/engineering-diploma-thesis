import 'package:client/widgets/app_scaffold.dart';
import 'package:client/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'history.controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Row(
        children: [
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.all(24),
                itemCount: controller.games.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, idx) {
                  final g = controller.games[idx];
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text('Game #${idx + 1}'),
                    subtitle: Text(
                      g.pgn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => controller.openGame(g),
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
