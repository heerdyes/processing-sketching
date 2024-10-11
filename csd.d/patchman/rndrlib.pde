color ltylo=color(252, 225, 0);
color ltgry=color(180);

void rndrlns(float x0, float y0, float cgap, float rgap) {
  float xx=x0, yy=y0;
  int tabwid=4;
  noStroke();
  fill(fg);
  for (Snode i=lns.head; i!=null; i=i.nxt) {
    Slist x=(Slist) i.d;
    for (Snode j=x.head; j!=null; j=j.nxt) {
      char c=(char)(int)j.d;        // ascii rendering
      int jd=(int)j.d;
      if (jd==0x0a) {               // 0x0a: LF := unix mode enter key
        xx=x0;
        yy+=rgap;                   // row advance
      } else if (jd==0x09) {        // 0x09: HT := horizontal tab
        xx+=cgap*tabwid;            // change tabwid for indent settings
      } else {
        text(c, xx, yy);
        xx+=cgap;                   // col advance
      }
    }
    yy+=rgap;
    xx=x0;
  }
}

void rndrinit() {
  rndrlns(tmarginx, tmarginy, cgap, rgap);
  stat="press midikbd card number [0-9]: ";
}

void rndrpatchmenu(float x0, float y0) {
  int i=0;
  noStroke();
  float xx=x0, yy=y0;
  for (File pf : pfs) {
    if (i==patchnum) {
      fill(ltylo);
    } else {
      fill(ltgry);
    }
    char idx=(char) ((i>=0&&i<=9)?48+i:97-10+i);
    text(String.format("[%c] %s", idx, pf.getName()), xx, yy);
    yy+=fs+5;
    i++;
  }
}

void rndrperf() {
  rndrpatchmenu(9, 18);
  rndrlns(tmarginx, tmarginy, cgap, rgap);
  stat="<P:"+patchnum+"> press patch index to activate [0-z] ...";
}

void rndrstat() {
  noStroke();
  fill(0, 248, 90);
  text("[STATUS] "+stat, 20, height-10);
}

void rndrmainstate() {
  noStroke();
  fill(0, 248, 0);
  text("["+mainstate+"]", width-180, height-10);
}

void rndrcfg() {
  stat="loading configuration...";
}
