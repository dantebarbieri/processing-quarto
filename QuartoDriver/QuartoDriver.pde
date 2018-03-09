Piece[] pieces;
Board board;
Piece selected;
boolean turn, over;
float rpos, gpos, bpos;

void setup() {
  fullScreen();
  rectMode(CENTER);
  textAlign(CENTER);
  strokeWeight(15);
  float x, y, r;
  x = 2 * width / 3;
  y = height / 10;
  r = height / 7;
  pieces = new Piece[]{
    new Piece(true, true, true, true, x, y, 9 * r / 11), 
    new Piece(true, true, true, false, x + r, y, 9 * r / 11), 
    new Piece(true, true, false, true, x + 2 * r, y, 9 * r / 11), 
    new Piece(true, true, false, false, x + 3 * r, y, 9 * r / 11), 
    new Piece(true, false, true, true, x, y + r, 9 * r / 11), 
    new Piece(true, false, true, false, x + r, y + r, 9 * r / 11), 
    new Piece(true, false, false, true, x + 2 * r, y + r, 9 * r / 11), 
    new Piece(true, false, false, false, x + 3 * r, y + r, 9 * r / 11), 
    new Piece(false, true, true, true, x, y + 2 * r, 9 * r / 11), 
    new Piece(false, true, true, false, x + r, y + 2 * r, 9 * r / 11), 
    new Piece(false, true, false, true, x + 2 * r, y + 2 * r, 9 * r / 11), 
    new Piece(false, true, false, false, x + 3 * r, y + 2 * r, 9 * r / 11), 
    new Piece(false, false, true, true, x, y + 3 * r, 9 * r / 11), 
    new Piece(false, false, true, false, x + r, y + 3 * r, 9 * r / 11), 
    new Piece(false, false, false, true, x + 2 * r, y + 3 * r, 9 * r / 11), 
    new Piece(false, false, false, false, x + 3 * r, y + 3 * r, 9 * r / 11)
  };
  board = new Board();
  selected = new Piece(false, 8 * width / 9, 8 * height / 9, height / 6);
  turn = false;
  over = false;
  selected.setPlayed(true);
  rpos = random(10000);
  gpos = random(10000);
  bpos = random(10000);
}

void draw() {
  if (!over) {
    background(255 * noise(rpos), 255 * noise(gpos), 255 * noise(bpos));
    board.show();
    //fill(51, 35, 0);
    //rect(41 * height / 80, height / 2, 9 * height / 10, 9 * height / 10);
    for (Piece piece : pieces) {
      piece.show();
    }
    selected.show();
    textSize(height / 10);
    fill(255 * (1 - noise(rpos)), 255 * (1 - noise(gpos)), 255 * (1 - noise(bpos)));
    if (board.gameOver()) {
      if (turn) {
        text("Player 1 Wins!", 3 * width / 4, 3 * height / 4);
      } else {
        text("Player 2 Wins!", 3 * width / 4, 3 * height / 4);
      }
      over = true;
    } else {
      if (selected.getSelection()) {
        if (turn) {
          text("Player 2 Move", 3 * width / 4, 3 * height / 4);
        } else {
          text("Player 1 Move", 3 * width / 4, 3 * height / 4);
        }
      } else {
        if (turn) {
          text("Player 1 Select", 3 * width / 4, 3 * height / 4);
        } else {
          text("Player 2 Select", 3 * width / 4, 3 * height / 4);
        }
      }
    }
  }
  rpos += 0.01;
  gpos += 0.01;
  bpos += 0.01;
}

void keyTyped() {
  if (key == 'r' || key == 'R') {
    setup();
    draw();
  }
}

void mousePressed() {
  boolean play = false;
Playing:
  if (selected.getSelection()) {
    for (int i = 0; i < board.grid.length; i++) {
      for (int j = 0; j < board.grid[i].length; j++) {
        if (board.grid[i][j].piece == null && board.grid[i][j].clicked()) {
          board.play(selected, i, j);
          selected.setSelection(false);
          for (int k = 0; k < pieces.length; k++) {
            if (pieces[k].equals(selected)) {
              pieces[k].setPlayed(true);
            }
          }
          turn = !turn;
          play = true;
          break Playing;
        }
      }
    }
  }
Deselecting:
  if (selected.getSelection()) {
    for (int i = 0; i < pieces.length; i++) {
      if (pieces[i].equals(selected)) {
        pieces[i].setSelection(true);
        selected.setSelection(false);
        break Deselecting;
      }
    }
  }
Selecting:
  for (int i = 0; i < pieces.length; i++) {
    if (!pieces[i].getPlayed() && pieces[i].clicked()) {
      selected = pieces[i].copyAttributes(selected.x, selected.y, selected.r);
      selected.setSelection(true);
      pieces[i].setSelection(false);
      break Selecting;
    }
  }
}