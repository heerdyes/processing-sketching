Process xt;                          // process
ProcessBuilder pb;                   // management
ArrayList<String> cli;               // interface

Irdr rd, rd2;                        // out, err readers
OutputStreamWriter osw;              // conn to proc input stream
Thread t, t2;                        // streams need threads

int fs=12;                           // colors
color bg=color(0);                   // sizes and
color fg=color(0, 248, 32);          // fonts
String mf="OCRA";

String patchd;                      // patch dir
File[] pfs;                         // patch files

int collimit=108;                   // important
int rowlimit=58;                    // limits
float cgap=fs-4, rgap=fs+3;         // and
boolean debug=false;                // flags

Slist<Slist<Integer>> lns;          // the main data structure for the term buf
String mainstate="CFG";             // CFG, INIT, PERF, SWITCH
volatile String stat="READY";       // status string
int midikbdcard=-1;
float tmarginx=270, tmarginy=18;
int patchnum=-1;                    // the current csd patch

void setup() {
  size(1600, 900, P2D);
  textFont(createFont(mf, fs));
  textSize(fs);

  lns=new Slist<>(rowlimit);        // load the termbuf
  loadcfg();                        // persistent config
}

void draw() {
  background(bg);
  rndrstat();                       // this is the status line
  rndrmainstate();                  // shows app state, bottom right
  switch(mainstate) {               // multiple states <-> multiple views
  case "CFG":
    rndrcfg();
    break;
  case "INIT":
    rndrinit();
    break;
  case "PERF":
    rndrperf();
    break;
  default:
    stat="illegal state: "+mainstate;
  }
}

void inithandler() {
  if (iskcnumeric()) {
    midikbdcard=keyCode-48;                         // get the midi kbd card number
    println("midikbdcard set to "+midikbdcard);
    lns.clr();
    mainstate="PERF";                               // now csound patches can be attempted
  } else if (key=='r') {
    trigproc(ps_aconnect_l());                      // rerun "aconnect -l"
  }
}

void perfhandler() {
  patchnum=alphanumero2int();                       // convert alphanumero base to int
  if (patchnum==-1 || patchnum>=pfs.length) {       // illegal conditions handling
    stat="beyond patchbank!";
    return;
  }

  String csdnm=pfs[patchnum].getName();             // obtain csd file name
  stat="triggering csd: "+csdnm;
  trigproc(ps_csound_patch(csdnm));                 // trigger the csound patch
}

void keyPressed() {
  if (key==ESC) {                                     // app exit
    key=0;                                            // required to prevent default exit
    rmproc();                                         // kill current proc if running
    exit();
  }
  if (key=='`') {                                     // kill process without
    rmproc();                                         // closing the application
    return;
  }

  if (mainstate=="INIT") {
    inithandler();
  } else if (mainstate=="PERF") {
    perfhandler();
  } else {
    String E="unknown mainstate: "+mainstate;
    println(E);
    stat=E;
  }
}
