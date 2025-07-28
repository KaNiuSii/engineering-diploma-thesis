import 'dart:convert';
import 'package:client/ai/i_bot.dart';
import 'package:http/http.dart' as http;
import 'package:chess/chess.dart' as ch;

class ApiBot implements IBot {
  ApiBot({
    this.url = 'http://localhost:8080/bestmove',
    this.depth = 5,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String url; // np. „http://192.168.0.42:8080/bestmove”
  final int depth; // domyślna głębokość wyszukiwania
  final http.Client _client;

  @override
  Future<ch.Move> playMove(ch.Chess game) async {
    final fen = game.fen; // FEN bieżącej pozycji
    final resp = await _client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{'fen': fen, 'depth': depth}),
    );

    if (resp.statusCode != 200) {
      throw Exception('Engine error ${resp.statusCode}: ${resp.body}');
    }

    final Map<String, dynamic> data = jsonDecode(resp.body);
    final String uci = data['move'] as String;

    return _uciToMove(game, uci);
  }

  /// Zamienia ciąg UCI („e2e4”, „a7a8q”…) na obiekt `ch.Move`.
  ch.Move _uciToMove(ch.Chess game, String uci) {
    final List<ch.Move> moves =
        game.generate_moves(); // legalne ruchy :contentReference[oaicite:0]{index=0}

    ch.Move? best;
    for (final m in moves) {
      final moveUci = _toUci(m);
      if (moveUci == uci) {
        best = m;
        break;
      }
    }
    if (best == null) {
      throw StateError('Engine zwrócił nielegalny ruch: $uci');
    }
    return best;
  }

  /// Tworzy zapis UCI z obiektu `Move` – porównujemy z ciągiem z backendu.
  String _toUci(ch.Move m) {
    final from =
        m.fromAlgebraic; // np. „e2” :contentReference[oaicite:1]{index=1}
    final to = m.toAlgebraic; // np. „e4”
    final promo = switch (m.promotion) {
      ch.PieceType.QUEEN => 'q',
      ch.PieceType.ROOK => 'r',
      ch.PieceType.BISHOP => 'b',
      ch.PieceType.KNIGHT => 'n',
      _ => '',
    };
    return '$from$to$promo';
  }
}
