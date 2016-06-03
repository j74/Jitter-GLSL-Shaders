// define our rectangular texture samplers 
uniform sampler2DRect tex0;
uniform sampler1D tex1;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texcoord1;

void main (void) 
{ 
	vec4 inputColor = texture2DRect(tex0, texcoord0);
		
	vec4 colorout;
	
	colorout.r = texture1D(tex1, inputColor.r).r;
	colorout.g = texture1D(tex1, inputColor.g).g;
	colorout.b = texture1D(tex1, inputColor.b).b;
	colorout.a = inputColor.a;
	
	gl_FragColor = colorout;
}