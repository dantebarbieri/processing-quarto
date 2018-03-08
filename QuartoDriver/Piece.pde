class Piece {
  private boolean tall, round, dark, holed;

  public Piece(boolean t, boolean r, boolean d, boolean h) {
    tall = t;
    round = r;
    dark = d;
    holed = h;
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
  
  public void show(float x, float y, float r){
    if(this.dark){
      fill(26, 26, 26);
    }else{
      fill(229, 229, 229);
    }
    if(this.round){
      ellipse(x + r, y + r, r, r);
    }else{
      rect(x + r, y + r, r, r);
    }
  }
}