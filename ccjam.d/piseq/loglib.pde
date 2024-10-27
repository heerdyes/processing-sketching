import java.util.*;

class Logbox {
  LinkedList<StringBuffer> lns;
  int limit;
  int fs=16;
  float rgap=fs+3;
  String fnt="OCRA";
  PFont pf;
  float x0, y0;
  color c;

  void clr() {
    lns.clear();
  }

  Logbox(float _x, float _y, color _c, int lim) {
    x0=_x;
    y0=_y;
    c=_c;
    limit=lim;
    initlog();
  }

  Logbox(float _x, float _y, color _c) {
    this(_x, _y, _c, 9);
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

  String getlastln() {
    return lns.size()>0?lns.get(lns.size()-1).toString():"";
  }

  String get2ndlastln() {
    return lns.size()>1?lns.get(lns.size()-2).toString():"";
  }

  char getlastch() {
    String tmp=getlastln();
    if (tmp.length()==0) return '\0';
    return tmp.charAt(tmp.length()-1);
  }

  void logch(char msg) {
    if (lns.size()>0) {
      lns.get(lns.size()-1).append(msg);
    } else {
      lns.add(new StringBuffer(""+msg));
    }
  }

  void logchs(String sms) {
    for (int i=0; i<sms.length(); i++) {
      logch(sms.charAt(i));
    }
  }

  void bksp() {
    if (lns.size()>0) {
      StringBuffer lb=lns.get(lns.size()-1);
      if (lb.length()>0) {
        lb.deleteCharAt(lb.length()-1);
      } // else do nothing
    } // else do nothing
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
