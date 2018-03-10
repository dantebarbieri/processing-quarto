class Ring {
  public PVector pos;
  public float age, r;
  public float[] colors;

  public Ring(PVector p, float rad, float a, float[] c) {
    pos = p.copy();
    r = rad;
    age = a;
    colors = c;
  }

  public float update() {
    if (age < 0) {
      return -1;
    }
    PVector vel = PVector.random2D().mult(random(5));
    pos.add(vel);
    age--;
    return age;
  }

  public void show() {
    stroke(noise(colors[0]) * 255, noise(colors[1]) * 255, noise(colors[2]) * 255);
    strokeWeight(1.5);
    noFill();
    ellipse(pos.x, pos.y, r, r);
    colors[0] += 0.05;
    colors[1] += 0.05;
    colors[2] += 0.05;
  }
}