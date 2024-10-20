import netP5.*;
import oscP5.*;

OscP5 op;
NetAddress pi;
color bg=color(0);
color fg=color(0, 255, 144);
Logbox ol, kl;

void setup() {
  size(1920-6, 189, P2D);
  surface.setLocation(3, 860);
  kl=new Logbox(9, 18, fg);
  ol=new Logbox(width/2, 18, fg);
  op=new OscP5(this, 10101);
  pi=new NetAddress("127.0.0.1", 4560);
}

void draw() {
  background(0);
  kl.rndr();
  ol.rndr();
}

void keyPressed() {
  if (key!=ESC) {
    OscMessage cmd=new OscMessage("/picmd");
    cmd.add(keyCode);
    op.send(cmd, pi);
    ol.logln("/picmd "+keyCode);
    if (key=='\n') kl.logln("");
    else kl.logch(key);
  }
}
