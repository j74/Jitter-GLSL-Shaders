uniform float desaturation;
uniform vec3 red;
uniform vec3 green;
uniform vec3 blue;
uniform vec3 gray;

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
		
	vec3 redchannel = vec3(input0.r) * red;
	vec3 greenchannel = vec3(input0.g) * green;
	vec3 bluechannel = vec3(input0.b) * blue;
	
	vec3 result = redchannel + greenchannel + bluechannel;
	
	vec3 graychannel = vec3(dot(input0.rgb,lumcoeff)) * (1.0 + gray);
		
	graychannel = vec3((graychannel.r + graychannel.g + graychannel.b)/3.0);

	gl_FragColor = vec4(mix(result, graychannel, desaturation), input0.a);

} 
