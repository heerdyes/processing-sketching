color bg=color(240);
ArrayList<Linkling> linklings;
float lnklen=15f;

void spawnlinklings() {
  linklings=new ArrayList<>();
  linklings.add(new Linkling(width/2, height/2, 15, 10, 1, 0.5));
}

void setup() {
  size(1280, 720);
  background(bg);
  stroke(0);
  strokeWeight(1.5);
  spawnlinklings();
}

void infobox(Linkling m, int ln) {
  fill(0);
  text(String.format("[%03.3f, %03.3f]", m.v.x, m.v.y), 5, 15+ln*13);
}

void draw() {
  background(bg);
  for (int i=0; i<linklings.size(); i++) {
    Linkling ll=linklings.get(i);
    ll.exist();
    infobox(ll, i);
  }
}

void keyPressed() {
  if (key=='a') {
    float xx=random(0, width-1);
    float yy=random(0, height-1);
    float llen=random(4, 45);
    int nl=int(random(3, 30));
    float radius=random(1, 5);
    float kclk=random(0.5, 5.0);
    linklings.add(new Linkling(xx, yy, llen, nl, radius, kclk));
  } else if (key=='x') {
    if (linklings.size()>0) {
      linklings.remove(0);
    }
  }
}
