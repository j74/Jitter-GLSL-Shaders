uniform float radius;
uniform vec2 scale;
uniform vec2 origin;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

void main (void) 
{ 
		
	vec2 point = texcoord0/texdim0 ; //normalize coordinates
	
	vec2 normCoord = (vec2(2.0) * point) - vec2(0.5);
	
	normCoord += origin;

	float r = length(normCoord ) ;
	float phi = atan(normCoord.y, normCoord.x); 


	// no maipulate r and phi to do your bidding.
	if (r > radius) r = radius; 

	// back from polar space.
	normCoord.x = r* cos(phi);
	normCoord.y = r* sin(phi);
	
	normCoord -= origin;
	
	
	vec2 texCoord = ((normCoord + vec2(0.5)) / vec2(2.0) )* texdim0;
	gl_FragColor = texture2DRect(tex0, texCoord);
	

} 
