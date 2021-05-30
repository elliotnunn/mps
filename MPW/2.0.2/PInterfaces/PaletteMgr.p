{
  File: PaletteMgr.p

  Copyright Apple Computer, Inc.  1987
  All Rights Reserved
}

UNIT PaletteMgr;

INTERFACE

USES { $U MemTypes.p } MemTypes;

CONST
	{ Usage constants }
	pmCourteous = $0000;	{ record use of color on each device touched }
	pmTolerant = $0002;	{ render ciRGB if ciTolerance is exceeded by best match}
	pmAnimated = $0004;	{ reserve an index on each device touched and render ciRGB }
	pmExplicit = $0008;	{ no reserve, no render, no record; stuff index into port }

	{ CUpdates constants }
	pmAllCUpdates = $C000;
	pmBackCUpdates = $8000;
	pmFrontCUpdates = $4000;
	
TYPE  ColorInfo = RECORD
		ciRGB: RGBColor;	{ true RGB values }
		ciUsage: INTEGER;	{ color usage }
		ciTolerance: INTEGER; { tolerance value }
		ciFlags: INTEGER;	{ private }
		ciPrivate : LONGINT;  { private }
	END;

	PaletteHandle = ^PalettePtr;
	PalettePtr = ^Palette;
	Palette = RECORD
		pmEntries : INTEGER;	{ entries in pmTable }
		pmWindow : WindowPtr;	{ parent window }
		pmPrivate : INTEGER;	{ private }
		pmDevices : LONGINT;	{ private }
		pmSeeds : LONGINT;		{ private }
		pmInfo : ARRAY [0..0] OF ColorInfo;
	END;

PROCEDURE InitPalettes;
	INLINE $AA90;
FUNCTION  NewPalette(entries: INTEGER; srcColors: CTabHandle; srcUsage,
			srcTolerance: INTEGER) : PaletteHandle;
	INLINE $AA91;
FUNCTION  GetNewPalette(paletteID: INTEGER) : PaletteHandle;
	INLINE $AA92;
PROCEDURE DisposePalette(srcPalette: PaletteHandle);
	INLINE $AA93;
PROCEDURE ActivatePalette(srcWindow: WindowPtr);
	INLINE $AA94;
PROCEDURE SetPalette(dstWindow: WindowPtr; srcPalette: PaletteHandle;
			cUpdates: BOOLEAN);
	INLINE $AA95;
FUNCTION  GetPalette(srcWindow: WindowPtr) : PaletteHandle;
	INLINE $AA96;
PROCEDURE PmForeColor(dstEntry: INTEGER);
	INLINE $AA97;
PROCEDURE PmBackColor(dstEntry: INTEGER);
	INLINE $AA98;
PROCEDURE AnimateEntry(dstWindow: WindowPtr; dstEntry: INTEGER; srcRGB: RGBColor);
	INLINE $AA99;
PROCEDURE AnimatePalette(dstWindow: WindowPtr; srcCTab: CTabHandle;
			srcIndex,dstEntry,dstLength: INTEGER);
	INLINE $AA9A;
PROCEDURE GetEntryColor(srcPalette: PaletteHandle; srcEntry: INTEGER;
			VAR dstRGB: RGBColor);
	INLINE $AA9B;
PROCEDURE SetEntryColor(dstPalette: PaletteHandle; dstEntry: INTEGER;
			srcRGB: RGBColor);
	INLINE $AA9C;
PROCEDURE GetEntryUsage(srcPalette: PaletteHandle; srcEntry: INTEGER;
			VAR dstUsage, dstTolerance: INTEGER);
	INLINE $AA9D;
PROCEDURE SetEntryUsage(dstPalette: PaletteHandle; dstEntry,srcUsage,
			srcTolerance: INTEGER);
	INLINE $AA9E;
PROCEDURE CTab2Palette(srcCTab: CTabHandle; dstPalette: PaletteHandle;
			myUsage, myTolerance: INTEGER);
	INLINE $AA9F;
PROCEDURE Palette2CTab(srcPalette: PaletteHandle; dstCTab: CTabHandle);
	INLINE $AAA0;

END.
