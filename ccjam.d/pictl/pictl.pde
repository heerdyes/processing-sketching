import netP5.*;
import oscP5.*;

OscP5 op;
NetAddress pi;
color bg=color(0);
color fg=color(0, 255, 144);
Logbox ol, kl;
int srvport=10101;

void setup() {
  size(1920, 189, P2D);
  surface.setLocation(0, 860);
  kl=new Logbox(9, 18, fg);
  ol=new Logbox(0.75*width, 18, fg);
  op=new OscP5(this, srvport);
  pi=new NetAddress("127.0.0.1", 4560);
}

void draw() {
  background(0);
  kl.rndr();
  ol.rndr();
}

void keyPressed() {
  if (key==ESC) {
    key=0;
    println("bye!");
    exit();
    return;
  }
  if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F10) {
    kl.clr();
    ol.clr();
  } else {
    OscMessage cmd=new OscMessage("/picue");
    cmd.add(keyCode);
    op.send(cmd, pi);
    ol.logln("/picue "+keyCode);
    if (key=='\n') kl.logln("");
    else kl.logch(key);
  }
}
