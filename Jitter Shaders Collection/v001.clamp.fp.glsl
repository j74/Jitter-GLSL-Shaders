uniform vec2 clamp;
uniform vec2 width;
uniform vec2 origin;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

void main (void) 
{ 
		
	vec2 point = texcoord0 / texdim0; //normalize coordinates 0. 1.
//	vec2 normCoord = vec2(2.0) * point - vec2(1.0); // center coordinate. -1. 1.

	
	vec2 modclamp = mod(clamp, 1.);
	
	if(point.x >= modclamp.x && point.x <= modclamp.x + width.x) point.x = modclamp.x;

	if(point.y>= modclamp.y && point.y <= modclamp.y + width.y) point.y = modclamp.y;

	
	point = abs(mod(point+origin, 1.0));
	
	vec2 texCoord = point* texdim0;
	gl_FragColor = texture2DRect(tex0, texCoord);

} 
