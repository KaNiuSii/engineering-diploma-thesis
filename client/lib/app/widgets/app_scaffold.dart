import 'package:client/app/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  final String? title;

  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 800;

        if (isWide) {
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [const SideMenu(), Expanded(child: body)],
            ),
            floatingActionButton: floatingActionButton,
          );
        }

        return Scaffold(
          appBar: _buildAppBar(context, drawerMode: true),
          drawer: const Drawer(child: SideMenu()),
          body: body,
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context, {
    bool drawerMode = false,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: title != null ? Text(title!) : null,
      automaticallyImplyLeading: drawerMode,
      elevation: 0,
    );
  }
}
