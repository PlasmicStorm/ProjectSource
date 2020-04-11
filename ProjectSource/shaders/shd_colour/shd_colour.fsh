//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 colour;

void main()
{
	vec3 out_col	= texture2D(gm_BaseTexture, v_vTexcoord).rgb;
	gl_FragColor	= vec4(out_col * colour, 1.0);
}


//Old
/*
vec4 base_col = texture2D( gm_BaseTexture, v_vTexcoord );
float lum = dot(base_col.rgb, vec3(0.299, 0.587, 0.114));
	if(lum > 0.5)
	{
		base_col.rgb = 1.0 - (1.0 - 2.0 * (base_col.rgb -0.5)) * (1.0 - col);
	} else
	{
		base_col.rgb = (2.0 * base_col.rgb) * col;
	}
*/