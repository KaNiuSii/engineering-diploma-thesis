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
    name: "Bubblegum",
    light: Color(0xFF5EABD6),
    dark: Color(0xFFFFB4B4),
  ),
  BoardColorScheme(
    name: "Night",
    light: Color(0xFF483AA0),
    dark: Color(0xFF0E2148),
  ),
  BoardColorScheme(
    name: "Royal",
    light: Color(0xFFFFF6E9),
    dark: Color(0xFF8174A0),
  ),
  BoardColorScheme(
    name: "Forest",
    light: Color(0xFF859F3D),
    dark: Color(0xFF31511E),
  ),
  BoardColorScheme(
    name: "Sky",
    light: Color(0xFFDFF2EB),
    dark: Color(0xFF7AB2D3),
  ),
];
