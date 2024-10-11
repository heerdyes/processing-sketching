void o(String msg) {
  println("[RD] "+msg);
}

void o(int x) {
  char c=(char) x;
  System.out.printf("%c", c);
}

void d(String x) {
  if (debug) {
    o(x);
  }
}

void w(String s) {
  println("[WARN] "+s);
}

boolean iskcnumeric() {
  return keyCode>=48 && keyCode<=57;
}

boolean iskcalphabetic() {
  return keyCode>=65 && keyCode<=90;
}

boolean iskcalphanumeric() {
  return iskcnumeric() || iskcalphabetic();
}

int alphanumero2int() {
  int d;
  if (iskcnumeric()) {
    d=keyCode-48;                            // intify digit keycode
  } else if (iskcalphabetic()) {
    d=10+keyCode-65;                         // intify alpha keycode
  } else {
    stat="unknown key: "+keyCode;
    d=-1;
  }
  return d;
}
