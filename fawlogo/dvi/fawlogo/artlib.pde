int zstate=0;

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
  z.fd(c, step);
  int chance=int(random(100));
  if (zstate==0) {
    if (chance%5==0) {
      zstate=1;
    } else {
      z.rt(90);
      z.fd(c, step/2);
      z.lt(45);
    }
  }
  if (zstate==1) {
    if (chance%4==0 || step<1) {
      zstate=0;
      step=10f;
    } else {
      step*=0.6;
    }
  }
}
