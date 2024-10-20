import java.util.*;

class Logbox {
  LinkedList<StringBuffer> lns;
  int limit=9;
  int fs=16;
  float rgap=fs+3;
  String fnt="OCRA";
  PFont pf;
  float x0, y0;
  color c;

  Logbox(float _x, float _y, color _c) {
    x0=_x;
    y0=_y;
    c=_c;
    initlog();
  }

  void initlog() {
    lns=new LinkedList<>();
    pf=createFont(fnt, fs);
  }

  void logln(String msg) {
    lns.add(new StringBuffer(msg));
    while (lns.size()>limit) {
      lns.remove(0);
    }
  }

  void logch(char msg) {
    if (lns.size()>0) {
      lns.get(lns.size()-1).append(msg);
    } else {
      lns.add(new StringBuffer(""+msg));
    }
  }

  void rndr() {
    float xx=x0, yy=y0;
    noStroke();
    fill(c);
    textFont(pf);
    textSize(fs);
    for (StringBuffer ln : lns) {
      text(ln.toString(), xx, yy);
      yy+=rgap;
    }
  }
}
