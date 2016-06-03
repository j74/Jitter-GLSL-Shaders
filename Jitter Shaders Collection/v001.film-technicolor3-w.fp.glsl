uniform float amount;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

const vec4 redfilter 		= vec4(1.0, 0.0, 0.0, 0.0);
const vec4 greenfilter 		= vec4(0.0, 1.0, 0.0, 0.0);
const vec4 bluefilter		= vec4(0.0, 0.0, 1.0, 0.0);

const vec4 redorangefilter 	= vec4(.99, 0.263, 0.0, 0.0);

const vec4 cyanfilter		= vec4(0.0, 1.0, 1.0, 0.0);
const vec4 magentafilter	= vec4(1.0, 0.0, 1.0, 0.0);
const vec4 yellowfilter 	= vec4(1.0, 1.0, 0.0, 0.0);


//const vec4 cyanfilter		= vec4(0.0, 1.0, .99, 0.0);
//const vec4 magentafilter	= vec4(1.0, 0.0, .99, 0.0);
//const vec4 yellowfilter 	= vec4(1.0, 1.0, 0.06, 0.0);

void main(void)
{
	
	vec4 input0 = texture2DRect(tex0, texcoord0);

//	vec4 redrecord = input0 * redfilter;
//	vec4 greenrecord = input0 * greenfilter;
//	vec4 bluerecord = input0 * bluefilter;

	// camera has green and magenta filters.
	// green filter goes to green negative,
	// red and blue negatives are stacked back to back
	// and exposed through a magenta filter.
	// blue first, then red.

	vec4 greenrecord = (input0) * greenfilter;
	vec4 bluerecord = (input0) * magentafilter;
	vec4 redrecord = (input0) * redorangefilter;

//	vec4 redoutput = redrecord + cyanfilter;
//	vec4 greenoutput = greenrecord + magentafilter;
//	vec4 blueoutput = bluerecord + yellowfilter;

	// the 3 strip process also had a black and white sound+key track
	// projected at 50% brightness.
//	vec4 soundkey = vec4((input0.r + input0.g + input0.b)/3.0) * 0.5 + 0.5;
//	soundkey = clamp(soundkey, 0., 1.);
		
	vec4 rednegative = vec4((redrecord.r + redrecord.g + redrecord.b)/3.0);
	vec4 greennegative = vec4((greenrecord.r + greenrecord.g + greenrecord.b)/3.0);
	vec4 bluenegative = vec4((bluerecord.r+ bluerecord.g + bluerecord.b)/3.0);

	vec4 redoutput = rednegative + cyanfilter;
	vec4 greenoutput = greennegative + magentafilter;
	vec4 blueoutput = bluenegative + yellowfilter;

	vec4 result = redoutput * greenoutput * blueoutput;

//	vec4 result = vec4(redoutput.r, greenoutput.g, blueoutput.b, input0.a);


	gl_FragColor = mix(input0, result, amount);
}