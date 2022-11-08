PGraphics c;
int ctr=0;
float step=50f;
float dx=0f, dy=300f;
T z;
ArrayList<P> q=new ArrayList<>();
boolean drawn=false;
int cw=10, ch=10, ml=48, mt=48;
CA ca=new CA(400);
CAM cam=new CAM(400);

void setup() {
  size(900, 900);
  c=createGraphics(4096, 4096);
  initstate();
  c.beginDraw();
  c.background(0);
  c.noStroke();
  z=new T(c.width/2, c.height/2, 90);
  q.add(new P(z.x+dx, z.y+dy, z.a, 1200f, 5));
  c.fill(0);
  c.endDraw();
}

void rndr(int reps) {
  c.beginDraw();
  for (int i=0; i<reps; i++) {
    art_ca00();
  }
  c.endDraw();
}

void draw() {
  if (!drawn) {
    rndr(4);
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
