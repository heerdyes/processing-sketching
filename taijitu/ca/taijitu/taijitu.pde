PGraphics pg;
color yang=color(23, 202, 232);
color yin=color(0, 0, 0);
int reclim=6;

void setup() {
  size(900, 900);
  pg=createGraphics(4096, 4096);
  pg.beginDraw();
  pg.background(0);
  pg.endDraw();
  rndr();
}

void taijitu(int limit, float x, float y, float r, color outln) {
  if (limit>0) {
    pg.strokeWeight(1+float(limit)*0.5);
    pg.stroke(outln);
    pg.fill(yang);
    pg.arc(x, y, r, r, -PI/2, PI/2);
    pg.fill(yin);
    pg.arc(x, y, r, r, PI/2, 3*PI/2);
    pg.fill(yin);
    pg.arc(x, y-r/4, r/2, r/2, -PI/2, PI/2);
    pg.fill(yang);
    pg.arc(x, y+r/4, r/2, r/2, PI/2, 3*PI/2);
    taijitu(limit-1, x, y-r/4, r/6, yang);
    taijitu(limit-1, x, y+r/4, r/6, yin);
  }
}

void rndr() {
  pg.beginDraw();
  taijitu(reclim, pg.width/2, pg.height/2, 4000, yang);
  pg.endDraw();
  image(pg, 0, 0, width, height);
}

void draw() {
}

void keyPressed() {
  if (key=='s') {
    pg.save(String.format("img/taijitu_%02d.jpg", reclim));
    println("saved!");
  }
}
