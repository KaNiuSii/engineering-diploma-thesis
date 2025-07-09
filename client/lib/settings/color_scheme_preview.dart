import 'package:client/settings/board_color_scheme.dart';
import 'package:flutter/material.dart';

class ColorSchemePreview extends StatelessWidget {
  final BoardColorScheme scheme;
  final bool selected;
  final VoidCallback onTap;

  const ColorSchemePreview({
    Key? key,
    required this.scheme,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          color:
              selected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
                  : null,
        ),
        child: Row(
          children: [
            // Mini podgląd dwóch kwadratów (jasny i ciemny)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: scheme.light,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: scheme.dark,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              scheme.name,
              style: TextStyle(
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
