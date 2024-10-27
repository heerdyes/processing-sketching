import netP5.*;
import oscP5.*;

OscP5 op;
NetAddress pi;
color bg=color(0);
color fg=color(0, 255, 144);
Logbox ol, kl;
StringBuffer lnbuf=new StringBuffer();
String AB="`0123456789abcdefghijklmnopqrstuvwxyz-=\\[];',./ ABCDEFGHIJKLMNOPQRSTUVWXYZ~)!@#$%^&*(_+|{}:\"<>?";
int srvport=10201;
int lnlim=35;
volatile boolean ctldn=false;
Scene[] scenes=new Scene[12];

void setup() {
  size(1350, 693, P2D);
  surface.setLocation(0, 63);

  initscenes();

  kl=new Logbox(9, 18, fg, lnlim);
  ol=new Logbox(0.75*width, 18, fg, lnlim);

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
  println(keyCode);
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
    int ntimes=dcode09az(keyCode);
    if (ntimes!=-1) {
      char tc=kl.getlastch();
      if (tc!='\0') {
        for (int i=0; i<ntimes; i++) {
          kl.logch(tc);
        }
      }
    }
    return;
  }
  // normal keys
  if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F1) {
    enterscene(0);
  } else if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F2) {
    enterscene(1);
  } else if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F3) {
    enterscene(2);
  } else if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F4) {
    enterscene(3);
  } else if (keyCode==com.jogamp.newt.event.KeyEvent.VK_F5) {
    enterscene(4);
  } else if (keyCode==com.jogamp.newt.event.KeyEvent.VK_BACK_SPACE) {
    kl.bksp();
  } else if (keyCode==38) {
    kl.logchs(kl.get2ndlastln());
  } else if (AB.indexOf(key)!=-1) {
    kl.logch(key);
  } else if (key=='\n') {
    sendsq();
  }
}
