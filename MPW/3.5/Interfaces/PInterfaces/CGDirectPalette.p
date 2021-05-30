{
     File:       CGDirectPalette.p
 
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
 UNIT CGDirectPalette;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGDIRECTPALETTE__}
{$SETC __CGDIRECTPALETTE__ := 1}

{$I+}
{$SETC CGDirectPaletteIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGDIRECTDISPLAY__}
{$I CGDirectDisplay.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGPaletteBlendFraction				= Single;
	{	
	 * Convenient device color representation
	 *
	 * Values should be in the range from 0.0 to 1.0, where 0.0 is black, and 1.0
	 * is full on for each channel.
	 	}
	CGDeviceColorPtr = ^CGDeviceColor;
	CGDeviceColor = RECORD
		red:					Single;
		green:					Single;
		blue:					Single;
	END;

	CGDeviceByteColorPtr = ^CGDeviceByteColor;
	CGDeviceByteColor = RECORD
		red:					SInt8;
		green:					SInt8;
		blue:					SInt8;
	END;

	{	
	 * Create a new palette object representing the default 8 bit color palette.
	 * Release the palette using CGPaletteRelease().
	 	}
	{
	 *  CGPaletteCreateDefaultColorPalette()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGPaletteCreateDefaultColorPalette: CGDirectPaletteRef; C;

{
 * Create a copy of the display's current palette, if any.
 * Returns NULL if the current display mode does not support a palette.
 * Release the palette using CGPaletteRelease().
 }
{
 *  CGPaletteCreateWithDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteCreateWithDisplay(display: CGDirectDisplayID): CGDirectPaletteRef; C;

{
 * Create a new palette with a capacity as specified.  Entries are initialized from
 * the default color palette.  Release the palette using CGPaletteRelease().
 }
{
 *  CGPaletteCreateWithCapacity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteCreateWithCapacity(capacity: CGTableCount): CGDirectPaletteRef; C;

{
 * Create a new palette with a capacity and contents as specified.
 * Release the palette using CGPaletteRelease().
 }
{
 *  CGPaletteCreateWithSamples()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteCreateWithSamples(VAR sampleTable: CGDeviceColor; sampleCount: CGTableCount): CGDirectPaletteRef; C;

{
 * Convenience function:
 * Create a new palette with a capacity and contents as specified.
 * Release the palette using CGPaletteRelease().
 }
{
 *  CGPaletteCreateWithByteSamples()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteCreateWithByteSamples(VAR sampleTable: CGDeviceByteColor; sampleCount: CGTableCount): CGDirectPaletteRef; C;

{
 * Release a palette
 }
{
 *  CGPaletteRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGPaletteRelease(palette: CGDirectPaletteRef); C;

{
 * Get the color value at the specified index
 }
{
 *  CGPaletteGetColorAtIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteGetColorAtIndex(palette: CGDirectPaletteRef; index: CGTableCount): CGDeviceColor; C;

{
 * Get the index for the specified color value
 * The index returned is for a palette color with the
 * lowest RMS error to the specified color.
 }
{
 *  CGPaletteGetIndexForColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteGetIndexForColor(palette: CGDirectPaletteRef; color: CGDeviceColor): CGTableCount; C;

{
 * Get the number of samples in the palette
 }
{
 *  CGPaletteGetNumberOfSamples()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteGetNumberOfSamples(palette: CGDirectPaletteRef): CGTableCount; C;


{
 * Set the color value at the specified index
 }
{
 *  CGPaletteSetColorAtIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGPaletteSetColorAtIndex(palette: CGDirectPaletteRef; color: CGDeviceColor; index: CGTableCount); C;

{
 * Copy a palette
 }
{
 *  CGPaletteCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteCreateCopy(palette: CGDirectPaletteRef): CGDirectPaletteRef; C;

{
 * Compare two palettes
 }
{
 *  CGPaletteIsEqualToPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteIsEqualToPalette(palette1: CGDirectPaletteRef; palette2: CGDirectPaletteRef): BOOLEAN; C;

{
 * Create a new palette blended with a fraction of a device color.
 * Free the resulting palette with CGPaletteRelease()
 }
{
 *  CGPaletteCreateFromPaletteBlendedWithColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPaletteCreateFromPaletteBlendedWithColor(palette: CGDirectPaletteRef; fraction: CGPaletteBlendFraction; color: CGDeviceColor): CGDirectPaletteRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGDirectPaletteIncludes}

{$ENDC} {__CGDIRECTPALETTE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
