void sendsq() {
  String cli=kl.getlastln();
  String[] ca=cli.split(" ");

  if (ca.length==3) {
    OscMessage cmd=new OscMessage("/piseq");
    cmd.add(int(ca[0]));
    cmd.add(ca[1]);
    cmd.add(ca[2]);
    op.send(cmd, pi);
    ol.logln(".");
  } else {
    ol.logln("nargs is "+ca.length+", instead of 3");
  }

  kl.logln("");
}

int dcode09az(int kc) {
  if (kc>=48&&kc<=57) {
    return kc-48;
  }
  if (kc>=65&&kc<=90) {
    return 10+kc-65;
  }
  return -1;
}
