class T {
  float x, y, a;
  int steps;
  int turns;
  float trace;
  float fatness;

  T(float xx, float yy, float aa) {
    x=xx;
    y=yy;
    a=aa;
    steps=0;
    trace=255;
    fatness=random(0.5, 2);
  }

  void fd(float r, PGraphics g_) {
    float x2=x+r*cos(radians(a));
    float y2=y-r*sin(radians(a));
    g_.stroke(trace);
    g_.strokeWeight(fatness);
    g_.line(x, y, x2, y2);
    x=x2;
    y=y2;
    trace*=0.98;
    steps++;
  }

  void bk(float r, PGraphics g_) {
    fd(-r, g_);
  }

  void lt(float aa) {
    a+=aa;
    turns++;
  }

  void rt(float aa) {
    lt(-aa);
  }

  color sense(float r, PGraphics g_) {
    float xo=x+r*cos(radians(a));
    float yo=y-r*sin(radians(a));
    return g_.get(round(xo), round(yo));
  }

  void play(PGraphics g_) {
    color envc=sense(round(fatness), g_);
    float br=brightness(envc);
    float angle;
    if (br>trace) {
      if (br>245) {
        diff.add(new T(x, y, a));
      }
      trace+=0.96*br-trace;
      angle=random(30, 75);
    } else {
      angle=random(-2, 2);
    }
    lt(angle);
    fd(1, g_);
  }
}
