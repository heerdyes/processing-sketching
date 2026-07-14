PGraphics bufa, bufb;
PShader shdr;
int ww, hh;
float t, dt;

void cainit()
{
  bufa.beginDraw();
  bufa.loadPixels();
  int n=bufa.pixels.length;

  for (int i=0; i<n; i++)
  {
    bufa.pixels[i]=random(1)>0.5?color(255):color(0);
  }

  bufa.updatePixels();
  bufa.endDraw();
}

void setup()
{
  size(1600, 900, P2D);
  ww=width/2;
  hh=height/2;
  t=0.0;
  dt=0.01;

  bufa=createGraphics(ww, hh, P2D);
  bufb=createGraphics(ww, hh, P2D);

  cainit();
  shdr=loadShader("ca2d.glsl");
}

void draw()
{
  shdr.set("previous", bufa);
  shdr.set("resolution", (float)ww, (float)hh);
  shdr.set("time", t);
  shdr.set("mx", map(mouseX, 0, width, 0, 1));

  bufb.beginDraw();
  bufb.shader(shdr);
  bufb.rect(0, 0, ww, hh);
  bufb.endDraw();

  image(bufb, 0, 0, width, height);

  PGraphics tmp=bufa;
  bufa=bufb;
  bufb=tmp;

  t+=dt;
}
