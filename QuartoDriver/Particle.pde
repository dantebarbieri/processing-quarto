class Particle {
  public PVector pos, vel, acc;
  public float r, ringAge, rpos, gpos, bpos;
  public ArrayList<Ring> rings;

  public Particle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-10, 10), random(-10, 10));
    acc = new PVector(0, 0);
    r = 50;
    rpos = random(10000);
    gpos = random(10000);
    bpos = random(10000);
    ringAge = random(5, 25);
    rings = new ArrayList<Ring>();
  }

  public Particle(PVector p, PVector v, PVector a, float radius) {
    pos = p.copy();
    vel = v.copy();
    acc = a.copy();
    r = radius;
    rpos = random(10000);
    gpos = random(10000);
    bpos = random(10000);
    ringAge = random(5, 25);
    rings = new ArrayList<Ring>();
  }

  public void update(Primary[] primaries) {
    acc = new PVector(0, 0);
    for (Primary primary : primaries) {
      PVector r = new PVector(primary.pos.x - pos.x, primary.pos.y - pos.y);
      PVector rHat = r.copy().normalize();
      acc.add(rHat.mult(primary.m / r.magSq()));
    }
    acc.normalize();
    vel.add(acc);
    vel.limit(15);
    pos.add(vel);
    if (pos.x > width) {
      pos.x = width;
    }
    if (pos.x < 0) {
      pos.x = 0;
    }
    if (pos.y > height) {
      pos.y = height;
    }
    if (pos.y < 0) {
      pos.y = 0;
    }
    if (rings.size() < 500) {
      rings.add(new Ring(pos, random(2 * r / 3, 4 * r / 3), ringAge, new float[]{rpos, gpos, bpos}));
    }
  }

  public void show() {
    fill(noise(rpos) * 255, noise(gpos) * 255, noise(bpos) * 255);
    noStroke();
    ellipse(pos.x, pos.y, r, r);
    for (int i = rings.size() - 1; i >= 0; i--) {
      rings.get(i).show();
      if (rings.get(i).update() == -1) {
        rings.remove(i);
      }
    }
    rpos += 0.05;
    gpos += 0.05;
    bpos += 0.05;
  }
}