{
     File:       Palettes.p
 
     Contains:   Palette Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Palettes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PALETTES__}
{$SETC __PALETTES__ := 1}

{$I+}
{$SETC PalettesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	pmCourteous					= 0;							{ Record use of color on each device touched. }
	pmDithered					= $0001;
	pmTolerant					= $0002;						{ render ciRGB if ciTolerance is exceeded by best match. }
	pmAnimated					= $0004;						{ reserve an index on each device touched and render ciRGB. }
	pmExplicit					= $0008;						{ no reserve, no render, no record; stuff index into port. }
	pmWhite						= $0010;
	pmBlack						= $0020;
	pmInhibitG2					= $0100;
	pmInhibitC2					= $0200;
	pmInhibitG4					= $0400;
	pmInhibitC4					= $0800;
	pmInhibitG8					= $1000;
	pmInhibitC8					= $2000;						{  NSetPalette Update Constants  }
	pmNoUpdates					= $8000;						{ no updates }
	pmBkUpdates					= $A000;						{ background updates only }
	pmFgUpdates					= $C000;						{ foreground updates only }
	pmAllUpdates				= $E000;						{ all updates }


TYPE
	ColorInfoPtr = ^ColorInfo;
	ColorInfo = RECORD
		ciRGB:					RGBColor;								{ true RGB values }
		ciUsage:				INTEGER;								{ color usage }
		ciTolerance:			INTEGER;								{ tolerance value }
		ciDataFields:			ARRAY [0..2] OF INTEGER;				{ private fields }
	END;

	ColorInfoHandle						= ^ColorInfoPtr;
	PalettePtr = ^Palette;
	Palette = RECORD
		pmEntries:				INTEGER;								{ entries in pmTable }
		pmDataFields:			ARRAY [0..6] OF INTEGER;				{ private fields }
		pmInfo:					ARRAY [0..0] OF ColorInfo;
	END;

	PaletteHandle						= ^PalettePtr;
	{
	 *  InitPalettes()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE InitPalettes;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA90;
	{$ENDC}

{
 *  NewPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPalette(entries: INTEGER; srcColors: CTabHandle; srcUsage: INTEGER; srcTolerance: INTEGER): PaletteHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA91;
	{$ENDC}

{
 *  GetNewPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNewPalette(PaletteID: INTEGER): PaletteHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA92;
	{$ENDC}

{
 *  DisposePalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePalette(srcPalette: PaletteHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA93;
	{$ENDC}

{
 *  ActivatePalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ActivatePalette(srcWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA94;
	{$ENDC}

{
 *  SetPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPalette(dstWindow: WindowRef; srcPalette: PaletteHandle; cUpdates: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA95;
	{$ENDC}

{
 *  NSetPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE NSetPalette(dstWindow: WindowRef; srcPalette: PaletteHandle; nCUpdates: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA95;
	{$ENDC}

{
 *  GetPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPalette(srcWindow: WindowRef): PaletteHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA96;
	{$ENDC}

{
 *  CopyPalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyPalette(srcPalette: PaletteHandle; dstPalette: PaletteHandle; srcEntry: INTEGER; dstEntry: INTEGER; dstLength: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AAA1;
	{$ENDC}

{
 *  PmForeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PmForeColor(dstEntry: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA97;
	{$ENDC}

{
 *  PmBackColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PmBackColor(dstEntry: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA98;
	{$ENDC}

{
 *  AnimateEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AnimateEntry(dstWindow: WindowRef; dstEntry: INTEGER; {CONST}VAR srcRGB: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA99;
	{$ENDC}

{
 *  [Mac]AnimatePalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AnimatePalette(dstWindow: WindowRef; srcCTab: CTabHandle; srcIndex: INTEGER; dstEntry: INTEGER; dstLength: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9A;
	{$ENDC}

{
 *  GetEntryColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetEntryColor(srcPalette: PaletteHandle; srcEntry: INTEGER; VAR dstRGB: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9B;
	{$ENDC}

{
 *  SetEntryColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetEntryColor(dstPalette: PaletteHandle; dstEntry: INTEGER; {CONST}VAR srcRGB: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9C;
	{$ENDC}

{
 *  GetEntryUsage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetEntryUsage(srcPalette: PaletteHandle; srcEntry: INTEGER; VAR dstUsage: INTEGER; VAR dstTolerance: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9D;
	{$ENDC}

{
 *  SetEntryUsage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetEntryUsage(dstPalette: PaletteHandle; dstEntry: INTEGER; srcUsage: INTEGER; srcTolerance: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9E;
	{$ENDC}

{
 *  CTab2Palette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CTab2Palette(srcCTab: CTabHandle; dstPalette: PaletteHandle; srcUsage: INTEGER; srcTolerance: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA9F;
	{$ENDC}

{
 *  Palette2CTab()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Palette2CTab(srcPalette: PaletteHandle; dstCTab: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AAA0;
	{$ENDC}

{
 *  Entry2Index()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION Entry2Index(entry: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AAA2;
	{$ENDC}

{
 *  RestoreDeviceClut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RestoreDeviceClut(gd: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AAA2;
	{$ENDC}

{
 *  [Mac]ResizePalette()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ResizePalette(p: PaletteHandle; size: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AAA2;
	{$ENDC}

{
 *  SaveFore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SaveFore(VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $AAA2;
	{$ENDC}

{
 *  SaveBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SaveBack(VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040E, $AAA2;
	{$ENDC}

{
 *  RestoreFore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RestoreFore({CONST}VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $AAA2;
	{$ENDC}

{
 *  RestoreBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RestoreBack({CONST}VAR c: ColorSpec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0410, $AAA2;
	{$ENDC}

{
 *  SetDepth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDepth(gd: GDHandle; depth: INTEGER; whichFlags: INTEGER; flags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A13, $AAA2;
	{$ENDC}

{
 *  HasDepth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HasDepth(gd: GDHandle; depth: INTEGER; whichFlags: INTEGER; flags: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A14, $AAA2;
	{$ENDC}

{
 *  PMgrVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMgrVersion: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AAA2;
	{$ENDC}

{
 *  SetPaletteUpdates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPaletteUpdates(p: PaletteHandle; updates: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0616, $AAA2;
	{$ENDC}

{
 *  GetPaletteUpdates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPaletteUpdates(p: PaletteHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0417, $AAA2;
	{$ENDC}

{
 *  GetGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetGray(device: GDHandle; {CONST}VAR backGround: RGBColor; VAR foreGround: RGBColor): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C19, $AAA2;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PalettesIncludes}

{$ENDC} {__PALETTES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
