PGraphics c;
int ctr=0;
float r=800f, r2=1200f;
float e=1f, f=1f;
float step=10f;
T z;

void setup() {
  size(900, 900);
  c=createGraphics(4096, 4096);
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
  c.beginDraw();
  c.background(0);
  c.stroke(0, 192, 255, 128);
  z=new T(c.width/2, c.height/2, 90);
  c.noFill();
  c.endDraw();
}

void rndr(int reps) {
  c.beginDraw();
  for (int i=0; i<reps; i++) {
    art02();
  }
  c.endDraw();
}

void draw() {
  rndr(1000);
  image(c, 0, 0, width, height);
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
