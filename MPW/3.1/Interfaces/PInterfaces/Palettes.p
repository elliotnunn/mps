{
Created: Saturday, September 16, 1989 at 4:19 PM
	Palettes.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1987-1989
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT Palettes;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPalettes}
{$SETC UsingPalettes := 1}

{$I+}
{$SETC PalettesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingQuickdraw}
{$I $$Shell(PInterfaces)Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED UsingWindows}
{$I $$Shell(PInterfaces)Windows.p}
{$ENDC}
{$SETC UsingIncludes := PalettesIncludes}

CONST
pmCourteous = 0;							{Record use of color on each device touched.}
pmTolerant = 2; 							{render ciRGB if ciTolerance is exceeded by best match.}
pmAnimated = 4; 							{reserve an index on each device touched and render ciRGB.}
pmExplicit = 8; 							{no reserve, no render, no record; stuff index into port.}
pmInhibitG2 = 256;
pmInhibitC2 = 512;
pmInhibitG4 = 1024;
pmInhibitC4 = 2048;
pmInhibitG8 = 4096;
pmInhibitC8 = 8192;

{ NSetPalette Update Constants }

pmNoUpdates = $8000;						{no updates}
pmBkUpdates = $A000;						{background updates only}
pmFgUpdates = $C000;						{foreground updates only}
pmAllUpdates = $E000;						{all updates}


TYPE

ColorInfo = RECORD
	ciRGB: RGBColor;						{true RGB values}
	ciUsage: INTEGER;						{color usage}
	ciTolerance: INTEGER;					{tolerance value}
	ciDataFields: ARRAY [0..2] OF INTEGER;	{private fields}
	END;

PalettePtr = ^Palette;
PaletteHandle = ^PalettePtr;
Palette = RECORD
	pmEntries: INTEGER; 					{entries in pmTable}
	pmDataFields: ARRAY [0..6] OF INTEGER;	{private fields}
	pmInfo: ARRAY [0..0] OF ColorInfo;
	END;



PROCEDURE InitPalettes;
	INLINE $AA90;
FUNCTION NewPalette(entries: INTEGER;srcColors: CTabHandle;srcUsage: INTEGER;
	srcTolerance: INTEGER): PaletteHandle;
	INLINE $AA91;
FUNCTION GetNewPalette(PaletteID: INTEGER): PaletteHandle;
	INLINE $AA92;
PROCEDURE DisposePalette(srcPalette: PaletteHandle);
	INLINE $AA93;
PROCEDURE ActivatePalette(srcWindow: WindowPtr);
	INLINE $AA94;
PROCEDURE SetPalette(dstWindow: WindowPtr;srcPalette: PaletteHandle;cUpdates: BOOLEAN);
	INLINE $AA95;
PROCEDURE NSetPalette(dstWindow: WindowPtr;srcPalette: PaletteHandle;nCUpdates: INTEGER);
	INLINE $AA95;
FUNCTION GetPalette(srcWindow: WindowPtr): PaletteHandle;
	INLINE $AA96;
PROCEDURE CopyPalette(srcPalette: PaletteHandle;dstPalette: PaletteHandle;
	srcEntry: INTEGER;dstEntry: INTEGER;dstLength: INTEGER);
	INLINE $AAA1;
PROCEDURE PmForeColor(dstEntry: INTEGER);
	INLINE $AA97;
PROCEDURE PmBackColor(dstEntry: INTEGER);
	INLINE $AA98;
PROCEDURE AnimateEntry(dstWindow: WindowPtr;dstEntry: INTEGER;srcRGB: RGBColor);
	INLINE $AA99;
PROCEDURE AnimatePalette(dstWindow: WindowPtr;srcCTab: CTabHandle;srcIndex: INTEGER;
	dstEntry: INTEGER;dstLength: INTEGER);
	INLINE $AA9A;
PROCEDURE GetEntryColor(srcPalette: PaletteHandle;srcEntry: INTEGER;VAR dstRGB: RGBColor);
	INLINE $AA9B;
PROCEDURE SetEntryColor(dstPalette: PaletteHandle;dstEntry: INTEGER;srcRGB: RGBColor);
	INLINE $AA9C;
PROCEDURE GetEntryUsage(srcPalette: PaletteHandle;srcEntry: INTEGER;VAR dstUsage: INTEGER;
	VAR dstTolerance: INTEGER);
	INLINE $AA9D;
PROCEDURE SetEntryUsage(dstPalette: PaletteHandle;dstEntry: INTEGER;srcUsage: INTEGER;
	srcTolerance: INTEGER);
	INLINE $AA9E;
PROCEDURE CTab2Palette(srcCTab: CTabHandle;dstPalette: PaletteHandle;srcUsage: INTEGER;
	srcTolerance: INTEGER);
	INLINE $AA9F;
PROCEDURE Palette2CTab(srcPalette: PaletteHandle;dstCTab: CTabHandle);
	INLINE $AAA0;
FUNCTION Entry2Index(srcEntry: INTEGER): LONGINT;
	INLINE $7000,$AAA2;
PROCEDURE RestoreDeviceClut(gdh: GDHandle);
	INLINE $7002,$AAA2;
PROCEDURE ResizePalette(srcPalette: PaletteHandle;dstSize: INTEGER);
	INLINE $7003,$AAA2;

{$ENDC}    { UsingPalettes }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

