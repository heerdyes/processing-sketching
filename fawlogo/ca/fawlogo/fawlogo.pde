PGraphics c;
int ctr=0;
float step=50f;
float dx=0f, dy=300f;
T z;
ArrayList<P> q=new ArrayList<>();
boolean drawn=false;

void setup() {
  size(900, 900);
  c=createGraphics(4096, 4096);
  initstate();
  c.beginDraw();
  c.background(0);
  c.stroke(0, 192, 255, 255);
  z=new T(c.width/2, c.height/2, 90);
  q.add(new P(z.x+dx, z.y+dy, z.a, 1200f, 5));
  c.noFill();
  c.endDraw();
}

void rndr(int reps) {
  c.beginDraw();
  for (int i=0; i<reps; i++) {
    art_A();
  }
  c.endDraw();
}

void draw() {
  if (!drawn) {
    rndr(100);
    image(c, 0, 0, width, height);
  }
}

void keyPressed() {
  if (key=='s') {
    println("saving images...");
    c.save(String.format("img/c_im-%02d.jpg", ctr));
    save(String.format("img/im-%02d.jpg", ctr));
    ctr++;
    println("persisting ctr...");
    saveStrings("state", new String[]{""+ctr});
  }
  if (key=='0') {
    z.reset(c);
  }
}
