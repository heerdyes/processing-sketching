import java.io.*;

class Irdr implements Runnable {
  InputStreamReader isr;
  Slist<Slist<Integer>> buf;
  int state=0;
  boolean isOn;

  Irdr(InputStream _in, Slist<Slist<Integer>> _buf) {
    isr=new InputStreamReader(_in);
    buf=_buf;
    isOn=true;
  }

  public void run() {
    try {
      Slist<Integer> curln=null;
      StringBuffer csibuf=new StringBuffer();
      for (; isOn; ) {
        int ic=isr.read();
        if (ic==-1) break;
        // special terminal sequence handling
        if (state==0) {
          if (ic==0x1b) {                // ESC code
            state=1;
            continue;                    // skip normal processing
          }                              // else goto normal processing
        } else if (state==1) {           // "accepting ESC code" state
          if (ic==0x5b) {                // 0x5b: '[' := CSI begins
            state=2;
          } else {                       // some other unholy ESC code!
            w("cannot process ESC "+(char)ic);
            state=0;                     // return to normal state
          }
          continue;                      // skip normal processing
        } else if (state==2) {           // "accepting CSI" state
          if (ic==0x6d) {                // 0x6d: 'm' := terminates the CSI cmd
            w("CSI not yet supported: cmd: ["+csibuf.toString()+"]");
            csibuf.setLength(0);
            state=0;                     // return to normal state
          } else {                       // some possibly valid CSI cmd
            csibuf.append((char)ic);     // save it to csibuf
          }
          continue;                      // skip normal processing
        }
        // normal ascii char processing
        if (ic==0x0a) {
          curln=new Slist<>(collimit);
          buf.nq(curln);
        } else {
          if (curln==null) {
            curln=new Slist<>(collimit);
            buf.nq(curln);
          }
          curln.nq(ic);
        }
      }
      stat="irdr.run over";
    }
    catch(IOException ioe) {
      ioe.printStackTrace();
    }
  }
}
