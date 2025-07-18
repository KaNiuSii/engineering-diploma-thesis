import 'package:hive/hive.dart';

part 'game_history.g.dart';

@HiveType(typeId: 0)
class GameHistory extends HiveObject {
  @HiveField(0)
  late List<String> movesSAN; // np. ['e4', 'e5', 'Nf3', ...]

  @HiveField(1)
  late String pgn; // pełny PGN dla analizy

  @HiveField(2)
  late DateTime startedAt;

  @HiveField(3)
  late DateTime endedAt;

  @HiveField(4)
  late bool playerWhite; // true = grałeś białymi

  @HiveField(5)
  late bool vsAi; // true = gra z AI

  GameHistory({
    required this.movesSAN,
    required this.pgn,
    required this.startedAt,
    required this.endedAt,
    required this.playerWhite,
    required this.vsAi,
  });
}
