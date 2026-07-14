#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D previous;
uniform vec2 resolution;
uniform float time;
uniform float mx;
varying vec4 vertTexCoord;

float get(vec2 uv, float x, float y)
{
    return texture2D(previous, fract(uv + vec2(x, y)/resolution)).b;
}

void main()
{
    vec2 uv = vertTexCoord.xy;
    vec2 px = 1.0 / resolution;

    float l=get(uv, -1,0);
    float ll=get(uv, -2,0);
    float lu=get(uv, -1,1);
    float ld=get(uv, -1,-1);
    float r=get(uv, 1,0);
    float rr=get(uv, 2,0);
    float ru=get(uv, 1,1);
    float rd=get(uv, 1,-1);
    float u=get(uv, 0,1);
    float uu=get(uv, 0,2);
    float d=get(uv, 0,-1);
    float dd=get(uv, 0,-2);

    float c=texture2D(previous, uv).r;

    float n=0.0;
    n=0.5*ll+0.5*ld + 0.051*mx*lu - 0.025*r;

    if(n<0) n=1.0;
    else if(n>1.0) n=0.0;

    float red=n*(0.51+0.49*sin(1.12*time));
    gl_FragColor = vec4(red,n,n, 1.0);
}
