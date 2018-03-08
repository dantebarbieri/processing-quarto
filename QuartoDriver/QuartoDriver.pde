Piece[] pieces;
Board board;
Piece selected;
boolean turn;

void setup() {
  fullScreen();
  rectMode(CENTER);
}

void draw() {
  background(0);
  board.show();
}