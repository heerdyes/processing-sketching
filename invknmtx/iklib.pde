class Link {
  PVector a;      // source point
  float th;       // angle theta
  float r;        // the radius
  PVector b;      // the end point
  color c;
  float dia;
  Link parent;    // robotic linked lists!

  Link(float x, float y, float r, float th, float d) {
    a=new PVector(x, y);
    b=new PVector(0, 0);    // temporarily
    c=color(0, 0, 32);      // some dark shade of blue
    dia=d;                  // the thickness
    this.r=r;
    this.th=th;
    computeB();             // b is always computed
  }

  Link(Link base, float r, float th, float d) {
    this(base.b.x, base.b.y, r, th, d);
    parent=base;
  }

  void computeB() {
    float bx=a.x+r*cos(th);
    float by=a.y+r*sin(th);
    b.set(bx, by);
  }

  void update() {
    computeB();
  }

  void follow(float tx, float ty) {
    PVector target=new PVector(tx, ty);
    PVector dir=PVector.sub(target, a);
    th=dir.heading();
    dir.setMag(r);
    dir.mult(-1);
    a=PVector.add(target, dir);
  }

  void render() {
    stroke(c);
    strokeWeight(dia);
    line(a.x, a.y, b.x, b.y);
  }

  void exist(float zx, float zy) {
    follow(zx, zy);
    update();
    render();
    if (parent!=null) {
      parent.exist(a.x, a.y);
    }
  }
}

class Linkling {
  Link head, tail;
  PVector v;
  float r;
  float clkcoeff;

  Linkling(float x, float y, float lnklen, int nlinks, float r, float cc) {
    this.r=r;
    this.clkcoeff=cc;
    v=new PVector(0, 0);
    float rndth=radians(random(0, 360));
    float initdia=1.0;
    head=new Link(x, y, lnklen, rndth, initdia);
    Link curr=head;
    for (int i=0; i<nlinks; i++) {
      tail=new Link(curr, lnklen, 0, initdia+i*0.15);
      curr=tail;
    }
  }

  void update() {
    float thx=radians(frameCount*clkcoeff*map(mouseX, 0, width, 0, 1));
    float thy=radians(frameCount*clkcoeff*map(mouseY, 0, height, 0, 1));
    v.set(r*(cos(thx)), r*(sin(thy)));
  }

  void exist() {
    update();
    tail.exist(tail.b.x+v.x, tail.b.y+v.y);
  }
}
