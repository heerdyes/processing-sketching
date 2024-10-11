String cfgfile=".patchman.conf";
String cfgpath;

void loadpatches() {
  File pdir=new File(patchd);
  pfs=pdir.listFiles(f -> f.isFile() && f.getName().endsWith(".csd"));
  stat="loaded patches from "+patchd;
}

void postcfg() {
  loadpatches();                    // load csd patch files
  stproc(ps_aconnect_l());          // ping "aconnect -l" to identify the kbd card
  mainstate="INIT";
}

void loadcfg() {
  String uhome=System.getProperty("user.home");
  cfgpath=uhome+"/"+cfgfile;
  File fcfg=new File(cfgpath);
  if (fcfg.exists()) {
    println("cfg exists, reading it...");
    String[] scfg=loadStrings(cfgpath);
    patchd=scfg[0];
    postcfg();
  } else {
    stat="first run. creating cfg...";
    selectFolder("choose patchbank directory", "patchbankSelected");
  }
}

void patchbankSelected(File ch) {
  if (ch==null) {
    println("manually add patchbank dir!");
    throw new RuntimeException("patchbank dir null! cannot proceed");
  }
  patchd=ch.getAbsolutePath();
  saveStrings(cfgpath, new String[]{patchd});
  postcfg();
}
