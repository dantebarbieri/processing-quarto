import processing.sound.*;

class MultiplayerGame {
  public Piece[] pieces;
  public Board board;
  public Piece selected;
  public boolean turn, over;
  public Primary[] primaries;
  public Particle[] particles;

  public MultiplayerGame() {
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
  }

  public void process() {
    if (!over) {
      background(0);
      //fill(random(255));
      //rect(2 * width / 3 + 3 * height / 14, height - (height / 10 + 3 * height / 34), 17 * height / 28, 17 * height / 56);
      for (Primary primary : primaries) {
        primary.update(); 
        //primary.show();
      }
      for (Particle particle : particles) {
        particle.update(primaries); 
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
}