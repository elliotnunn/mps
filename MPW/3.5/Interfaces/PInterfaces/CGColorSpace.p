{
     File:       CGColorSpace.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGColorSpace;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGCOLORSPACE__}
{$SETC __CGCOLORSPACE__ := 1}

{$I+}
{$SETC CGColorSpaceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGDATAPROVIDER__}
{$I CGDataProvider.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGColorSpaceRef    = ^LONGINT; { an opaque 32-bit type }
	CGColorSpaceRefPtr = ^CGColorSpaceRef;  { when a VAR xx:CGColorSpaceRef parameter can be nil, it is changed to xx: CGColorSpaceRefPtr }
	CGColorRenderingIntent 		= SInt32;
CONST
	kCGRenderingIntentDefault	= 0;
	kCGRenderingIntentAbsoluteColorimetric = 1;
	kCGRenderingIntentRelativeColorimetric = 2;
	kCGRenderingIntentPerceptual = 3;
	kCGRenderingIntentSaturation = 4;


	{	* Device-dependent color spaces.  *	}
	{	 Create a DeviceGray colorspace. 	}
	{
	 *  CGColorSpaceCreateDeviceGray()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGColorSpaceCreateDeviceGray: CGColorSpaceRef; C;

{ Create a DeviceRGB colorspace. }
{
 *  CGColorSpaceCreateDeviceRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateDeviceRGB: CGColorSpaceRef; C;

{ Create a DeviceCMYK colorspace. }
{
 *  CGColorSpaceCreateDeviceCMYK()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateDeviceCMYK: CGColorSpaceRef; C;

{* Device-independent color spaces. *}
{ Create a calibrated gray colorspace.  `whitePoint' is an array of 3
 * numbers specifying the tristimulus value, in the CIE 1931 XYZ-space, of
 * the diffuse white point.  `blackPoint' is an array of 3 numbers
 * specifying the tristimulus value, in CIE 1931 XYZ-space, of the diffuse
 * black point. `gamma' defines the gamma for the gray component. }
{
 *  CGColorSpaceCreateCalibratedGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateCalibratedGray({CONST}VAR whitePoint: Single; {CONST}VAR blackPoint: Single; gamma: Single): CGColorSpaceRef; C;

{ Create a calibrated RGB colorspace.  `whitePoint' is an array of 3
 * numbers specifying the tristimulus value, in the CIE 1931 XYZ-space, of
 * the diffuse white point.  `blackPoint' is an array of 3 numbers
 * specifying the tristimulus value, in CIE 1931 XYZ-space, of the diffuse
 * black point. `gamma' is an array of 3 numbers specifying the gamma for
 * the red, green, and blue components of the color space. `matrix' is an
 * array of 9 numbers specifying the linear interpretation of the
 * gamma-modified RGB values of the colorspace with respect to the final
 * XYZ representation. }
{
 *  CGColorSpaceCreateCalibratedRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateCalibratedRGB({CONST}VAR whitePoint: Single; {CONST}VAR blackPoint: Single; {CONST}VAR gamma: Single; {CONST}VAR matrix: Single): CGColorSpaceRef; C;

{ Create an L*a*b* colorspace.  `whitePoint' is an array of 3 numbers
 * specifying the tristimulus value, in the CIE 1931 XYZ-space, of the
 * diffuse white point.  `blackPoint' is an array of 3 numbers specifying
 * the tristimulus value, in CIE 1931 XYZ-space, of the diffuse black
 * point. `range' is an array of four numbers specifying the range of valid
 * values for the a* and b* components of the color space. }
{
 *  CGColorSpaceCreateLab()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateLab({CONST}VAR whitePoint: Single; {CONST}VAR blackPoint: Single; {CONST}VAR range: Single): CGColorSpaceRef; C;

{ Create an ICC-based colorspace.  `nComponents' specifies the number of
 * color components in the color space defined by the ICC profile data.
 * This must match the number of components actually in the ICC profile,
 * must be 1, 3, or 4.  `range' is an array of 2*nComponents numbers
 * specifying the minimum and maximum valid values of the corresponding
 * color components, so that for color component k, range[2*k] <= c[k] <=
 * range[2*k+1], where c[k] is the k'th color component.  `profile' is a
 * data provider specifying the ICC profile.  `alternate' specifies an
 * alternate colorspace to be used in case the ICC profile is no supported.
 * It must have `nComponents' color components. If `alternate' is NULL,
 * then the color space used will be DeviceGray, DeviceRGB, or DeviceCMYK,
 * depending on whether `nComponents' is 1, 3, or 4, respectively. }
{
 *  CGColorSpaceCreateICCBased()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateICCBased(nComponents: size_t; {CONST}VAR range: Single; profile: CGDataProviderRef; alternateSpace: CGColorSpaceRef): CGColorSpaceRef; C;

{* Special colorspaces. *}
{ Create an indexed colorspace.  A sample value in an indexed color space
 * is treated as an index into the color table of the color space.  `base'
 * specifies the base color space in which the values in the color table
 * are to be interpreted. `lastIndex' is an integer which specifies the
 * maximum valid index value; it must be less than or equal to 255.
 * `colorTable' is an array of m * (lastIndex + 1) bytes, where m is
 * the number of color components in the base color space.  Each byte
 * is an unsigned integer in the range 0 to 255 that is scaled to the
 * range of the corresponding color component in the base color space. }
{
 *  CGColorSpaceCreateIndexed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceCreateIndexed(baseSpace: CGColorSpaceRef; lastIndex: size_t; {CONST}VAR colorTable: UInt8): CGColorSpaceRef; C;

{* Colorspace information. *}
{ Return the number of color components supported by the colorspace `cs'. }
{
 *  CGColorSpaceGetNumberOfComponents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceGetNumberOfComponents(cs: CGColorSpaceRef): size_t; C;

{* Retaining & releasing colorspaces. *}
{ Increment the retain count of `cs' and return it.  All colorspaces are
 * created with an initial retain count of 1. }
{
 *  CGColorSpaceRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGColorSpaceRetain(cs: CGColorSpaceRef): CGColorSpaceRef; C;

{ Decrement the retain count of `cs'.  If the retain count reaches 0, then
 * release it and any associated resources. }
{
 *  CGColorSpaceRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGColorSpaceRelease(cs: CGColorSpaceRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGColorSpaceIncludes}

{$ENDC} {__CGCOLORSPACE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
