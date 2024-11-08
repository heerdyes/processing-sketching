import netP5.*;
import oscP5.*;

OscP5 op;
NetAddress pi;
color bg=color(0);
color fg=color(0, 255, 144);
Logbox ol, kl;
int srvport=10101;
String AB="`0123456789abcdefghijklmnopqrstuvwxyz-=\\[];',./ ABCDEFGHIJKLMNOPQRSTUVWXYZ~)!@#$%^&*(_+|{}:\"<>?";
volatile boolean ctldn=false;

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

void keyReleased() {
  if (ctldn) {
    if (keyCode==com.jogamp.newt.event.KeyEvent.VK_CONTROL) {
      ctldn=false;
    }
  }
}

void keyPressed() {
  if (!ctldn) {
    if (keyCode==com.jogamp.newt.event.KeyEvent.VK_CONTROL) {
      ctldn=true;
      return;
    }
  }
  if (key==ESC) {
    key=0;
    println("bye!");
    exit();
    return;
  }
  // hotkeys
  if (ctldn) {
    if (keyCode==com.jogamp.newt.event.KeyEvent.VK_BACK_SPACE) {
      kl.clr();   // ctrl + backspace
      ol.clr();   // to clear screen
      return;
    }
  }
  // normal keys
  if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F10) {
    kl.clr();
    ol.clr();
  } else if (key=='\n') {
    kl.logln("");
  } else if (AB.indexOf(key)!=-1) {
    OscMessage cmd=new OscMessage("/picue");
    cmd.add(keyCode);
    op.send(cmd, pi);
    ol.logln("/picue "+keyCode);
    kl.logch(key);
  } else {
    println("not reacting to keycode: "+keyCode);
  }
}
