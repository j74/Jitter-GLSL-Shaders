uniform float amount;
uniform float vignette;

// define our rectangular texture samplers 
uniform sampler2DRect tex0;
uniform sampler1D tex1; // for levels LUT - hard coded for simplicity

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texcoord1;
varying vec2 texcoord2;
varying vec2 texcoord3;
varying vec2 texcoord4;

varying vec2 texdim0;

varying vec2 texcoordLUT;


// constants.
const vec4 one = vec4(1.0);	
const vec4 two = vec4(2.0);
const vec4 lumcoeff = vec4(0.299,0.587,0.114, 0.);

/// functions

// create a black and white oval about the center of our image for our vignette
vec4 vignetteFucntion(vec2 normalizedTexcoord)
{
	normalizedTexcoord = 2.0 * normalizedTexcoord - 1.0;
	float r = length(normalizedTexcoord);
	return 1.0 - vec4(smoothstep(0.5,1.0,r)) + 0.5;
}


vec4 hardlight(vec4 a, vec4 b, float amount)
{
	vec4 result;
	vec4 branch1;
	vec4 branch2;
	float luminance = dot(b,lumcoeff);
	float mixamount;
	
	mixamount = clamp((luminance - 0.45) * 10., 0., 1.);
	branch1 = two * a * b;
	branch2 = one - (two * (one - a) * (one - b));

	result =  mix(branch1,branch2, vec4(mixamount));
	
	return mix(a,result, amount);
}

void main (void) 
{ 		
	vec2 normcoord = texcoord0/texdim0;

	// make a vignette around our borders.
	vec4 vignetteResult = vignetteFucntion(normcoord);

	// sharpen via unsharp mask (subtract image from blured image)
	vec4 input0 = texture2DRect(tex0, texcoord0);
	vec4 input1 = texture2DRect(tex0, texcoord1);
	vec4 input2 = texture2DRect(tex0, texcoord2);
	vec4 input3 = texture2DRect(tex0, texcoord3);
	vec4 input4 = texture2DRect(tex0, texcoord4);
			
	vec4 sharpened = 5.0 * input0 - (input1 + input2 + input3 + input4);
	
	// hardlight sharpened luma with original - this is a hack to avoid LAB colorspace conversion to sharpen the lightness channel.
	vec4 hardlighted = hardlight(sharpened,input0, .5);
		
	// de-saturate to compensate for hardlight workaround.
	vec4 saturated = mix(vec4(dot(hardlighted,lumcoeff)), hardlighted, 0.75);
		
	// levels
	vec4 result;
		
	result.r = texture1D(tex1, saturated.r).r;
	result.g = texture1D(tex1, saturated.g).g;
	result.b = texture1D(tex1, saturated.b).b;
	result.a = saturated.a;
		
	gl_FragColor = mix(input0, result *  (mix(vec4(1.0),vignetteResult, vignette)),amount);
//	gl_FragColor = overlay(input0*input0, input0, vec4(amount));
		
} 
