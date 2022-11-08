class CA {
  char[] prv;
  char[] cur;
  char[] nxt;

  CA(int n) {
    prv=new char[n];
    cur=new char[n];
    nxt=new char[n];
    for (int i=0; i<n; i++) {
      prv[i]='0';
      cur[i]='0';
      nxt[i]='0';
    }
    cur[n/2]=prv[n/2]='1';
  }

  void rndr(PGraphics d, int ln) {
    for (int i=0; i<cur.length; i++) {
      if (cur[i]=='1') {
        d.fill(0, 200, 255);
      } else {
        d.fill(0);
      }
      d.rect(i*200, 50+ln*100, 100, 100);
    }
  }

  void evolve() {
    for (int i=1; i<nxt.length-1; i++) {
      String past=String.format("%c%c%c", prv[i-1], prv[i], prv[i+1]);
      String rule=String.format("%c%c%c", cur[i-1], cur[i], cur[i+1]);
      if (past.equals("000")) {
        if (rule.equals("001")) {
          nxt[i]='1';
        } else if (rule.equals("010")) {
          nxt[i]='0';
        } else if (rule.equals("100")) {
          nxt[i]='1';
        } else {
          nxt[i]=cur[i];
        }
      } else if (past.equals("111")) {
        if (rule.equals("000")) {
          nxt[i]='1';
        } else if (rule.equals("101")) {
          nxt[i]='1';
        } else {
          nxt[i]=cur[i];
        }
      } else if (past.equals("100")) {
        if (rule.equals("001")) {
          nxt[i]='1';
        } else if (rule.equals("100")) {
          nxt[i]='1';
        } else {
          nxt[i]=cur[i];
        }
      } else {
        nxt[i]=cur[i];
      }
    }
    for (int i=0; i<cur.length; i++) {
      prv[i]=cur[i];
      cur[i]=nxt[i];
    }
  }
}

class CAM {
  ArrayList<String> calog;
  int limit;

  CAM(int lim) {
    calog=new ArrayList<>();
    limit=lim;
  }

  void nq(char[] x) {
    if (calog.size()>limit) {
      dq();
    }
    calog.add(new String(x));
  }

  void dq() {
    calog.remove(0);
  }

  void rndr(PGraphics d) {
    for (int t=0; t<calog.size(); t++) {
      String cagen=calog.get(t);
      for (int j=0; j<cagen.length(); j++) {
        if (cagen.charAt(j)=='1') {
          d.fill(0, 200, 255);
        } else {
          d.fill(0);
        }
        d.rect(ml+j*cw, mt+t*ch, cw, ch);
      }
    }
  }
}

void art_ca00() {
  cam.rndr(c);
  ca.evolve();
  cam.nq(ca.cur);
}
