import 'package:client/game/game.controller.dart';
import 'package:get/get.dart';

class GameBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut<GameController>(() => GameController());
}
