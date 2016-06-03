uniform vec2 width;
uniform vec2 offset;
// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

void main (void) 
{ 
		
	vec2 point = abs(mod((texcoord0/texdim0),1.));//normalize coordinates
	
	vec2 normCoord = vec2(2.0) * point - vec2(1.0);


//	float r = length(normCoord);
//	float phi = atan(normCoord.y, normCoord.x); 

	// back from polar space.
//	normCoord.x = r* cos(phi);
//	normCoord.y = r* sin(phi);
	
	vec2 s = sign(normCoord);
	normCoord = abs(normCoord);
//	normCoord = 0.5 * normCoord + 0.5 * smoothstep(width.x, width.y, normCoord) * normCoord;
	normCoord = mod(normCoord+offset,width);
	normCoord = s * normCoord;
	
	
	
	vec2 texCoord = (normCoord / 2.0 + 0.5) * texdim0;
	gl_FragColor = texture2DRect(tex0, texCoord);
	

//	vec2 outputdim = outputpoint* texdim0;

//	vec4 result = texture2DRect(tex0, outputdim);
	
	
//	gl_FragColor = result;
} 


	// bs.

	//	vec2 outputpoint = sqrt(vec2(point.x + width.x, point.y+width.y));
	//	vec2 outputpoint = vec2(sin(point.x + width.x), cos(point.y+width.y));
