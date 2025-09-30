package main

import (
	"encoding/json"
	"log"
	"net/http"

	ch "github.com/notnil/chess"
)

type bestMoveRequest struct {
	FEN   string `json:"fen"`
	Depth int    `json:"depth,omitempty"`
}

type bestMoveResponse struct {
	Move  string `json:"move"`
	Score int    `json:"score"`
	Error string `json:"error"`
}

func bestMoveHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "only POST", http.StatusMethodNotAllowed)
		return
	}

	var req bestMoveRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid json", http.StatusBadRequest)
		return
	}

	if req.Depth <= 0 {
		req.Depth = 4 // domyślnie 4 półruchy
	}

	// dekoduj FEN
	game, err := decodeFEN(req.FEN)
	if err != nil {
		respond(w, bestMoveResponse{Error: err.Error()})
		return
	}

	mv, score := FindBestMove(game, req.Depth)
	if mv == nil {
		respond(w, bestMoveResponse{Error: "no legal moves", Score: score})
		return
	}

	pos := game.Position()
	uci := ch.UCINotation{}.Encode(pos, mv)
	respond(w, bestMoveResponse{Move: uci, Score: score})
}

// decodeFEN zwraca *ch.Position z FEN‑a lub pozycję startową gdy fen=="".
func decodeFEN(fen string) (*ch.Game, error) {
	if fen == "" {
		g := ch.NewGame()
		return g, nil
	}

	opt, err := ch.FEN(fen)
	if err != nil {
		return nil, err
	}

	g := ch.NewGame(opt)
	return g, nil
}

func respond(w http.ResponseWriter, resp bestMoveResponse) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func main() {
	http.HandleFunc("/bestmove", bestMoveHandler)
	log.Println("Chess engine API listening on :8080 … POST /bestmove")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
