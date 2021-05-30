{
     File:       CGImage.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-93.14
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
 UNIT CGImage;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGIMAGE__}
{$SETC __CGIMAGE__ := 1}

{$I+}
{$SETC CGImageIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGCOLORSPACE__}
{$I CGColorSpace.p}
{$ENDC}
{$IFC UNDEFINED __CGDATAPROVIDER__}
{$I CGDataProvider.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGImageRef    = ^LONGINT; { an opaque 32-bit type }
	CGImageRefPtr = ^CGImageRef;  { when a VAR xx:CGImageRef parameter can be nil, it is changed to xx: CGImageRefPtr }
	CGImageAlphaInfo 			= SInt32;
CONST
	kCGImageAlphaNone			= 0;
	kCGImageAlphaPremultipliedLast = 1;							{  For example, premultiplied RGBA  }
	kCGImageAlphaPremultipliedFirst = 2;						{  For example, premultiplied ARGB  }
	kCGImageAlphaLast			= 3;							{  For example, non-premultiplied RGBA  }
	kCGImageAlphaFirst			= 4;							{  For example, non-premultiplied ARGB  }
	kCGImageAlphaNoneSkipLast	= 5;							{  Equivalent to kCGImageAlphaNone.  }
	kCGImageAlphaNoneSkipFirst	= 6;


	{	 Create an image. 	}
	{
	 *  CGImageCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGImageCreate(width: size_t; height: size_t; bitsPerComponent: size_t; bitsPerPixel: size_t; bytesPerRow: size_t; colorspace: CGColorSpaceRef; alphaInfo: CGImageAlphaInfo; provider: CGDataProviderRef; {CONST}VAR decode: Single; shouldInterpolate: LONGINT; intent: CGColorRenderingIntent): CGImageRef; C;

{ Create an image mask. }
{
 *  CGImageMaskCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageMaskCreate(width: size_t; height: size_t; bitsPerComponent: size_t; bitsPerPixel: size_t; bytesPerRow: size_t; provider: CGDataProviderRef; {CONST}VAR decode: Single; shouldInterpolate: LONGINT): CGImageRef; C;

{ Increment the retain count of `image' and return it.  All images are
 * created with an initial retain count of 1. }
{
 *  CGImageRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageRetain(image: CGImageRef): CGImageRef; C;

{ Decrement the retain count of `image'.  If the retain count reaches 0,
 * then release it and any associated resources. }
{
 *  CGImageRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGImageRelease(image: CGImageRef); C;

{ Return 1 if `image' is an image mask, 0 otherwise. }
{
 *  CGImageIsMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageIsMask(image: CGImageRef): LONGINT; C;

{ Return the width of `image'. }
{
 *  CGImageGetWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetWidth(image: CGImageRef): size_t; C;

{ Return the height of `image'. }
{
 *  CGImageGetHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetHeight(image: CGImageRef): size_t; C;

{ Return the number of bits/component of `image'. }
{
 *  CGImageGetBitsPerComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetBitsPerComponent(image: CGImageRef): size_t; C;

{ Return the number of bits/pixel of `image'. }
{
 *  CGImageGetBitsPerPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetBitsPerPixel(image: CGImageRef): size_t; C;

{ Return the number of bytes/row of `image'. }
{
 *  CGImageGetBytesPerRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetBytesPerRow(image: CGImageRef): size_t; C;

{ Return the colorspace of `image', or NULL if `image' is an image
 * mask. }
{
 *  CGImageGetColorSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetColorSpace(image: CGImageRef): CGColorSpaceRef; C;

{ Return the alpha info of `image'. }
{
 *  CGImageGetAlphaInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetAlphaInfo(image: CGImageRef): CGImageAlphaInfo; C;

{Return the data provider of `image'. }
{
 *  CGImageGetDataProvider()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetDataProvider(image: CGImageRef): CGDataProviderRef; C;

{ Return the decode array of `image'. }
{
 *  CGImageGetDecode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetDecode(image: CGImageRef): SinglePtr; C;

{ Return the interpolation parameter of `image'. }
{
 *  CGImageGetShouldInterpolate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetShouldInterpolate(image: CGImageRef): LONGINT; C;

{ Return the rendering intent of `image'. }
{
 *  CGImageGetRenderingIntent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGImageGetRenderingIntent(image: CGImageRef): CGColorRenderingIntent; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGImageIncludes}

{$ENDC} {__CGIMAGE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
