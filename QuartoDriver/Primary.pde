class Primary {
  public PVector pos, vel, vel_0;
  public float m_0, m, mpos;

  public Primary() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-10, 10), random(-10, 10));
    vel_0 = vel.copy();
    m = random(50, 250);
    m_0 = m;
    mpos = random(10000);
  }

  public Primary(float mass, PVector p, PVector v) {
    pos = p.copy();
    vel = v.copy();
    vel_0 = vel.copy();
    m = mass;
    m_0 = m;
    mpos = random(10000);
  }

  public void update() {
    m += map(noise(mpos), 0, 1, -m_0 / 40, m_0 / 40);
    pos.add(vel);
    if (pos.x < (2 * width / 3 + 3 * height / 14 - 17 * height / 56) || pos.x > (2 * width / 3 + 3 * height / 14 + 17 * height / 56)) {
      vel.x *= -1;
    }
    if (pos.y < (height - (height / 10 + 3 * height / 34) - 17 * height / 112) || pos.y > (height / 10 + 3 * height / 14 + 17 * height / 112)) {
      vel.y *= -1;
    }
    vel.setMag(10 * vel_0.mag() * map(m, m_0 / 20, 21 * m_0 / 20, 1, 0.001));
    if (m < m_0 / 20) {
      m = m_0 / 20;
    }
    if (m > 21 * m_0 / 20) {
      m = 21 * m_0 / 20;
    }
    mpos += 0.25;
  }

  public void show() {
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, m, m);
  }
}