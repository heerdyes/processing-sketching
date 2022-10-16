String[] proglns;
String selfile=null;
String state="START";
Penloc pl=new Penloc(5, 5);

void setup() {
  size(1280, 720);
  background(255);
  stroke(0, 0, 96);
  strokeWeight(1.5);
  textAlign(CENTER, CENTER);
  textSize(22);
  fill(0, 0, 96);
  String[] bootcfg=loadStrings("boot");
  selfile=bootcfg[0];
  state="READY";
}

void procschematic() {
  for (String ln : proglns) {
    String tln=ln.trim();
    if (tln.length()==0)continue;
    String[] cmdln=tln.split(" ");
    if (cmdln[0].equals("mat")) {
      if (cmdln.length!=6) {
        throw new RuntimeException("illegal mat cmd!");
      }
      float mx=Float.parseFloat(cmdln[1]);
      float my=Float.parseFloat(cmdln[2]);
      float mw=Float.parseFloat(cmdln[3]);
      float mh=Float.parseFloat(cmdln[4]);
      mat(mx, my, mw, mh, cmdln[5]);
    } else if (cmdln[0].equals("txtring")) {
      if (cmdln.length!=5) {
        throw new RuntimeException("illegal txtring cmd!");
      }
      float rx=Float.parseFloat(cmdln[1]);
      float ry=Float.parseFloat(cmdln[2]);
      float rr=Float.parseFloat(cmdln[3]);
      txtring(rx, ry, rr, cmdln[4]);
    } else if (cmdln[0].equals("arrow")) {
      if (cmdln.length!=5) {
        throw new RuntimeException("illegal arrow cmd!");
      }
      float x1=Float.parseFloat(cmdln[1]);
      float y1=Float.parseFloat(cmdln[2]);
      float x2=Float.parseFloat(cmdln[3]);
      float y2=Float.parseFloat(cmdln[4]);
      arrow(x1, y1, x2, y2);
    } else if (cmdln[0].equals("txtbox")) {
      if (cmdln.length!=6) {
        throw new RuntimeException("illegal txtbox cmd!");
      }
      float mx=Float.parseFloat(cmdln[1]);
      float my=Float.parseFloat(cmdln[2]);
      float mw=Float.parseFloat(cmdln[3]);
      float mh=Float.parseFloat(cmdln[4]);
      txtbox(mx, my, mw, mh, cmdln[5]);
    } else if (cmdln[0].equals("ln")) {
      if (cmdln.length!=5) {
        throw new RuntimeException("illegal ln cmd!");
      }
      float x1=Float.parseFloat(cmdln[1]);
      float y1=Float.parseFloat(cmdln[2]);
      float lr=Float.parseFloat(cmdln[3]);
      float th=Float.parseFloat(cmdln[4]);
      float a=radians(th);
      line(x1, y1, x1+lr*cos(a), y1-lr*sin(a));
    } else if (cmdln[0].equals("write")) {
      if (cmdln.length!=4) {
        throw new RuntimeException("illegal write cmd!");
      }
      int x=int(cmdln[1]);
      int y=int(cmdln[2]);
      text(cmdln[3].replaceAll("_", " "), x, y);
    } else if (cmdln[0].equals("penloc")) {
      if (cmdln.length!=3) {
        throw new RuntimeException("illegal penloc cmd!");
      }
      pl.x=int(cmdln[1]);
      pl.y=int(cmdln[2]);
    } else if (cmdln[0].equals("box")) {
      if (cmdln.length!=5) {
        throw new RuntimeException("illegal box cmd!");
      }
      float mx=Float.parseFloat(cmdln[1]);
      float my=Float.parseFloat(cmdln[2]);
      float mw=Float.parseFloat(cmdln[3]);
      float mh=Float.parseFloat(cmdln[4]);
      noFill();
      rect(mx-mw/2, my-mh/2, mw, mh);
      fill(0, 0, 96);
    }
  }
}

void txtbox(float x, float y, float w, float h, String txt) {
  noFill();
  rect(x-w/2, y-h/2, w, h);
  fill(0, 0, 64);
  text(txt, x, y);
}

void arrow(float x1, float y1, float r, float th) {
  float ath=radians(th);
  float x2=x1+r*cos(ath);
  float y2=y1-r*sin(ath);
  line(x1, y1, x2, y2);
  float revth=PI+ath;
  float rtip=15f;
  float ddeg=18f;
  float delta=radians(ddeg);
  line(x2, y2, x2+rtip*cos(revth-delta), y2-rtip*sin(revth-delta));
  line(x2, y2, x2+rtip*cos(revth+delta), y2-rtip*sin(revth+delta));
}

void mat(float x, float y, float w, float h, String colvec) {
  line(x-w/2, y-h/2, x-w/2, y+h/2);
  line(x-w/2, y-h/2, x-w/2+0.2*w, y-h/2);
  line(x-w/2, y+h/2, x-w/2+0.2*w, y+h/2);
  line(x+w/2, y-h/2, x+w/2, y+h/2);
  line(x+w/2-0.2*w, y-h/2, x+w/2, y-h/2);
  line(x+w/2-0.2*w, y+h/2, x+w/2, y+h/2);
  String[] cv=colvec.split(",");
  text(cv[0], x, y-h/4);
  text(cv[1], x, y+h/4);
}

void txtring(float x, float y, float r, String txt) {
  noFill();
  circle(x, y, r);
  fill(0, 0, 96);
  text(txt, x, y);
}

void draw() {
  if (state.equals("READY")) {
    proglns=loadStrings(selfile);
    procschematic();
    state="DONE";
  }
}

void mouseClicked() {
  save("tmp.jpg");
}
