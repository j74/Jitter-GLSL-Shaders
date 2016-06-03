uniform vec4 highcolor;
uniform vec4 lowcolor;
uniform float thresh; 

// define our rectangular texture samplers 
uniform sampler2DRect tex0;
uniform sampler2DRect tex1;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texcoord1;


void main (void) 
{ 
				
	vec4 input0 = texture2DRect(tex0, texcoord0);

	vec4 result = vec4(input0.r + input0.g + input0.b / 3.0);
	
	result = (result.r < thresh ) ? lowcolor : highcolor;
	
	result.a = input0.a; // add back original alpha	

	gl_FragColor = result;
} 

