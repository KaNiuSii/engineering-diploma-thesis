import 'package:client/db/model/game_history.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class GameHistoryService extends GetxService {
  late Box<GameHistory> _box;

  Future<GameHistoryService> init() async {
    _box = await Hive.openBox<GameHistory>('games');
    return this;
  }

  List<GameHistory> get all => _box.values.toList();

  Stream<List<GameHistory>> watchAll() =>
      _box.watch().map((_) => _box.values.toList());

  Future<int> save(GameHistory game) => _box.add(game);

  Future<void> deleteAt(int index) => _box.deleteAt(index);

  Future<void> clear() => _box.clear();
}
