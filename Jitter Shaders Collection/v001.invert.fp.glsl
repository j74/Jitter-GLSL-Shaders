// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;


void main (void) 
{ 		
	vec4 input0 = texture2DRect(tex0, texcoord0);
		
	input0 = vec4(1.0) - input0;

	gl_FragColor = input0;

} 
