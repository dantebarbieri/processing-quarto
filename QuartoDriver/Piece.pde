class Piece {
  private boolean played, tall, round, dark, holed;
  private float x, y, r;

  public Piece(boolean t, boolean r, boolean d, boolean h, float x, float y, float rad) {
    played = false;
    tall = t;
    round = r;
    dark = d;
    holed = h;
    this.x = x;
    this.y = y;
    this.r = rad;
  }

  public Piece copyAttributes(float x, float y, float r) {
    return new Piece(tall, round, dark, holed, x, y, r);
  }

  public boolean clicked() {
    if (this.round) {
      return Math.hypot(mouseX - x, mouseY - y) < r;
    }else{
      return x < mouseX && mouseX < x + r && y < mouseY && mouseY < y + r;
    }
  }

  public boolean getPlayed() {
    return played;
  }

  public boolean setPlayed(boolean b) {
    boolean ret = this.played == b;
    this.played = b;
    return ret;
  }

  public boolean[] compareTo(Piece other) {
    boolean[] comparison = {this.tall == other.tall, this.round == other.round, this.dark == other.dark, this.holed == other.holed};
    return comparison;
  }

  public boolean[] compareToMultiple(Piece[] others) {
    boolean t = true, r = true, d = true, h = true;
    int index = 0;
    while (index < others.length && (t || r || d || h)) {//800 IQ Loop
      t = t && this.tall == others[index].tall;
      r = r && this.round == others[index].round;
      d = d && this.dark == others[index].dark;
      h = h && this.holed == others[index].holed;
      index++;
    }
    boolean[] comparison = {t, r, d, h};
    return comparison;
  }

  public void show(float x, float y, float r) {
    if (this.dark) {
      fill(51, 32, 0);
    } else {
      fill(229, 180, 135);
    }
    if (this.round) {
      ellipse(x, y, r, r);
    } else {
      rect(x, y, r, r);
    }
    if (this.holed) {
      fill(26, 26, 26);
      ellipse(x, y, r / 2, r / 2);
    }
    fill(180, 180, 180);
    textSize(r / 2);
    if (this.tall) {
      text("T", x, y);
    } else {
      text("S", x, y);
    }
  }
}