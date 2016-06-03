uniform vec2 origin;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

void main (void) 
{ 
		
	vec2 point = texcoord0/texdim0;
		
	vec2 normCoord = vec2(2.0) * point - vec2(1.0); // coordinates are now -1.0 to 1.0
			

	if(all(lessThanEqual(origin, vec2(0.0))))
	{
		normCoord = origin + abs(normCoord - origin);
	}
	else if (origin.x < 0.0 && origin.y > 0.0)
	{
		normCoord.x= origin.x + abs(normCoord.x - origin.x);
		normCoord.y= origin.y - abs(normCoord.y - origin.y);
		
	}
	else if (origin.x > 0.0 && origin.y < 0.0)
	{
		normCoord.x= origin.x - abs(normCoord.x - origin.x);
		normCoord.y= origin.y + abs(normCoord.y - origin.y);
	
	}
	else
	{
		normCoord = origin - abs(normCoord - origin);
	}

	vec2 texCoord = (normCoord / 2.0 + 0.5) * texdim0; // unnormalize
	
	gl_FragColor = texture2DRect(tex0, texCoord);

} 