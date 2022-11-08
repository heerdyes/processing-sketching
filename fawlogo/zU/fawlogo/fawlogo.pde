float a1=0.5;
float a2=0.5;
float b1=1.05;
float b2=0.85;
float c1=0.5;
float c2=0.4;
float d1=0.4;
float d2=0.5;
float R=50;
int state=1;
StringBuffer sb=new StringBuffer();

void setup() {
  size(1280, 720);
  background(232);
  stroke(0);
  rectMode(CENTER);
  noFill();
}

void circle2(float x, float y, float r) {
  circle(width/2+x, height/2-y, r);
}

void line2(float x, float y, float r, float a) {
  float th=radians(a);
  float x1=width/2+x;
  float y1=height/2-y;
  float x2=x1+r*cos(th);
  float y2=y1-r*sin(th);
  line(x1, y1, x2, y2);
}

void subcircle(float x, float y, float r, int safety) {
  if (r<5) {
    return;
  }
  if (safety<=0) {
    if (sb.length()>=80) {
      println(sb.toString());
      sb.setLength(0);
    } else {
      sb.append("!");
    }
    return;
  }
  subcircle(a1*x, b1*y, c1*r, safety-1);
  circle2(x, y, r);
  subcircle(width-a2*x, width-b2*y, c2*r, safety-1);
}

void subline(float x, float y, float r, float a, int safety) {
  if (r<5) {
    return;
  }
  if (safety<=0) {
    print("!");
    return;
  }
  line2(x, y, r, a);
  subline(x*a1, y*b1, r*c1, a*d1, safety-1);
}

void draw() {
  background(232);
  subline(0, 0, R, 90, 12);
  if (state==1) {
    a1=map(mouseX, 0, width, -0.99, 0.99);
    a1=map(mouseY, 0, height, -0.99, 0.99);
  } else if (state==2) {
    b1=map(mouseX, 0, width, -0.99, 0.99);
    b2=map(mouseY, 0, height, -0.99, 0.99);
  } else if (state==3) {
    c1=map(mouseX, 0, width, -0.99, 0.99);
    c2=map(mouseY, 0, height, -0.99, 0.99);
  } else if (state==4) {
    R=map(mouseX, 0, width, 7, 500);
  }
}

void keyPressed() {
  if (key=='1') {
    state=1;
  } else if (key=='2') {
    state=2;
  } else if (key=='3') {
    state=3;
  } else if (key=='4') {
    state=4;
  }
}
