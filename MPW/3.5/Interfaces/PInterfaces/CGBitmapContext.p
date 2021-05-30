{
     File:       CGBitmapContext.p
 
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
 UNIT CGBitmapContext;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGBITMAPCONTEXT__}
{$SETC __CGBITMAPCONTEXT__ := 1}

{$I+}
{$SETC CGBitmapContextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}



{ Create a bitmap context.  The context draws into a bitmap which is
 * `width' pixels wide and `height' pixels high.  The number of components
 * for each pixel is specified by `colorspace', which also may specify a
 * destination color profile. The number of bits for each component of a
 * pixel is specified by `bitsPerComponent', which must be 1, 2, 4, or 8.
 * Each row of the bitmap consists of `bytesPerRow' bytes, which must be at
 * least `(width * bitsPerComponent * number of components + 7)/8' bytes.
 * `data' points a block of memory at least `bytesPerRow * height' bytes.
 * `alphaInfo' specifies whether the bitmap should contain an alpha
 * channel, and how it's to be generated. }

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 *  CGBitmapContextCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGBitmapContextCreate(data: UNIV Ptr; width: size_t; height: size_t; bitsPerComponent: size_t; bytesPerRow: size_t; colorspace: CGColorSpaceRef; alphaInfo: CGImageAlphaInfo): CGContextRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGBitmapContextIncludes}

{$ENDC} {__CGBITMAPCONTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
