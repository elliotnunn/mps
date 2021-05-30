{
     File:       CGFont.p
 
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
 UNIT CGFont;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGFONT__}
{$SETC __CGFONT__ := 1}

{$I+}
{$SETC CGFontIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGFontRef    = ^LONGINT; { an opaque 32-bit type }
	CGFontRefPtr = ^CGFontRef;  { when a VAR xx:CGFontRef parameter can be nil, it is changed to xx: CGFontRefPtr }
	CGGlyph								= UInt16;
	{	** Font creation. **	}
	{	 Create a CGFont using `platformFontReference', a pointer to a
	 * platform-specific font reference.  For MacOS X, `platformFontReference'
	 * should be a pointer to an ATSFontRef. 	}
	{
	 *  CGFontCreateWithPlatformFont()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGFontCreateWithPlatformFont(platformFontReference: UNIV Ptr): CGFontRef; C;

{** Retain & release. **}
{ Increment the retain count of `font' and return it.  All fonts are
 * created with an initial retain count of 1. }
{
 *  CGFontRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGFontRetain(font: CGFontRef): CGFontRef; C;

{ Decrement the retain count of `font'.  If the retain count reaches 0,
 * then release it and any associated resources. }
{
 *  CGFontRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGFontRelease(font: CGFontRef); C;




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGFontIncludes}

{$ENDC} {__CGFONT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
