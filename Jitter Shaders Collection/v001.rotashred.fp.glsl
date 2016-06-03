uniform vec2 offset;
uniform vec2 width;
uniform vec2 anchor;
uniform float angle;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;


const float freq = .5;

void main (void) 
{ 		
	// rotation matrix
	mat2 rotmat = mat2 (cos(angle),sin(angle),-sin(angle),cos(angle));
	
	// inverse rotation matrix
	mat2 irotmat = mat2 (cos(-1.0 * angle),sin( -1.0 * angle),-sin(-1.0 * angle),cos(-1.0 * angle));
	
	// make normalized texture coord for rotation with anchor for origin
	vec2 point = texcoord0/ texdim0; 
	point = ((point - anchor) * rotmat) + anchor;
	
	//shred
	vec2 s = sign(point);
	point = abs(point);
	point = mod(point+offset,width);
	point = s * point;

	// unrotate after applying shred
	point = (((point) - anchor) * irotmat) + anchor;
	
	

	
	// apply antialiasing to our varying as per Orange book pg 448
	vec2 fw = fwidth(point);
	
	vec2 fuzz = fw * freq;
	
	float fuzzmax = max(fuzz.s, fuzz.t);
	
		vec4 shred = texture2DRect(tex0, point * texdim0);
	//	vec4 shred2 = texture2DRect(tex0, point + 0.1 * texdim0);
		vec4 shred2 = texture2DRect(tex0, (point-fw) * texdim0);
	
	vec4 red =  vec4(1.0, 0.0, 0.0, 1.0);
	
//	vec4 result = mix(shred,, );
	vec4 result = mix(shred, red, smoothstep(0.4, 0.6,fuzzmax));
	
	
	gl_FragColor = result;
} 


