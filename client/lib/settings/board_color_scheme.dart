import 'dart:ui';

class BoardColorScheme {
  final Color light;
  final Color dark;

  final Color lastMove; // overlay on origin + dest of previous move
  final Color hover; // overlay while a legal piece hovers
  final Color dragDot; // small dot shown on every legal target
  final Color check; // king in check (light red)
  final Color mate; // king mated (dark red)

  final String name;

  const BoardColorScheme({
    required this.light,
    required this.dark,
    required this.lastMove,
    required this.hover,
    required this.dragDot,
    required this.check,
    required this.mate,
    required this.name,
  });
}

const List<BoardColorScheme> boardColorSchemes = [
  BoardColorScheme(
    name: 'Classic',
    light: Color(0xFFD7B899),
    dark: Color(0xFFB58863),
    lastMove: Color(0xFF66BB6A), // medium green
    hover: Color(0xFFFFF176), // soft yellow
    dragDot: Color(0xFFFFEB3B), // pure yellow
    check: Color(0xFFFF7043), // orange-red
    mate: Color(0xFFD32F2F), // deep red
  ),

  BoardColorScheme(
    name: 'Bubblegum',
    light: Color(0xFF5EABD6),
    dark: Color(0xFFFFB4B4),
    lastMove: Color(0xFF26C6DA), // aqua
    hover: Color(0xFFFFF59D), // pastel yellow
    dragDot: Color(0xFFFFF176),
    check: Color(0xFFFF6F61), // pink-coral
    mate: Color(0xFFE91E63), // vivid pink
  ),

  BoardColorScheme(
    name: 'Night',
    light: Color(0xFF483AA0),
    dark: Color(0xFF0E2148),
    lastMove: Color(0xFF29B6F6), // bright blue
    hover: Color(0xFFFFF176),
    dragDot: Color(0xFFFFEB3B),
    check: Color(0xFFFF5252),
    mate: Color(0xFFD50000),
  ),

  BoardColorScheme(
    name: 'Royal',
    light: Color(0xFFFFF6E9),
    dark: Color(0xFF8174A0),
    lastMove: Color(0xFF8BC34A), // fresh green
    hover: Color(0xFFFFF59D),
    dragDot: Color(0xFFFFF176),
    check: Color(0xFFFF7043),
    mate: Color(0xFFD32F2F),
  ),

  BoardColorScheme(
    name: 'Forest',
    light: Color(0xFF859F3D),
    dark: Color(0xFF31511E),
    lastMove: Color(0xFF66BB6A),
    hover: Color(0xFFFFF59D),
    dragDot: Color(0xFFFFF176),
    check: Color(0xFFFF7043),
    mate: Color(0xFFD32F2F),
  ),

  BoardColorScheme(
    name: 'Sky',
    light: Color(0xFFDFF2EB),
    dark: Color(0xFF7AB2D3),
    lastMove: Color(0xFF4DB6AC), // teal
    hover: Color(0xFFFFF59D),
    dragDot: Color(0xFFFFF176),
    check: Color(0xFFFF5252),
    mate: Color(0xFFD50000),
  ),
];
