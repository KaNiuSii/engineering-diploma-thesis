import 'package:client/app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'history.controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // AppScaffold jeśli wolisz
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: controller.games.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, idx) {
            final g = controller.games[idx];

            // Wynik z PGN-a
            final result =
                g.pgn.contains('1-0')
                    ? '1-0'
                    : g.pgn.contains('0-1')
                    ? '0-1'
                    : '½-½';

            final date = DateFormat(
              'yyyy-MM-dd HH:mm',
            ).format(g.endedAt.toLocal());

            return ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                'Partia ${controller.games.length - idx}  •  $result',
              ),
              subtitle: Text('$date  •  ${g.movesSAN.length} ruchów'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.deleteGame(idx),
              ),
              onTap: () => controller.openGame(g),
            );
          },
        ),
      ),
    );
  }
}
