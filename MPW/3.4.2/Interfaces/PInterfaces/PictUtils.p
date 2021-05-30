{
 	File:		PictUtils.p
 
 	Contains:	Picture Utilities Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PictUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PICTUTILS__}
{$SETC __PICTUTILS__ := 1}

{$I+}
{$SETC PictUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Memory.p													}
{		MixedMode.p												}
{	Quickdraw.p													}
{		QuickdrawText.p											}
{	Events.p													}
{		OSUtils.p												}
{	Controls.p													}
{		Menus.p													}

{$IFC UNDEFINED __PALETTES__}
{$I Palettes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	returnColorTable			= $0001;
	returnPalette				= $0002;
	recordComments				= $0004;
	recordFontInfo				= $0008;
	suppressBlackAndWhite		= $0010;

{ color pick methods }
	systemMethod				= 0;							{ system color pick method }
	popularMethod				= 1;							{ method that chooses the most popular set of colors }
	medianMethod				= 2;							{ method that chooses a good average mix of colors }
{ color bank types }
	ColorBankIsCustom			= -1;
	ColorBankIsExactAnd555		= 0;
	ColorBankIs555				= 1;

	
TYPE
	PictInfoID = LONGINT;

	CommentSpec = RECORD
		count:					INTEGER;								{ number of occurrances of this comment ID }
		ID:						INTEGER;								{ ID for the comment in the picture }
	END;

	CommentSpecPtr = ^CommentSpec;
	CommentSpecHandle = ^CommentSpecPtr;

	FontSpec = RECORD
		pictFontID:				INTEGER;								{ ID of the font in the picture }
		sysFontID:				INTEGER;								{ ID of the same font in the current system file }
		size:					ARRAY [0..3] OF LONGINT;				{ bit array of all the sizes found (1..127) (bit 0 means > 127) }
		style:					INTEGER;								{ combined style of all occurrances of the font }
		nameOffset:				LONGINT;								{ offset into the fontNamesHdl handle for the font’s name }
	END;

	FontSpecPtr = ^FontSpec;
	FontSpecHandle = ^FontSpecPtr;

	PictInfo = RECORD
		version:				INTEGER;								{ this is always zero, for now }
		uniqueColors:			LONGINT;								{ the number of actual colors in the picture(s)/pixmap(s) }
		thePalette:				PaletteHandle;							{ handle to the palette information }
		theColorTable:			CTabHandle;								{ handle to the color table }
		hRes:					Fixed;									{ maximum horizontal resolution for all the pixmaps }
		vRes:					Fixed;									{ maximum vertical resolution for all the pixmaps }
		depth:					INTEGER;								{ maximum depth for all the pixmaps (in the picture) }
		sourceRect:				Rect;									{ the picture frame rectangle (this contains the entire picture) }
		textCount:				LONGINT;								{ total number of text strings in the picture }
		lineCount:				LONGINT;								{ total number of lines in the picture }
		rectCount:				LONGINT;								{ total number of rectangles in the picture }
		rRectCount:				LONGINT;								{ total number of round rectangles in the picture }
		ovalCount:				LONGINT;								{ total number of ovals in the picture }
		arcCount:				LONGINT;								{ total number of arcs in the picture }
		polyCount:				LONGINT;								{ total number of polygons in the picture }
		regionCount:			LONGINT;								{ total number of regions in the picture }
		bitMapCount:			LONGINT;								{ total number of bitmaps in the picture }
		pixMapCount:			LONGINT;								{ total number of pixmaps in the picture }
		commentCount:			LONGINT;								{ total number of comments in the picture }
		uniqueComments:			LONGINT;								{ the number of unique comments in the picture }
		commentHandle:			CommentSpecHandle;						{ handle to all the comment information }
		uniqueFonts:			LONGINT;								{ the number of unique fonts in the picture }
		fontHandle:				FontSpecHandle;							{ handle to the FontSpec information }
		fontNamesHandle:		Handle;									{ handle to the font names }
		reserved1:				LONGINT;
		reserved2:				LONGINT;
	END;

	PictInfoPtr = ^PictInfo;
	PictInfoHandle = ^PictInfoPtr;


FUNCTION GetPictInfo(thePictHandle: PicHandle; VAR thePictInfo: PictInfo; verb: INTEGER; colorsRequested: INTEGER; colorPickMethod: INTEGER; version: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0800, $A831;
	{$ENDC}
FUNCTION GetPixMapInfo(thePixMapHandle: PixMapHandle; VAR thePictInfo: PictInfo; verb: INTEGER; colorsRequested: INTEGER; colorPickMethod: INTEGER; version: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0801, $A831;
	{$ENDC}
FUNCTION NewPictInfo(VAR thePictInfoID: PictInfoID; verb: INTEGER; colorsRequested: INTEGER; colorPickMethod: INTEGER; version: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0602, $A831;
	{$ENDC}
FUNCTION RecordPictInfo(thePictInfoID: PictInfoID; thePictHandle: PicHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0403, $A831;
	{$ENDC}
FUNCTION RecordPixMapInfo(thePictInfoID: PictInfoID; thePixMapHandle: PixMapHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0404, $A831;
	{$ENDC}
FUNCTION RetrievePictInfo(thePictInfoID: PictInfoID; VAR thePictInfo: PictInfo; colorsRequested: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0505, $A831;
	{$ENDC}
FUNCTION DisposePictInfo(thePictInfoID: PictInfoID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0206, $A831;
	{$ENDC}
{$IFC OLDROUTINENAMES }
FUNCTION DisposPictInfo(thePictInfoID: PictInfoID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0206, $A831;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PictUtilsIncludes}

{$ENDC} {__PICTUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
