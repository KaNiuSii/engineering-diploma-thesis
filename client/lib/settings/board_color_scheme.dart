import 'dart:ui';

class BoardColorScheme {
  final Color light;
  final Color dark;
  final String name;

  const BoardColorScheme({
    required this.light,
    required this.dark,
    required this.name,
  });
}

const List<BoardColorScheme> boardColorSchemes = [
  BoardColorScheme(
    name: "Classic",
    light: Color(0xFFD7B899),
    dark: Color(0xFFB58863),
  ),
  BoardColorScheme(
    name: "Green",
    light: Color(0xFFEEEED2),
    dark: Color(0xFF769656),
  ),
  BoardColorScheme(
    name: "Blue",
    light: Color(0xFFE0E9F3),
    dark: Color(0xFF4682B4),
  ),
];
