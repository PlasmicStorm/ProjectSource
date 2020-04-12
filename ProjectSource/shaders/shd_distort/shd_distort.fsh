//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D distort_tex;

uniform float time;
uniform float size;
uniform float strength;
uniform vec2  tex_offset;

void main()
{
	vec2 distort;
	distort.x = texture2D( distort_tex, fract(v_vTexcoord * size + vec2(0, time))).r * strength;
	distort.y = texture2D( distort_tex, fract(v_vTexcoord * size + vec2(0, time))).g * strength;
	
    gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord + distort + tex_offset);
}
