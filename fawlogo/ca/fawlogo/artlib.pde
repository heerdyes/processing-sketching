void art00() {
  if (!q.isEmpty()) {
    P pz=q.remove(0);
    if (pz.s>2 && pz.th>1) {
      c.strokeWeight(pz.th);
      z.setp(pz);
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*0.333, pz.th*0.75));
      z.bk(c, pz.s);
      z.lt(120);
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*0.333, pz.th*0.75));
      z.bk(c, pz.s);
      z.lt(120);
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*0.333, pz.th*0.75));
      z.bk(c, pz.s);
      z.lt(120);
    }
  }
}

void art_tri() {
  if (!q.isEmpty()) {
    P pz=q.remove(0);
    if (pz.s>2 && pz.th>1) {
      c.strokeWeight(pz.th);
      float k=0.45;
      z.setp(pz);
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.bk(c, pz.s);
      z.lt(120);
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.bk(c, pz.s);
      z.lt(120);
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.bk(c, pz.s);
      z.lt(120);
    }
  }
}

void art_A() {
  if (!q.isEmpty()) {
    P pz=q.remove(0);
    if (pz.s>2 && pz.th>1) {
      c.strokeWeight(pz.th);
      float k=0.46;
      z.setp(pz);
      z.fd(c, 2*pz.s/3);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.bk(c, pz.s);
      z.lt(90);
      z.fd(c, 2*pz.s/3);
      z.rt(90);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.rt(90);
      z.fd(c, 4*pz.s/3);
      z.lt(90);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.lt(90);
      z.fd(c, 2*pz.s/3);
      z.rt(90);
    }
  }
}

void art_f() {
  if (!q.isEmpty()) {
    P pz=q.remove(0);
    if (pz.s>2 && pz.th>1) {
      c.strokeWeight(pz.th);
      float k=0.42, ae=84f;
      z.setp(pz);
      z.fd(c, pz.s);
      z.rt(ae);
      z.fd(c, pz.s/3);
      z.lt(ae);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.rt(ae);
      z.bk(c, pz.s/3);
      z.lt(ae);
      z.bk(c, pz.s*2);
      z.rt(ae);
      z.bk(c, pz.s/3);
      z.lt(ae);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.rt(ae);
      z.fd(c, pz.s/3);
      z.lt(ae);
      z.fd(c, pz.s);
      z.rt(ae);
      z.fd(c, pz.s/4);
      z.bk(c, 2*pz.s/4);
      z.fd(c, pz.s/4);
      z.lt(ae);
    }
  }
}

void art_diff() {
  float fx=10f;
  for (int i=0; i<360; i++) {
    c.stroke(0, 200, 255, 127+126*sin(radians(i*24)));
    c.circle(z.x-fx, z.y, 50+40*i);
    c.circle(z.x+fx, z.y, 50+40*i);
  }
  drawn=true;
}

void art_w() {
  if (!q.isEmpty()) {
    P pz=q.remove(0);
    if (pz.s>2 && pz.th>1) {
      c.strokeWeight(pz.th);
      float k=0.333;
      z.setp(pz);
      z.lt(120);
      z.fd(c, pz.s);
      z.rt(120);
      //q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.bk(c, pz.s);
      z.rt(60);
      z.fd(c, pz.s);
      z.rt(60);
      z.fd(c, pz.s);
      z.lt(120);
      //q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.fd(c, pz.s);
      q.add(new P(z.x, z.y, z.a, pz.s*k, pz.th));
      z.bk(c, pz.s);
      z.lt(60);
      z.fd(c, pz.s);
      z.rt(60);
    }
  }
}
