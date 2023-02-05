ArrayList<T> ts, diff;
PGraphics pg;
boolean inkg=false, inkw=false;
boolean shooting=false;

void mktsys(PGraphics g_) {
  ts=new ArrayList<>();
  float cx=g_.width/2;
  float cy=g_.height/2;
  float cr=50f;
  int lim=100;
  for (int i=0; i<lim; i++) {
    float ai=i*360.0/lim;
    ts.add(new T(cx+cr*cos(radians(ai)), cy-cr*sin(radians(ai)), ai));
  }
  diff=new ArrayList<>();
}

void setup() {
  size(900, 900);
  pg=createGraphics(1080, 1080);
  pg.beginDraw();
  pg.background(0);
  pg.stroke(255);
  pg.noFill();
  pg.circle(pg.width/2, pg.height/2, 300);
  pg.circle(pg.width/2, pg.height/2, 600);
  pg.circle(pg.width/2, pg.height/2, 900);
  pg.endDraw();
  mktsys(pg);
}

void draw() {
  pg.beginDraw();
  for (T t : ts) {
    t.play(pg);
  }
  if (inkw) {
    pg.noStroke();
    pg.fill(255);
    pg.circle(mouseX, mouseY, 10);
  }
  if (inkg) {
    pg.noStroke();
    pg.fill(128);
    pg.circle(mouseX, mouseY, 10);
  }
  pg.endDraw();
  for (T f : diff) {
    ts.add(f);
  }
  diff.clear();
  image(pg, 0, 0, width, height);
  if (shooting) {
    save(String.format("img/i_%05d.jpg", frameCount));
  }
}

void keyPressed() {
  if (key=='g') {
    inkg=!inkg;
  } else if (key=='w') {
    inkw=!inkw;
  }
}
