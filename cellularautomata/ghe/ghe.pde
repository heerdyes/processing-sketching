PShader updateShader;
PShader displayShader;
PGraphics buffer;

// ------------- shaders ---------------- //
String[] vertSrc = { """
#version 330 core
uniform mat4 transformMatrix;
in vec4 position;
void main() {
  gl_Position = transformMatrix * position;
}
""" };

String[] updateFragSrc = {"""
#version 330 core
uniform sampler2D pstate;
uniform vec2 resolution;       // provided by Processing

out vec4 fragColor;

void main() {
  float dx = 1.0/resolution.x;
  float dy = 1.0/resolution.y;
  vec2 uv = gl_FragCoord.xy / resolution;
  uv.y = 1.0 - uv.y;

  vec3 udu = texture(pstate, uv).rgb;
  float c = udu.r;
  float z = udu.g;

  // neighborhood
  float r = texture(pstate, vec2(uv.x+dx, uv.y)).x;
  float ru = texture(pstate, vec2(uv.x+dx, uv.y+dy)).x;
  float ru2 = texture(pstate, vec2(uv.x+dx, uv.y+2.0*dy)).x;
  float rd = texture(pstate, vec2(uv.x+dx, uv.y-dy)).x;
  float rd2 = texture(pstate, vec2(uv.x+dx, uv.y-2.0*dy)).x;
  float r2 = texture(pstate, vec2(uv.x+2.0*dx, uv.y)).x;
  float r2u = texture(pstate, vec2(uv.x+2.0*dx, uv.y+dy)).x;
  float r2d = texture(pstate, vec2(uv.x+2.0*dx, uv.y-dy)).x;
  float r3 = texture(pstate, vec2(uv.x+3.0*dx, uv.y)).x;

  float l = texture(pstate, vec2(uv.x-dx, uv.y)).x;
  float lu = texture(pstate, vec2(uv.x-dx, uv.y+dy)).x;
  float lu2 = texture(pstate, vec2(uv.x-dx, uv.y+2.0*dy)).x;
  float ld = texture(pstate, vec2(uv.x-dx, uv.y-dy)).x;
  float ld2 = texture(pstate, vec2(uv.x-dx, uv.y-2.0*dy)).x;
  float l2 = texture(pstate, vec2(uv.x-2.0*dx, uv.y)).x;
  float l2u = texture(pstate, vec2(uv.x-2.0*dx, uv.y+dy)).x;
  float l2d = texture(pstate, vec2(uv.x-2.0*dx, uv.y-dy)).x;
  float l3 = texture(pstate, vec2(uv.x-3.0*dx, uv.y)).x;

  float u = texture(pstate, vec2(uv.x, uv.y+dy)).x;
  float u2 = texture(pstate, vec2(uv.x, uv.y+2.0*dy)).x;
  float u3 = texture(pstate, vec2(uv.x, uv.y+3.0*dy)).x;

  float d = texture(pstate, vec2(uv.x, uv.y-dy)).x;
  float d2 = texture(pstate, vec2(uv.x, uv.y-2.0*dy)).x;
  float d3 = texture(pstate, vec2(uv.x, uv.y-3.0*dy)).x;

  // the equation of life
  float n = 0.25*c + 0.1*rd2 + 0.4*l - 0.1*l2 + 0.55*u2 + 0.1*l2d - 0.1*r2 - 0.1*d - 0.1*u3;

  // store elevation and velocity
  fragColor = vec4(clamp(n, 0, 1 ), z, 0.0, 1.0);
}
"""};

String[] displayFragSrc = {"""
#version 330 core
uniform vec2 resolution;    // provided by Processing
uniform sampler2D data;

out vec4 fragColor;

void main() {
  vec2 p = gl_FragCoord.xy / resolution;
  p.y = 1.0 - p.y;
  fragColor = vec4( vec3(texture(data, p).x), 1. );
}
"""};

// -------------------------------------- //

void setup()
{
  size( 900, 600, P2D );
  noSmooth();
  buffer = createGraphics(width, height, P2D);
  buffer.noSmooth();
  buffer.beginDraw();
  buffer.background(127);
  buffer.endDraw();

  updateShader = new PShader( this, vertSrc, updateFragSrc );
  displayShader = new PShader( this, vertSrc, displayFragSrc );
}

void draw()
{
  buffer.beginDraw();
  updateShader.set( "pstate", buffer.get() );
  buffer.filter( updateShader );
  buffer.endDraw();

  if ( mousePressed )
  {
    buffer.beginDraw();
    buffer.resetShader();
    buffer.fill( keyPressed?255:0, 0, 0 );
    buffer.noStroke();
    buffer.circle( mouseX, mouseY, 8 );
    buffer.endDraw();
  }

  displayShader.set( "data", buffer.get() );
  shader( displayShader );
  rect( 0, 0, width, height );
  resetShader();
}
