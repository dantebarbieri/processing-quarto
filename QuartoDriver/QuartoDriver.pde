Piece[] pieces;
Board board;
Piece selected;
boolean turn;

void setup() {
  fullScreen();
  rectMode(CENTER);
  textAlign(CENTER);
  strokeWeight(15);
  pieces = new Piece[]{
            new Piece(true , true , true , true , 0, 0, 0),
            new Piece(true , true , true , false, 0, 0, 0),
            new Piece(true , true , false, true , 0, 0, 0),
            new Piece(true , true , false, false, 0, 0, 0),
            new Piece(true , false, true , true , 0, 0, 0),
            new Piece(true , false, true , false, 0, 0, 0),
            new Piece(true , false, false, true , 0, 0, 0),
            new Piece(true , false, false, false, 0, 0, 0),
            new Piece(false, true , true , true , 0, 0, 0),
            new Piece(false, true , true , false, 0, 0, 0),
            new Piece(false, true , false, true , 0, 0, 0),
            new Piece(false, true , false, false, 0, 0, 0),
            new Piece(false, false, true , true , 0, 0, 0),
            new Piece(false, false, true , false, 0, 0, 0),
            new Piece(false, false, false, true , 0, 0, 0),
            new Piece(false, false, false, false, 0, 0, 0),
            };
  board = new Board();
  selected = null;
  turn = false;
}

void draw() {
  background(0);
  board.show();
}