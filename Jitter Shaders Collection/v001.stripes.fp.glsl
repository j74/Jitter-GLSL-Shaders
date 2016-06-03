uniform float amount;
uniform vec4 color;
uniform float origin;
uniform float angle;
uniform float mirror;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

const vec4 two = vec4(2.0);

void main (void) 
{ 	
	// normalize texture coords [0. - 1.0]
	vec2 normalizedDim = texcoord0/texdim0;

	// rotation matrix
	mat2 rotmat = mat2 (cos(angle),sin(angle),-sin(angle),cos(angle));
	
	// mirror about axis?
	normalizedDim.y = (normalizedDim.y >= mirror) ? normalizedDim.y : -1.0 * normalizedDim.y; 
	
	// rotate
	normalizedDim = (normalizedDim - 0.5) * rotmat + 0.5;

	
	// stripe generation with antialiasing as per Chapt. 17 pg 442 of OrangeBook
	float sawtooth = fract(normalizedDim.x * amount + origin);
	float triangle = abs(2.0 * sawtooth - 1.0);
	float width = fwidth(normalizedDim.x);
	float edge = width * 2.0 * amount;
	
	// apply antialiasing to our stripe
	float stripes = smoothstep(0.5 - edge, 0.5 + edge, triangle); 
	
	// no antialiasing, incase you were curious.
	//float stripes = step(0.5, triangle);
		
	//sample our texture
	vec4 input0 = texture2DRect(tex0, texcoord0);
	
	//gl_FragColor = vec4(stripes);
	gl_FragColor = mix(color, input0, stripes); // mix our color with our incoming video
}