int fr=0;
int ns=-1;
int tmax=60;
int trem;
int slowclk=0;

enum TimerState {
  COUNTDOWN, TIMEOUT, PAUSED
}
TimerState ts=TimerState.COUNTDOWN;

color wht=color(255, 255, 255);
color blk=color(0, 0, 0);
color gry=color(100, 100, 100);

void setup() {
  size(900, 600);
  background(blk);
  fill(wht);
  noStroke();
  textSize(256);
  textAlign(CENTER, CENTER);
}

String gettime(int s) {
  if (s>=3600) {
    throw new RuntimeException("timer capability 1 hour!");
  }
  int min=s/60;
  int sec=s%60;
  return String.format("%02d:%02d", min, sec);
}

void tick() {
  if (fr==0) {
    fr=int(frameRate);
  }
  fr--;
}

void draw() {
  tick();
  if (ts==TimerState.COUNTDOWN) {
    if (fr==0) {
      background(blk);
      ns++;
      trem=tmax-ns;
      if (trem==0) {
        ts=TimerState.TIMEOUT;
      }
      text(gettime(trem), width/2, height/2-height/8);
    }
  } else if (ts==TimerState.PAUSED) {
    //
  } else if (ts==TimerState.TIMEOUT) {
    if (fr<frameRate/2) {
      background(blk);
      fill(wht);
    } else {
      background(wht);
      fill(blk);
    }
    text(gettime(trem), width/2, height/2-height/8);
  }
}

void keyPressed() {
  if (key==' ' && ts==TimerState.PAUSED) {
    ts=TimerState.COUNTDOWN;
  }
  if (key==' ' && ts==TimerState.COUNTDOWN) {
    ts=TimerState.PAUSED;
  }
  if (key=='r') {
    ns=-1;
    ts=TimerState.COUNTDOWN;
  }
}
