// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

const float pi=3.1415926;

void main(void)
{
	vec2 normalizedCoords = texcoord0/texdim0;  //[0 -> 1];
	normalizedCoords = 2.0 * normalizedCoords - 1.0;

 	//float theta =  (.5*pi) - normalizedCoords.x * (pi);
	
	float theta =  (pi) + normalizedCoords.x * (pi);
	
	float r =  (1.0 - normalizedCoords.y) * 0.5;
	
	vec2 cartesian = vec2 (-r * sin(theta),r * cos(theta));
	
	cartesian = ( (cartesian/2.0) + 0.5) * texdim0;
	gl_FragColor = texture2DRect(tex0, cartesian);
}
