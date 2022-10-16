PGraphics pg;
color yang=color(255, 128, 0);
color yin=color(0, 0, 0);
int reclim=4;
float t=0.0;

void setup() {
  size(900, 900);
  imageMode(CENTER);
  pg=createGraphics(1024, 1024);
  pg.beginDraw();
  pg.background(0);
  pg.endDraw();
  rndr();
}

void taijitu(int limit, float x, float y, float r, color outln) {
  if (limit>0) {
    pg.strokeWeight(0.5+float(limit)*0.5);
    pg.stroke(outln);
    pg.fill(yang);
    pg.arc(x, y, r, r, -PI/2+t, PI/2+t);
    pg.fill(yin);
    pg.arc(x, y, r, r, PI/2+t, 3*PI/2+t);
    pg.fill(yin);
    pg.arc(x, y-r/4, r/2, r/2, -PI/2+t, PI/2+t);
    pg.fill(yang);
    pg.arc(x, y+r/4, r/2, r/2, PI/2+t, 3*PI/2+t);
    taijitu(limit-1, x, y-r/4, r/6, yang);
    taijitu(limit-1, x, y+r/4, r/6, yin);
  }
}

void rndr() {
  pg.beginDraw();
  taijitu(reclim, pg.width/2, pg.height/2, 1000, yang);
  pg.endDraw();
  translate(width/2, height/2);
  image(pg, 0, 0, width, height);
}

void draw() {
  translate(width/2, height/2);
  rotate(t);
  image(pg, 0, 0, width, height);
  t+=PI/180;
}

void keyPressed() {
  if (key=='s') {
    pg.save(String.format("img/taijitu_%02d_%04d%02d%02d-%02d%02d%02d.jpg", reclim, year(), month(), day(), hour(), minute(), second()));
    println("saved!");
  }
}
