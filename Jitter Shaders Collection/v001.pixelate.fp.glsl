uniform sampler2DRect tex0;

uniform float scale; // amount of pixelization / size of glyphs.

// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;

void main (void) 
{ 	
	// pixelization based on LED resampling code found at http://www.lighthouse3d.com/opengl/ledshader/
	
	vec2 normalizedCoords = texcoord0/texdim0;

	vec2 texCoordsStep = 1.0/texdim0*scale;
	vec2 pixelBin = floor(normalizedCoords/texCoordsStep);
	vec2 inPixelStep = texCoordsStep/3.0;
	vec2 inPixelHalfStep = inPixelStep/2.0;
	
	vec2 offset = pixelBin * texCoordsStep;
		
	vec2 offset0 = vec2(inPixelHalfStep.x, inPixelStep.y*2.0 + inPixelHalfStep.y) + offset;
	vec2 offset1 = vec2(inPixelStep.x + inPixelHalfStep.x, inPixelStep.y*2.0 + inPixelHalfStep.y) + offset;
	vec2 offset2 = vec2(inPixelStep.x*2.0 + inPixelHalfStep.x, inPixelStep.y*2.0 + inPixelHalfStep.y) + offset;
	vec2 offset3 = vec2(inPixelHalfStep.x, inPixelStep.y + inPixelHalfStep.y) + offset;
	vec2 offset4 = vec2(inPixelStep.x + inPixelHalfStep.x, inPixelStep.y + inPixelHalfStep.y) + offset;
	vec2 offset5 = vec2(inPixelStep.x*2.0 + inPixelHalfStep.x, inPixelStep.y + inPixelHalfStep.y) + offset;
	vec2 offset6 = vec2(inPixelHalfStep.x, inPixelHalfStep.y) + offset;
	vec2 offset7 = vec2(inPixelStep.x + inPixelHalfStep.x, inPixelHalfStep.y) + offset;
	vec2 offset8 = vec2(inPixelStep.x*2.0 + inPixelHalfStep.x, inPixelHalfStep.y) + offset;



	vec4 input0 = texture2DRect(tex0,offset0 * texdim0);
	vec4 input1 = texture2DRect(tex0,offset1 * texdim0);
	vec4 input2 = texture2DRect(tex0,offset2 * texdim0);
	vec4 input3 = texture2DRect(tex0,offset3 * texdim0);
	vec4 input4 = texture2DRect(tex0,offset4 * texdim0);
	vec4 input5 = texture2DRect(tex0,offset5 * texdim0);
	vec4 input6 = texture2DRect(tex0,offset6 * texdim0);
	vec4 input7 = texture2DRect(tex0,offset7 * texdim0);
	vec4 input8 = texture2DRect(tex0,offset8 * texdim0);
	
	vec4 avgColor = input0 + input1 + input2 + input3 + input4 + input5 + input6 + input7 + input8;
	avgColor /= 9.0;
	
	gl_FragColor = avgColor;
}