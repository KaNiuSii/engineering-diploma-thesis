import 'package:client/widgets/app_scaffold.dart';
import 'package:client/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Welcome to KW Chess',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
