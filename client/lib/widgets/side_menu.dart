import 'package:client/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool _hovered = false;

  static const double _collapsed = 64;
  static const double _expanded = 240;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _hovered ? _expanded : _collapsed,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [BoxShadow(offset: Offset(2, 0), blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            _item(icon: Icons.home, label: 'Home', route: AppRoutes.home),
            _item(icon: Icons.gamepad, label: 'Game', route: AppRoutes.game),
            _item(
              icon: Icons.history,
              label: 'History',
              route: AppRoutes.history,
            ),
            _item(
              icon: Icons.settings,
              label: 'Settings',
              route: AppRoutes.settings,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String label,
    required String route,
  }) {
    final bool showLabel = _hovered;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => Get.toNamed(route),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        height: 48,
        child: Row(
          children: [
            Icon(icon, size: 24),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: showLabel ? 120 : 0,
              curve: Curves.ease,
              child:
                  showLabel
                      ? Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          label,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
