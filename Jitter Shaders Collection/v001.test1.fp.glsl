uniform float thresh; 

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;


void main (void) 
{ 
				
	vec4 input0 = texture2DRect(tex0, texcoord0);

	vec4 diff = fwidth(input0);

	input0 *= input0 * diff * thresh - diff;
	
	gl_FragColor = input0;
} 

