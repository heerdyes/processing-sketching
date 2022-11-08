void initstate() {
  File sf=new File(sketchPath()+File.separator+"state");
  if (sf.exists()) {
    println("loading count from state file...");
    String[] state=loadStrings("state");
    ctr=int(state[0]);
    println("resuming ctr from: "+ctr);
  } else {
    println("creating state file...");
    saveStrings("state", new String[]{"0"});
  }
}

class P {
  float x, y, a;

  P(float xx, float yy, float aa) {
    x=xx;
    y=yy;
    a=aa;
  }
}

class T {
  float x, y, a;
  boolean pendown;

  T(float xx, float yy, float aa) {
    x=xx;
    y=yy;
    a=aa;
    pendown=true;
  }

  void pu() {
    pendown=false;
  }

  void pd() {
    pendown=true;
  }

  void toxy(PGraphics pg, float x2, float y2) {
    if (pendown) {
      pg.line(x, y, x2, y2);
    }
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
