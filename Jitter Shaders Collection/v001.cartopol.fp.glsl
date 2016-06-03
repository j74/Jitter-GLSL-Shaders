// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

const float pi=3.1415926;

void main(void)
{


// NORMALIZED VERSION ?

	vec2 normalizedCoords = texcoord0/texdim0;  //[0 -> 1];
	normalizedCoords = 2.0 * normalizedCoords - 1.0;
	
	// center = 0, because cords are -1 to 1 so we remove it
	float theta = (pi) + atan((normalizedCoords.x),(normalizedCoords.y));
		
	float r = length(normalizedCoords);
	
	vec2 polar = vec2((theta/(2.0*pi)) * texdim0.x, (r) * texdim0.y);

	gl_FragColor = texture2DRect(tex0, polar);

}
