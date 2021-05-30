{
     File:       CGWindowLevel.p
 
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
 UNIT CGWindowLevel;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGWINDOWLEVEL__}
{$SETC __CGWINDOWLEVEL__ := 1}

{$I+}
{$SETC CGWindowLevelIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 * Windows may be assigned to a particular level. When assigned to a level,
 * the window is ordered relative to all other windows in that level.
 * Windows with a higher level are sorted in front of windows with a lower
 * level.
 *
 * A common set of window levels is defined here for use within higher
 * level frameworks.  The levels are accessed via a key and function,
 * so that levels may be changed or adjusted in future releases without
 * breaking binary compatability.
 }

TYPE
	CGWindowLevel						= int32_t;
	CGWindowLevelKey					= int32_t;
	_CGCommonWindowLevelKey 	= SInt32;
CONST
	kCGBaseWindowLevelKey		= 0;
	kCGMinimumWindowLevelKey	= 1;
	kCGDesktopWindowLevelKey	= 2;
	kCGBackstopMenuLevelKey		= 3;
	kCGNormalWindowLevelKey		= 4;
	kCGFloatingWindowLevelKey	= 5;
	kCGTornOffMenuWindowLevelKey = 6;
	kCGDockWindowLevelKey		= 7;
	kCGMainMenuWindowLevelKey	= 8;
	kCGStatusWindowLevelKey		= 9;
	kCGModalPanelWindowLevelKey	= 10;
	kCGPopUpMenuWindowLevelKey	= 11;
	kCGDraggingWindowLevelKey	= 12;
	kCGScreenSaverWindowLevelKey = 13;
	kCGMaximumWindowLevelKey	= 14;
	kCGNumberOfWindowLevelKeys	= 15;							{  Internal bookkeeping; must be last  }

	{
	 *  CGWindowLevelForKey()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGWindowLevelForKey(key: CGWindowLevelKey): CGWindowLevel; C;

{ number of levels above kCGMaximumWindowLevel reserved for internal use }

CONST
	kCGNumReservedWindowLevels	= 16;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGWindowLevelIncludes}

{$ENDC} {__CGWINDOWLEVEL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
