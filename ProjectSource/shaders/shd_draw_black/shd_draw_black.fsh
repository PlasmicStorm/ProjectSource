//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 savecol = vec4(0.0, 0.0, 0.0, 0.2);
	if(col.a > 0.0)
	{
		col = savecol;	
	}
    gl_FragColor = col;
}
