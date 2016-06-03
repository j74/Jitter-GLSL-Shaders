uniform float levels; 
uniform bool swap;

// define our varying texture coordinates 
varying vec2 texcoord0; 

// define our rectangular texture samplers 
uniform sampler2DRect tex0; 

void main (void)
{
	// sample our textures 
	vec4 input0 = texture2DRect(tex0, texcoord0); 
	
	vec4 result = floor(input0 * vec4(levels)) / vec4(levels)  ;
		
	// write our data to the fragment color 
	gl_FragColor = result; 
} 
