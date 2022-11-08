PGraphics c;
int ctr=0;
float r=1600f;
float e=10f, f=20f, g=17f, h=19f;

void setup() {
  size(800, 800);
  c=createGraphics(4096, 4096);
  File sf=new File("state");
  if (sf.exists()) {
    String[] state=loadStrings("state");
    ctr=int(state[0]);
  } else {
    saveStrings("state", new String[]{"0"});
  }
  c.beginDraw();
  c.background(0);
  c.stroke(0, 255, 128);
  c.endDraw();
}

void rndr() {
  c.beginDraw();
  float x1=c.width/2;
  float y1=c.height/2;
  float x2=x1+r*cos(radians(90+frameCount*e));
  float y2=y1-r*sin(radians(90+frameCount*f));
  float x3=x1-r*cos(radians(90+frameCount*g));
  float y3=y1+r*sin(radians(90+frameCount*h));
  c.line(x1, y1, x2, y2);
  c.line(x1, y1, x3, y3);
  c.endDraw();
}

void draw() {
  rndr();
  image(c, 0, 0, width, height);
}

void keyPressed() {
  if (key=='s') {
    println("saving image...");
    c.save(String.format("img/im-%02d.jpg", ctr++));
    saveStrings("state", new String[]{""+ctr});
  }
}
