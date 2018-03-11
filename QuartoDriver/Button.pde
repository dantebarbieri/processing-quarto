class Button {
  public String text;
  public PVector pos;
  public float size;
  public color bg, tx, hb, ht;
  public boolean hoverable;

  public Button(String t, PVector p, float s, color bc, color tc) {
    text = t;
    pos = p.copy();
    size = s;
    bg = bc;
    tx = tc;
    hoverable = false;
  }

  public Button(String t, PVector p, float s, color bc, color tc, color hbc, color htc) {
    text = t;
    pos = p.copy();
    size = s;
    bg = bc;
    tx = tc;
    hb = hbc;
    ht = htc;
    hoverable = true;
  }

  public void show() {
    if (hoverable && clicked()) {
      fill(hb);
      textSize(size);
      rect(pos.x, pos.y - size, textWidth(text), 4 * size / 3);
      fill(ht);
      text(text, pos.x, pos.y);
    } else {
      fill(bg);
      textSize(size);
      rect(pos.x, pos.y - size, textWidth(text), 4 * size / 3);
      fill(tx);
      text(text, pos.x, pos.y);
    }
  }

  public boolean clicked() {
    textSize(size);
    return pos.x < mouseX && mouseX < pos.x + textWidth(text) && pos.y - size < mouseY && mouseY < pos.y + size / 3;
  }
}