class Particle {
  PVector pos;
  ArrayList<Ray> rays = new ArrayList<Ray>();
  float rayFidelity = 1.0f;
  float minEase = 2000f;
  float easeAmount = 50000f;
  
  Particle() {
    pos = new PVector(width/2, height/2);
    for (float i = 0; i < 360; i+= rayFidelity) {
      rays.add(new Ray(pos, radians(i)));
    }
  }

  void look(ArrayList<Boundary> walls) {
    for (Ray r : rays) {
      PVector closest = null;
      float record = 9999999f;
      for (Boundary wall : walls) {

        PVector pt = r.cast(wall);
        if (pt != null) {
          float dist = PVector.dist(this.pos, pt);
          if (dist < record) {
            record = dist;
            closest = pt;
          }
        }
      }
      if (closest != null) {
        line(this.pos.x, this.pos.y, closest.x, closest.y);
      }
    }
  }

  void update(float x, float y, boolean ease) {
    if(!ease){
      this.pos.set(x, y);
    } else {
      float dist = PVector.dist(this.pos, new PVector(x, y));
      if(dist < minEase) dist = minEase;
      PVector dir = PVector.sub(new PVector(x, y), this.pos);
      PVector eAmnt = PVector.mult(dir, dist / easeAmount);
      this.pos.add(eAmnt);
    }
  }

  void show() {
    fill(255);
    ellipse(this.pos.x, this.pos.y, 4, 4);
    for (Ray r : rays) {
      r.show();
    }
  }
}
