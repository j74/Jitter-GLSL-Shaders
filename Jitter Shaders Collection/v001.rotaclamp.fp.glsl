uniform vec2 clamp;
uniform vec2 width;
uniform vec2 anchor;
uniform float theta;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;


void main (void) 
{ 		
	// rotation matrix
	mat2 rotmat = mat2 (cos(theta),sin(theta),-sin(theta),cos(theta));
	
	// inverse rotation matrix
	mat2 irotmat = mat2 (cos(-1.0 * theta),sin( -1.0 * theta),-sin(-1.0 * theta),cos(-1.0 * theta));
	
	// make normalized texture coord for rotation with anchor for origin 
	vec2  point = ((texcoord0/texdim0 - anchor) * rotmat) + anchor;
	
	// clamp
	point = clamp(point,clamp,width);

	// unrotate after applying clamp
	point = ((point - anchor) * irotmat) + anchor;
	
	// output after unnormalizing.
	vec4 result = texture2DRect(tex0, point * texdim0);
	
	
	gl_FragColor = result;


} 


