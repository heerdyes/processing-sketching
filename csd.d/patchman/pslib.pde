ArrayList<String> ps_csound_patch(String csdnm) {
  ArrayList<String> pcli=new ArrayList<>();
  pcli=new ArrayList<>();
  pcli.add("csound");
  pcli.add("-Mhw:"+midikbdcard+",0");
  pcli.add("-odac");
  pcli.add("-m128");
  pcli.add(patchd+"/"+csdnm);
  return pcli;
}

ArrayList<String> ps_aconnect_l() {
  ArrayList<String> pscli=new ArrayList<>();
  pscli.add("aconnect");
  pscli.add("-l");
  return pscli;
}

void stproc(ArrayList<String> cmdln) {
  pb=new ProcessBuilder(cmdln);
  lns.clr();
  lns.setlimit(rowlimit);
  stat="starting process: "+cmdln.get(0);
  try {
    xt=pb.start();
    t=new Thread(rd=new Irdr(xt.getInputStream(), lns));
    t2=new Thread(rd2=new Irdr(xt.getErrorStream(), lns));
    osw=new OutputStreamWriter(xt.getOutputStream());
    t.start();
    t2.start();
  }
  catch(IOException ioe) {
    ioe.printStackTrace();
  }
  stat="process started!";
}

void rmproc() {
  if (xt!=null && xt.isAlive()) {
    long xtid=xt.pid();
    xt.destroyForcibly();
    println("process ["+xtid+"] killed!");
  }
  if (rd!=null) rd.isOn=false;
  if (rd2!=null) rd2.isOn=false;
  stat="waiting for thread death...";
  try {
    Thread.sleep(108);
  }
  catch(InterruptedException ie) {
    ie.printStackTrace();
  }
  rd2=rd=null;
  t=t2=null;
  stat="process termination successful";
}

void trigproc(ArrayList<String> cmdln) {
  rmproc();
  stproc(cmdln);
}
