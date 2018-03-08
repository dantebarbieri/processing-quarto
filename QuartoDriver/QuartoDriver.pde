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
  float s = 9 * height / 10;
  float x = (height / 10 + s) / 2;
  float y = height / 2;
  fill(30, 17, 0);
  rect(x, y, s, s);

  s = s * 9 / 40;
  fill(45, 32, 0);
  stroke(180, 180, 40);
  for (float i = x - 9 * height / 20 + s / 2 + height / 80; i < x + 9 * height / 20; i += 9 * height / 40) {
    for (float j = y - 9 * height / 20 + s / 2 + height / 80; j < y + 9 * height / 20; j += 9 * height / 40) {
      ellipse(i, j, s, s);
    }
  }

  noFill();
  stroke(180, 180, 180);
  strokeWeight(15);
}