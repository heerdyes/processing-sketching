class T {
  float x, y, a;

  T(float xx, float yy, float aa) {
    x=xx;
    y=yy;
    a=aa;
  }

  void toxy(PGraphics pg, float x2, float y2) {
    pg.line(x, y, x2, y2);
  }

  void fd(PGraphics pg, float r) {
    float x2=x+r*cos(radians(a));
    float y2=y-r*sin(radians(a));
    toxy(pg, x2, y2);
    x=x2;
    y=y2;
  }

  void bk(PGraphics pg, float r) {
    fd(pg, -r);
  }

  void lt(float theta) {
    a+=theta;
  }

  void rt(float theta) {
    a-=theta;
  }

  void reset(PGraphics pg) {
    x=pg.width/2;
    y=pg.height/2;
    a=0;
  }
}
