uniform vec4 thresh; 
uniform bool swap;

// define our varying texture coordinates 
varying vec2 texcoord0; 

// define our rectangular texture samplers 
uniform sampler2DRect tex0; 

void main (void) 
{ 
	
	
	// sample our textures 
	vec4 input0 = texture2DRect(tex0, texcoord0); 

	vec4 result; 
	// perform our calculation
	
	if(swap == true)
	{
		result = vec4(greaterThan(thresh, input0));
	}	
	else
	{
		result = vec4(greaterThan(input0, thresh));
	}

	// write our data to the fragment color 
	gl_FragColor = result; 
} 
