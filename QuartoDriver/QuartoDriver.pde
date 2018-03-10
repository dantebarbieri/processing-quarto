import processing.sound.*;

Piece[] pieces;
Board board;
Piece selected;
boolean turn, over;
Primary[] primaries;
Particle[] particles;
SoundFile[] piece_play;
SoundFile piece_selected;
SoundFile piece_deselected;
SoundFile piece_changed;
SoundFile victory;
SoundFile tie_game;

void setup() {
  fullScreen();
  rectMode(CENTER);
  textAlign(CENTER);
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

  primaries = new Primary[15];
  for (int i = 0; i < primaries.length; i++) {
    primaries[i] = new Primary(random(50, 150), new PVector(random(2 * width / 3 + 3 * height / 14 - 17 * height / 56, 2 * width / 3 + 3 * height / 14 + 17 * height / 56), random(height - (height / 10 + 3 * height / 34) - 17 * height / 112, height - (height / 10 + 3 * height / 34) + 17 * height / 112)), new PVector(random(-5, 5), random(-5, 5)));
  }
  particles = new Particle[15];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(new PVector(random(width / 5, 4 * width / 5), random(height / 5, 4 * height / 5)), new PVector(random(-10, 10), random(-10, 10)), new PVector(0, 0), random(50, 70));
  }
  piece_play = new SoundFile[4];
  piece_play[0] = new SoundFile(this, "quarto_piece_play_1.wav");
  piece_play[1] = new SoundFile(this, "quarto_piece_play_2.wav");
  piece_play[2] = new SoundFile(this, "quarto_piece_play_3.wav");
  piece_play[3] = new SoundFile(this, "quarto_piece_play_4.wav");
  piece_selected = new SoundFile(this, "quarto_piece_selected.mp3");
  piece_deselected = new SoundFile(this, "quarto_piece_deselected.mp3");
  piece_changed = new SoundFile(this, "quarto_piece_changed.mp3");
  victory = new SoundFile(this, "victory_sound.mp3");
  tie_game = new SoundFile(this, "tie_game_sound.mp3");
  piece_selected.rate(0.5);
  piece_deselected.rate(0.5);
  piece_changed.rate(0.5);
  tie_game.rate(0.5);
}

void draw() {
  if (!over) {
    background(0);
    //fill(random(255));
    //rect(2 * width / 3 + 3 * height / 14, height - (height / 10 + 3 * height / 34), 17 * height / 28, 17 * height / 56);
    for (Primary primary : primaries) {
      primary.update(); 
      //primary.show();
    }
    for (Particle particle : particles) {
      particle.update(); 
      particle.show();
    }
    board.show();
    drawPieceMat();
    for (Piece piece : pieces) {
      piece.show();
    }
    selected.show();
    textSize(height / 10);
    fill(255);
    if (board.gameOver()) {
      if (turn) {
        text("Player 1 Wins!", 3 * width / 4, 3 * height / 4);
      } else {
        text("Player 2 Wins!", 3 * width / 4, 3 * height / 4);
      }
      victory.play();
      over = true;
    } else if (board.tieGame()) {
      text("Tie Game!", 3 * width / 4, 3 * height / 4);
      tie_game.play();
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
}

void drawPieceMat() {
  fill(55, 0, 0);
  float x = 2 * width / 3 + 3 * height / 14;
  float y = height / 10 + 3 * height / 14;
  rect(x, y, 17 * height / 28, 17 * height / 28);
}

void keyTyped() {
  if (key == 'r' || key == 'R') {
    setup();
    draw();
  }
}

void mousePressed() {
  boolean play = false;
  boolean deselect = false;
  boolean select = false;
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
        deselect = true;
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
      select = true;
      break Selecting;
    }
  }
  if (!over) {
    if (play) {
      piece_play[(int)random(piece_play.length)].play();
    } else {
      if (select && deselect) {
        piece_changed.play();
      } else if (select) {
        piece_selected.play();
      } else if (deselect) {
        piece_deselected.play();
      }
    }
  }
}