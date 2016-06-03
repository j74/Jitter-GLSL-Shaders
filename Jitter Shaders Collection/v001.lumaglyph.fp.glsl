uniform sampler2DRect tex0;
uniform sampler2D tex1; // assumed character map texture is square.

uniform float scale; // amount of pixelization / size of glyphs.
uniform float amount;
// define our varying texture coordinates 
varying vec2 texcoord0;
varying vec2 texdim0;
varying vec2 texcoord1;
varying vec2 texdim1;


uniform float glyph;

// luma coeffs
const vec3 lumcoeff = vec3(0.299,0.587,0.114);

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

	float luma = dot(avgColor.rgb, lumcoeff);

	// now weve pixelized and have our luma value. we use luma as a lookup for our glyph textures. 
	// each glyph is n x n texture coordinates. we can divide our s and t coords by the number of rows and columns
	// to get the proper coord for the individual glyph we match to the luma.

	// luma is between 0 and 1 float, and we have 10 x 10 glyphs, so we need to force luma to select a glyph for us.
	// here we use a vec2 for column and row selection. We can subsitute for a glyphRowCount and glyphColCount at a later date.

	// texture coordinate system change + aspect ratio correction ?
//	vec2 glyphOffset = (texcoord1 - floor(texcoord1)) / vec2(0.70175438596, 1.25);
//	vec2 glyphOffset = (texcoord1 - floor(texcoord1));
	vec2 glyphOffset = texcoord1; // !?!?!
	
	luma = clamp(luma, 0., 1.);
	
	// luma selects our glyph via an index of 0->100 (10x10)
 	int scaledLuma = int(floor((luma * 100.))); 	
	float scaledLumaRow = mod(float(scaledLuma /10 ), 10.)  / 10.;
	float scaledLumaCol = mod(float(scaledLuma), 10.) / 10.;
	
	vec2 selectedGlyph = vec2(scaledLumaCol,scaledLumaRow);


	vec2 glyphTextureCoord = mod(glyphOffset / inPixelHalfStep / 60. + selectedGlyph, 0.1) + selectedGlyph;

	 gl_FragColor = texture2D(tex1, glyphTextureCoord);
//	vec4 outputGlyph = texture2D(tex1, glyphTextureCoord);

   // gl_FragColor = mix(vec4(luma),outputGlyph, amount);

} 

// my method for doing pixelation prior to LED shader code. Had some issues. basically floored off box blur.		
/*	// texture offsets based on the pixel size.
	vec2 offset0 = vec2(0.);
	vec2 offset1 = vec2(0. - glyphSizeFloat , 0.);
	vec2 offset2 = vec2(0. + glyphSizeFloat , 0.);
	vec2 offset3 = vec2(0. , 0. - glyphSizeFloat);
	vec2 offset4 = vec2(0. , 0. + glyphSizeFloat);
	vec2 offset5 = vec2(0. - glyphSizeFloat , 0. - glyphSizeFloat);
	vec2 offset6 = vec2(0. - glyphSizeFloat , 0. + glyphSizeFloat);
	vec2 offset7 = vec2(0. + glyphSizeFloat , 0. + glyphSizeFloat);
	vec2 offset8 = vec2(0. + glyphSizeFloat , 0. - glyphSizeFloat);

	// Our AVG of the pixels based on the glyph size uniform and pixelate the texture coords to make things pixely!
	vec4 input0 = texture2DRect(tex0, floor((floor(normalizedCoords / offset0)) * offset0) * texdim0 );
	vec4 input1 = texture2DRect(tex0, floor((floor(normalizedCoords / offset1)) * offset1) * texdim0 );
	vec4 input2 = texture2DRect(tex0, floor((floor(normalizedCoords / offset2)) * offset2) * texdim0 );
	vec4 input3 = texture2DRect(tex0, floor((floor(normalizedCoords / offset3)) * offset3) * texdim0 );
	vec4 input4 = texture2DRect(tex0, floor((floor(normalizedCoords / offset4)) * offset4) * texdim0 );
	vec4 input5 = texture2DRect(tex0, floor((floor(normalizedCoords / offset5)) * offset5) * texdim0 );
	vec4 input6 = texture2DRect(tex0, floor((floor(normalizedCoords / offset6)) * offset6) * texdim0 );
	vec4 input7 = texture2DRect(tex0, floor((floor(normalizedCoords / offset7)) * offset7) * texdim0 );
	vec4 input8 = texture2DRect(tex0, floor((floor(normalizedCoords / offset8)) * offset8) * texdim0 );
*/

