uniform float exposure;
uniform float brightness;
uniform vec3 lumacomponents;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

// luma 
const vec3 lumcoeff = vec3(0.299,0.587,0.114);

void main (void) 
{ 		
	vec4 input0 = texture2DRect(tex0, texcoord0);
		
	//exposure knee	
	input0 = input0 * (exp2(input0)*vec4(exposure));
	
	vec4 lumacomponents = vec4(lumcoeff * lumacomponents, 0.0 );
	
	float luminance = dot(input0,lumacomponents);
	
	vec4 luma = vec4(luminance);

	gl_FragColor = vec4(luma.rgb,1.0)*brightness;

} 
