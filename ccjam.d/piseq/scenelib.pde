class Scene {
  ArrayList<String> lns;

  Scene(String... s) {
    lns=new ArrayList<>();
    for (String tmp : s) {
      lns.add(tmp);
    }
  }
}

void initscenes() {
  scenes[0]=new Scene(
    "0 sy mod_beep", // kick
    "0 a 0",
    "0 d 0",
    "0 s 0",
    "0 r 2",
    "0 q z...",
    "1 sy dtri", // bass
    "1 o 48",
    "1 a 0",
    "1 d 0",
    "1 s 0",
    "1 r 3",
    "1 dt 1",
    "1 q Z..Z....j..j....h..h....b..b....",
    "2 sy dsaw", // arp
    "2 a 0",
    "2 d 0",
    "2 s 0",
    "2 r 2",
    "2 q zvb",
    "2 v cccdddeeeddd",
    "2 co h",
    "3 sy dsaw",
    "3 dt r",
    "3 co j",
    "3 a d",
    "3 d 0",
    "3 s 0",
    "3 r 1",
    "3 v b",
    "3 q z.......x.......d.......v......."
    );
  scenes[1]=new Scene(
    "0 sy mod_sine", // kick
    "0 o 50",
    "0 a 0",
    "0 d 0",
    "0 s 0",
    "0 r 4",
    "0 mw 0",
    "0 mr c",
    "0 mp 6",
    "0 q b...b..v.b......",
    "1 sy cnoise", // hats
    "1 a 000011",
    "1 d 0",
    "1 s 0",
    "1 r 123",
    "1 q ..c..c..",
    "1 co fffkkktttmmm",
    "2 sy dpulse", // melody
    "2 a 0",
    "2 d 0",
    "2 s 0",
    "2 r 2",
    "2 co ppjjdd",
    "2 q h..h..b..d...."
    );
  scenes[2]=new Scene(
    "0 sy mod_sine",
    "0 o 50",
    "0 a 0",
    "0 d 0",
    "0 s 0",
    "0 r 4",
    "0 mw 0",
    "0 mr c",
    "0 mp 7",
    "1 sy mod_dsaw",
    "1 a 2",
    "1 r 2",
    "1 mw 2",
    "1 mr 2",
    "1 mp 6",
    "1 dt 5",
    "0 q z...z...z...zz..",
    "1 q z.v.b..m...."
    );
  scenes[3]=new Scene("0 sy mod_sine");
  scenes[4]=new Scene("0 sy mod_sine");
  scenes[5]=new Scene("0 sy mod_sine");
  scenes[6]=new Scene("0 sy mod_sine");
  scenes[7]=new Scene("0 sy mod_sine");
  scenes[8]=new Scene("0 sy mod_sine");
  scenes[9]=new Scene("0 sy mod_sine");
  scenes[10]=new Scene("0 sy mod_sine");
  // last scene is a reset scene
  String[] autoinst=new String[10*5];
  int cmdi=0;
  for (int i=0; i<10; i++) {
    String sq=String.format("%d q ....", i);
    String a=String.format("%d a 0", i);
    String d=String.format("%d d 0", i);
    String s=String.format("%d s 0", i);
    String r=String.format("%d r 1", i);
    autoinst[cmdi++]=sq;
    autoinst[cmdi++]=a;
    autoinst[cmdi++]=d;
    autoinst[cmdi++]=s;
    autoinst[cmdi++]=r;
  }
  scenes[11]=new Scene(autoinst);
}

void enterscene(int sn) {
  if (sn<0 || sn>=scenes.length) {
    kl.logln("[ALAS] sn<0 or sn>=scenes.length");
  }
  for (String tmp : scenes[sn].lns) {
    kl.logchs(tmp);
    sendsq();
  }
}
