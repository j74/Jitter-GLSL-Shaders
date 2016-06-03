uniform vec2 redoffset;
uniform vec2 greenoffset;
uniform vec2 blueoffset;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

//vec4 lumcoeff = vec4(0.2125,0.7154,0.0721,0.0);
//vec4 two = vec4(2.0);
//vec4 one = vec4(1.0);



void main (void) 
{ 		
	vec2 redzoomtvec = mod((texcoord0/texdim0) + redoffset, 1.0);
	vec2 greezoomvec = mod((texcoord0/texdim0) + greenoffset, 1.0);
	vec2 bluezoomvec = mod((texcoord0/texdim0) + blueoffset, 1.0);

	
	vec4 input0 = texture2DRect(tex0, texcoord0 * texdim0);
	
	vec4 redinput0 = texture2DRect(tex0, redzoomtvec * texdim0);
	vec4 greeninput0 = texture2DRect(tex0, greezoomvec * texdim0);
	vec4 blueinput0 = texture2DRect(tex0, bluezoomvec * texdim0);
	
	
	vec4 result1 = vec4( redinput0.r , greeninput0.g, blueinput0.b, input0.a);


	// mix with original input0 ? :X:X:X
	//vec4 result = brightlight(input0, result1, mixamount);
	
	gl_FragColor = result1;


} 


