uniform float amount;
uniform vec3 color;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

// luma 
const vec4 lumcoeff = vec4(0.299,0.587,0.114,0.);

void main (void) 
{ 		

	vec4 input0 = texture2DRect(tex0, texcoord0);

//	vec3 revcolor = vec3(1.0) - color;
			
	vec4 result = input0 + vec4(color, 0.);
	
	
	
	gl_FragColor = mix(input0, result, amount);

} 
