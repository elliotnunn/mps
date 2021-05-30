{
     File:       CGDirectDisplay.p
 
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
 UNIT CGDirectDisplay;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGDIRECTDISPLAY__}
{$SETC __CGDIRECTDISPLAY__ := 1}

{$I+}
{$SETC CGDirectDisplayIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGGEOMETRY__}
{$I CGGeometry.p}
{$ENDC}
{$IFC UNDEFINED __CGERROR__}
{$I CGError.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGDirectDisplayID    = ^LONGINT; { an opaque 32-bit type }
	CGDirectDisplayIDPtr = ^CGDirectDisplayID;  { when a VAR xx:CGDirectDisplayID parameter can be nil, it is changed to xx: CGDirectDisplayIDPtr }
	CGDirectPaletteRef    = ^LONGINT; { an opaque 32-bit type }
	CGDirectPaletteRefPtr = ^CGDirectPaletteRef;  { when a VAR xx:CGDirectPaletteRef parameter can be nil, it is changed to xx: CGDirectPaletteRefPtr }
	CGDisplayCount						= u_int32_t;
	CGTableCount						= u_int32_t;
	CGDisplayCoord						= int32_t;
	CGByteValue							= u_int8_t;
	CGOpenGLDisplayMask					= u_int32_t;
	CGBeamPosition						= u_int32_t;
	CGMouseDelta						= int32_t;
	CGRefreshRate						= Double;
	CGDisplayErr						= CGError;

CONST
	CGDisplayNoErr				= 0;

	{	 A NULL value points to the main display device as a programming convention 	}
{$IFC NOT UNDEFINED MWERKS}
	kCGDirectMainDisplay		= nil;
{$ENDC}

	{	
	 * Mechanisms used to find screen IDs
	 * An array length (maxDisplays) and array of CGDirectDisplayIDs are passed in.
	 * Up to maxDisplays of the array are filled in with the displays meeting the
	 * specified criteria.  The actual number of displays filled in is returned in
	 * dspyCnt.
	 *
	 * If the dspys array is NULL, maxDisplays is ignored, and *dspyCnt is filled
	 * in with the number of displays meeting the function's requirements.
	 	}
	{
	 *  CGGetDisplaysWithPoint()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGGetDisplaysWithPoint(point: CGPoint; maxDisplays: CGDisplayCount; VAR dspys: CGDirectDisplayID; VAR dspyCnt: CGDisplayCount): CGDisplayErr; C;

{
 *  CGGetDisplaysWithRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGGetDisplaysWithRect(rect: CGRect; maxDisplays: CGDisplayCount; VAR dspys: CGDirectDisplayID; VAR dspyCnt: CGDisplayCount): CGDisplayErr; C;

{
 *  CGGetDisplaysWithOpenGLDisplayMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGGetDisplaysWithOpenGLDisplayMask(mask: CGOpenGLDisplayMask; maxDisplays: CGDisplayCount; VAR dspys: CGDirectDisplayID; VAR dspyCnt: CGDisplayCount): CGDisplayErr; C;

{
 * Get lists of displays.  Use this to determine display IDs
 *
 * If the activeDspys array is NULL, maxDisplays is ignored, and *dspyCnt is filled
 * in with the number of displays meeting the function's requirements.
 *
 * The first display returned in the list is the main display,
 * the one with the menu bar.
 * When mirroring, this will be the largest display,
 * or if all are the same size, the one with the deepest pixel depth.
 }
{
 *  CGGetActiveDisplayList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGGetActiveDisplayList(maxDisplays: CGDisplayCount; VAR activeDspys: CGDirectDisplayID; VAR dspyCnt: CGDisplayCount): CGDisplayErr; C;

{ Map a display to an OpenGL display mask; returns 0 on invalid display }
{
 *  CGDisplayIDToOpenGLDisplayMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayIDToOpenGLDisplayMask(display: CGDirectDisplayID): CGOpenGLDisplayMask; C;

{ Return screen size and origin in global coords; Empty rect if display is invalid }
{
 *  CGDisplayBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBounds(display: CGDirectDisplayID): CGRect; C;

{
 *  CGDisplayPixelsWide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayPixelsWide(display: CGDirectDisplayID): size_t; C;

{
 *  CGDisplayPixelsHigh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayPixelsHigh(display: CGDirectDisplayID): size_t; C;

{
 * Display mode selection
 * Display modes are represented as CFDictionaries
 * All dictionaries and arrays returned via these mechanisms are
 * owned by the framework and should not be released.  The framework
 * will not release them out from under your application.
 *
 * Values associated with the following keys are CFNumber types.
 * With CFNumberGetValue(), use kCFNumberLongType for best results.
 }
{
 * Keys used in mode dictionaries.  Source C strings shown won't change.
 * Some CFM environments cannot import data variables, and so
 * duplicate these CFStringRefs locally.
 }
{
 *  kCGDisplayWidth
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayHeight
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayMode
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayBitsPerPixel
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayBitsPerSample
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplaySamplesPerPixel
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayRefreshRate
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayModeUsableForDesktopGUI
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCGDisplayIOFlags
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
{
 * Return a CFArray of CFDictionaries describing all display modes.
 * Returns NULL if the display is invalid.
 }
{
 *  CGDisplayAvailableModes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayAvailableModes(display: CGDirectDisplayID): CFArrayRef; C;

{
 * Try to find a display mode of specified depth with dimensions equal or greater than
 * specified.
 * If no depth match is found, try for the next larger depth with dimensions equal or greater
 * than specified.  If no luck, then just return the current mode.
 *
 * exactmatch, if not NULL, is set to 'true' if an exact match in width, height, and depth is found,
 * and 'false' otherwise.
 * Returns NULL if display is invalid.
 }
{
 *  CGDisplayBestModeForParameters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBestModeForParameters(display: CGDirectDisplayID; bitsPerPixel: size_t; width: size_t; height: size_t; VAR exactMatch: boolean_t): CFDictionaryRef; C;

{
 *  CGDisplayBestModeForParametersAndRefreshRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBestModeForParametersAndRefreshRate(display: CGDirectDisplayID; bitsPerPixel: size_t; width: size_t; height: size_t; refresh: CGRefreshRate; VAR exactMatch: boolean_t): CFDictionaryRef; C;

{
 * Return a CFDictionary describing the current display mode.
 * Returns NULL if display is invalid.
 }
{
 *  CGDisplayCurrentMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayCurrentMode(display: CGDirectDisplayID): CFDictionaryRef; C;

{
 * Switch display mode.  Note that after switching, 
 * display parameters and addresses may change.
 * The selected display mode persists for the life of the program, and automatically
 * reverts to the permanent setting made by Preferences when the program terminates.
 * The mode dictionary passed in must be a dictionary vended by other CGDirectDisplay
 * APIs such as CGDisplayBestModeForParameters() and CGDisplayAvailableModes().
 }
{
 *  CGDisplaySwitchToMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplaySwitchToMode(display: CGDirectDisplayID; mode: CFDictionaryRef): CGDisplayErr; C;

{ Query parameters for current mode }
{
 *  CGDisplayBitsPerPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBitsPerPixel(display: CGDirectDisplayID): size_t; C;

{
 *  CGDisplayBitsPerSample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBitsPerSample(display: CGDirectDisplayID): size_t; C;

{
 *  CGDisplaySamplesPerPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplaySamplesPerPixel(display: CGDirectDisplayID): size_t; C;

{
 *  CGDisplayBytesPerRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBytesPerRow(display: CGDirectDisplayID): size_t; C;

{
 * Set a display gamma/transfer function from a formula specifying
 * min and max values and a gamma for each channel.
 * Gamma values must be greater than 0.0.
 * To get an antigamma of 1.6, one would specify a value of (1.0 / 1.6)
 * Min values must be greater than or equal to 0.0 and less than 1.0.
 * Max values must be greater than 0.0 and less than or equal to 1.0.
 * Out of range values, or Max greater than or equal to Min result
 * in a kCGSRangeCheck error.
 *
 * Values are computed by sampling a function for a range of indices from 0 through 1:
 *  value = Min + ((Max - Min) * pow(index, Gamma))
 * The resulting values are converted to a machine specific format
 * and loaded into hardware.
 }

TYPE
	CGGammaValue						= Single;
	{
	 *  CGSetDisplayTransferByFormula()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGSetDisplayTransferByFormula(display: CGDirectDisplayID; redMin: CGGammaValue; redMax: CGGammaValue; redGamma: CGGammaValue; greenMin: CGGammaValue; greenMax: CGGammaValue; greenGamma: CGGammaValue; blueMin: CGGammaValue; blueMax: CGGammaValue; blueGamma: CGGammaValue): CGDisplayErr; C;

{
 *  CGGetDisplayTransferByFormula()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGGetDisplayTransferByFormula(display: CGDirectDisplayID; VAR redMin: CGGammaValue; VAR redMax: CGGammaValue; VAR redGamma: CGGammaValue; VAR greenMin: CGGammaValue; VAR greenMax: CGGammaValue; VAR greenGamma: CGGammaValue; VAR blueMin: CGGammaValue; VAR blueMax: CGGammaValue; VAR blueGamma: CGGammaValue): CGDisplayErr; C;

{
 * Set a display gamma/transfer function using tables of data for each channel.
 * Values within each table should have values in the range of 0.0 through 1.0.
 * The same table may be passed in for red, green, and blue channels. 'tableSize'
 * indicates the number of entries in each table.
 * The tables are interpolated as needed to generate the number of samples needed
 * by hardware.
 }
{
 *  CGSetDisplayTransferByTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGSetDisplayTransferByTable(display: CGDirectDisplayID; tableSize: CGTableCount; {CONST}VAR redTable: CGGammaValue; {CONST}VAR greenTable: CGGammaValue; {CONST}VAR blueTable: CGGammaValue): CGDisplayErr; C;

{
 * Get transfer tables.  Capacity should contain the number of samples each
 * array can hold, and *sampleCount is filled in with the number of samples
 * actually copied in.
 }
{
 *  CGGetDisplayTransferByTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGGetDisplayTransferByTable(display: CGDirectDisplayID; capacity: CGTableCount; VAR redTable: CGGammaValue; VAR greenTable: CGGammaValue; VAR blueTable: CGGammaValue; VAR sampleCount: CGTableCount): CGDisplayErr; C;

{ As a convenience, allow setting of the gamma table by byte values }
{
 *  CGSetDisplayTransferByByteTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGSetDisplayTransferByByteTable(display: CGDirectDisplayID; tableSize: CGTableCount; {CONST}VAR redTable: CGByteValue; {CONST}VAR greenTable: CGByteValue; {CONST}VAR blueTable: CGByteValue): CGDisplayErr; C;

{ Restore gamma tables of system displays to the user's ColorSync specified values }
{
 *  CGDisplayRestoreColorSyncSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGDisplayRestoreColorSyncSettings; C;

{ Display capture and release }
{
 *  CGDisplayIsCaptured()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayIsCaptured(display: CGDirectDisplayID): boolean_t; C;

{
 *  CGDisplayCapture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayCapture(display: CGDirectDisplayID): CGDisplayErr; C;

{
 *  CGDisplayRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayRelease(display: CGDirectDisplayID): CGDisplayErr; C;


{
 * Capture all displays; this has the nice effect of providing an immersive
 * environment, and preventing other apps from trying to adjust themselves
 * to display changes only needed by your app.
 }
{
 *  CGCaptureAllDisplays()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGCaptureAllDisplays: CGDisplayErr; C;

{
 * Release all captured displays, and restore the display modes to the
 * user's preferences.  May be used in conjunction with CGDisplayCapture()
 * or CGCaptureAllDisplays().
 }
{
 *  CGReleaseAllDisplays()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGReleaseAllDisplays: CGDisplayErr; C;


{
 * Returns CoreGraphics raw shield window ID or NULL if not shielded
 * This value may be used with drawing surface APIs.
 }
{
 *  CGShieldingWindowID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGShieldingWindowID(display: CGDirectDisplayID): Ptr; C;

{
 * Returns the window level used for the shield window.
 * This value may be used with Cocoa windows to position the
 * Cocoa window in the same window level as the shield window.
 }
{
 *  CGShieldingWindowLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGShieldingWindowLevel: int32_t; C;

{
 * Returns base address of display or NULL for an invalid display.
 * If the display has not been captured, the returned address may refer
 * to read-only memory.
 }
{
 *  CGDisplayBaseAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBaseAddress(display: CGDirectDisplayID): Ptr; C;

{
 * return address for X,Y in screen coordinates;
 *  (0,0) represents the upper left corner of the display.
 * returns NULL for an invalid display or out of bounds coordinates
 * If the display has not been captured, the returned address may refer
 * to read-only memory.
 }
{
 *  CGDisplayAddressForPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayAddressForPosition(display: CGDirectDisplayID; x: CGDisplayCoord; y: CGDisplayCoord): Ptr; C;


{ Mouse Cursor controls }
{
 *  CGDisplayHideCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayHideCursor(display: CGDirectDisplayID): CGDisplayErr; C;

{ increments hide cursor count }
{
 *  CGDisplayShowCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayShowCursor(display: CGDirectDisplayID): CGDisplayErr; C;

{ decrements hide cursor count  }
{
 * Move the cursor to the specified point relative to the display origin
 * (the upper left corner of the display).  Returns CGDisplayNoErr on success.
 * No events are generated as a result of this move.
 * Points that would lie outside the desktop are clipped to the desktop.
 }
{
 *  CGDisplayMoveCursorToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayMoveCursorToPoint(display: CGDirectDisplayID; point: CGPoint): CGDisplayErr; C;

{
 * Report the mouse position change associated with the last mouse move event
 * recieved by this application.
 }
{
 *  CGGetLastMouseDelta()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGGetLastMouseDelta(VAR deltaX: CGMouseDelta; VAR deltaY: CGMouseDelta); C;


{ Palette controls (8 bit pseudocolor only) }
{
 * Returns TRUE if the current display mode supports palettes
 }
{
 *  CGDisplayCanSetPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayCanSetPalette(display: CGDirectDisplayID): boolean_t; C;

{
 * Set a palette.  The current gamma function is applied to the palette
 * elements before being loaded into hardware.
 }
{
 *  CGDisplaySetPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplaySetPalette(display: CGDirectDisplayID; palette: CGDirectPaletteRef): CGDisplayErr; C;

{
 * Wait until the beam position is outside the range specified by upperScanLine and lowerScanLine.
 * Note that if upperScanLine and lowerScanLine encompass the entire display height,
 * the function returns an error.
 * lowerScanLine must be greater than or equal to upperScanLine.
 *
 * Some display systems may not conventional video vertical and horizontal sweep in painting.
 * These displays report a kCGDisplayRefreshRate of 0 in the CFDictionaryRef returned by
 * CGDisplayCurrentMode().  On such displays, this function returns at once.
 *
 * Some drivers may not implement support for this mechanism.
 * On such displays, this function returns at once.
 *
 * Returns CGDisplayNoErr on success, and an error if display or upperScanLine and
 * lowerScanLine are invalid.
 *
 * The app should set the values of upperScanLine and lowerScanLine to allow enough lead time
 * for the drawing operation to complete.  A common strategy is to wait for the beam to pass
 * the bottom of the drawing area, allowing almost a full vertical sweep period to perform drawing.
 * To do this, set upperScanLine to 0, and set lowerScanLine to the bottom of the bounding box:
 *  lowerScanLine = (CGBeamPosition)(cgrect.origin.y + cgrect.size.height);
 }
{
 *  CGDisplayWaitForBeamPositionOutsideLines()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayWaitForBeamPositionOutsideLines(display: CGDirectDisplayID; upperScanLine: CGBeamPosition; lowerScanLine: CGBeamPosition): CGDisplayErr; C;

{
 * Returns the current beam position on the display.  If display is invalid,
 * or the display does not implement conventional video vertical and horizontal
 * sweep in painting, or the driver does not implement this functionality, 0 is returned.
 }
{
 *  CGDisplayBeamPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGDisplayBeamPosition(display: CGDirectDisplayID): CGBeamPosition; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGDirectDisplayIncludes}

{$ENDC} {__CGDIRECTDISPLAY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
