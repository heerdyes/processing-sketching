int zstate=0;
StringBuffer tm=new StringBuffer("s");
int drawlim=24;
int drawctr=0;
color[] shades=new color[]{color(255, 128, 0), color(0, 255, 64), color(0, 212, 255)};
String u_pr="[ffsbsl]";
String v_pr="[ffffsbbbbr]";
String s_pr="uv";
ArrayList<P> stk=new ArrayList<>();

void art00() {
  z.fd(c, step);
  float chance=random(1);
  if (chance<0.333) {
    z.lt(60);
  } else if (chance>0.666) {
    z.rt(60);
  } else {
    z.lt(180);
  }
}

void art01() {
  z.fd(c, step);
  float chance=random(1);
  if (chance<0.25) {
    z.lt(90);
  } else if (chance>=0.25 && chance<0.5) {
    z.rt(90);
  } else if (chance>=0.5 && chance<0.75) {
    // keep going straight
  } else {
    z.lt(180);
  }
}

void art02() {
  if (tm.length()>10000) {
    println("tm size breached 10000, clearing...");
    tm.delete(0, tm.length());
    tm.insert(0, "s");
  }
  for (int i=0; i<tm.length(); i++) {
    if (tm.charAt(i)=='f') {
      z.fd(c, step);
    } else if (tm.charAt(i)=='b') {
      z.bk(c, step);
    } else if (tm.charAt(i)=='l') {
      z.lt(30);
    } else if (tm.charAt(i)=='r') {
      z.rt(30);
    } else if (tm.charAt(i)=='s') {
      tm.delete(i, i+1);
      float ch=random(1);
      if (ch<0.333) {
        tm.insert(i, "ffls");
        i+=4-1;
      } else if (ch>=0.333 && ch<0.666) {
        tm.insert(i, "ffsr");
        i+=4-1;
      } else {
        tm.insert(i, "lsfr");
        i+=4-1;
      }
    }
  }
}

void ripple(float x, float y, color shade, int m, float w, int q) {
  int r=(shade>>16)&0xFF;
  int g=(shade>>8)&0xFF;
  int b=shade&0xFF;
  for (int k=0; k<m; k++) {
    c.stroke(r, g, b, exp(-w*k)*255);
    c.circle(x, y, (k+1)*q);
  }
}

void spiral(float x, float y, color shade, int m, float w, float q) {
  int r=(shade>>16)&0xFF;
  int g=(shade>>8)&0xFF;
  int b=shade&0xFF;
  float turn=7f;
  T t_=new T(x, y, 0);
  t_.pu();
  t_.fd(c, 10);
  t_.lt(90);
  t_.pd();
  for (int k=0; k<m; k++) {
    c.stroke(r, g, b, exp(-w*k)*255);
    t_.fd(c, 10);
    t_.lt(turn);
    turn*=q;
  }
  t_=null;
}

void art03() {
  if (drawctr<drawlim) {
    z.pu();
    for (int j=0; j<3; j++) {
      z.fd(c, r2);
      ripple(z.x, z.y, shades[j], 200, 0.125, int(map(mouseX, 0, width, 50, 150)));
      z.bk(c, r2);
      z.lt(120);
    }
    drawctr++;
  }
}

void art04() {
  if (drawctr<drawlim) {
    z.pu();
    for (int j=0; j<3; j++) {
      z.fd(c, r2);
      spiral(z.x, z.y, shades[j], 1000, 0.01, 0.997);
      z.bk(c, r2);
      z.lt(120);
    }
    drawctr++;
  }
}

void art05() {
  if (drawctr<drawlim) {
    z.pu();
    for (int j=0; j<3; j++) {
      z.fd(c, r2);
      spiral(z.x, z.y, shades[j], 1000, 0.01, 0.997);
      z.bk(c, r2);
      z.lt(120);
    }
    drawctr++;
  }
}

void art06() {
  if (drawctr>=drawlim) {
    return;
  }
  for (int i=0; i<tm.length(); i++) {
    if (tm.charAt(i)=='f') {
      z.fd(c, step);
    } else if (tm.charAt(i)=='b') {
      z.bk(c, step);
    } else if (tm.charAt(i)=='B') {
      z.bk(c, step/3);
    } else if (tm.charAt(i)=='l') {
      z.lt(120);
    } else if (tm.charAt(i)=='r') {
      z.rt(120);
    } else if (tm.charAt(i)=='[') {
      stk.add(new P(z.x, z.y, z.a));
    } else if (tm.charAt(i)==']') {
      P pz=stk.remove(stk.size()-1);
      z.x=pz.x;
      z.y=pz.y;
      z.a=pz.a;
    } else if (tm.charAt(i)=='.') {
      c.point(z.x, z.y);
    } else if (tm.charAt(i)=='s') {
      tm.delete(i, i+1);
      tm.insert(i, s_pr);
      i+=s_pr.length()-1;
    } else if (tm.charAt(i)=='u') {
      tm.delete(i, i+1);
      tm.insert(i, u_pr);
      i+=u_pr.length()-1;
    } else if (tm.charAt(i)=='v') {
      tm.delete(i, i+1);
      tm.insert(i, v_pr);
      i+=v_pr.length()-1;
    }
  }
  println("stksz = "+stk.size()+", "+stk.toString());
  drawctr++;
}
