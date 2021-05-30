{
     File:       PictUtils.p
 
     Contains:   Picture Utilities Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __PALETTES__}
{$I Palettes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ verbs for the GetPictInfo, GetPixMapInfo, and NewPictInfo calls }

CONST
	returnColorTable			= $0001;
	returnPalette				= $0002;
	recordComments				= $0004;
	recordFontInfo				= $0008;
	suppressBlackAndWhite		= $0010;

																{  color pick methods  }
	systemMethod				= 0;							{  system color pick method  }
	popularMethod				= 1;							{  method that chooses the most popular set of colors  }
	medianMethod				= 2;							{  method that chooses a good average mix of colors  }

																{  color bank types  }
	ColorBankIsCustom			= -1;
	ColorBankIsExactAnd555		= 0;
	ColorBankIs555				= 1;


TYPE
	PictInfoID							= LONGINT;
	CommentSpecPtr = ^CommentSpec;
	CommentSpec = RECORD
		count:					INTEGER;								{  number of occurrances of this comment ID  }
		ID:						INTEGER;								{  ID for the comment in the picture  }
	END;

	CommentSpecHandle					= ^CommentSpecPtr;
	FontSpecPtr = ^FontSpec;
	FontSpec = RECORD
		pictFontID:				INTEGER;								{  ID of the font in the picture  }
		sysFontID:				INTEGER;								{  ID of the same font in the current system file  }
		size:					ARRAY [0..3] OF LONGINT;				{  bit array of all the sizes found (1..127) (bit 0 means > 127)  }
		style:					INTEGER;								{  combined style of all occurrances of the font  }
		nameOffset:				LONGINT;								{  offset into the fontNamesHdl handle for the font’s name  }
	END;

	FontSpecHandle						= ^FontSpecPtr;
	PictInfoPtr = ^PictInfo;
	PictInfo = RECORD
		version:				INTEGER;								{  this is always zero, for now  }
		uniqueColors:			LONGINT;								{  the number of actual colors in the picture(s)/pixmap(s)  }
		thePalette:				PaletteHandle;							{  handle to the palette information  }
		theColorTable:			CTabHandle;								{  handle to the color table  }
		hRes:					Fixed;									{  maximum horizontal resolution for all the pixmaps  }
		vRes:					Fixed;									{  maximum vertical resolution for all the pixmaps  }
		depth:					INTEGER;								{  maximum depth for all the pixmaps (in the picture)  }
		sourceRect:				Rect;									{  the picture frame rectangle (this contains the entire picture)  }
		textCount:				LONGINT;								{  total number of text strings in the picture  }
		lineCount:				LONGINT;								{  total number of lines in the picture  }
		rectCount:				LONGINT;								{  total number of rectangles in the picture  }
		rRectCount:				LONGINT;								{  total number of round rectangles in the picture  }
		ovalCount:				LONGINT;								{  total number of ovals in the picture  }
		arcCount:				LONGINT;								{  total number of arcs in the picture  }
		polyCount:				LONGINT;								{  total number of polygons in the picture  }
		regionCount:			LONGINT;								{  total number of regions in the picture  }
		bitMapCount:			LONGINT;								{  total number of bitmaps in the picture  }
		pixMapCount:			LONGINT;								{  total number of pixmaps in the picture  }
		commentCount:			LONGINT;								{  total number of comments in the picture  }
		uniqueComments:			LONGINT;								{  the number of unique comments in the picture  }
		commentHandle:			CommentSpecHandle;						{  handle to all the comment information  }
		uniqueFonts:			LONGINT;								{  the number of unique fonts in the picture  }
		fontHandle:				FontSpecHandle;							{  handle to the FontSpec information  }
		fontNamesHandle:		Handle;									{  handle to the font names  }
		reserved1:				LONGINT;
		reserved2:				LONGINT;
	END;

	PictInfoHandle						= ^PictInfoPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	InitPickMethodProcPtr = FUNCTION(colorsRequested: SInt16; VAR dataRef: UInt32; VAR colorBankType: SInt16): OSErr;
{$ELSEC}
	InitPickMethodProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	RecordColorsProcPtr = FUNCTION(dataRef: UInt32; VAR colorsArray: RGBColor; colorCount: SInt32; VAR uniqueColors: SInt32): OSErr;
{$ELSEC}
	RecordColorsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CalcColorTableProcPtr = FUNCTION(dataRef: UInt32; colorsRequested: SInt16; colorBankPtr: UNIV Ptr; VAR resultPtr: CSpecArray): OSErr;
{$ELSEC}
	CalcColorTableProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DisposeColorPickMethodProcPtr = FUNCTION(dataRef: UInt32): OSErr;
{$ELSEC}
	DisposeColorPickMethodProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	InitPickMethodUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	InitPickMethodUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	RecordColorsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	RecordColorsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CalcColorTableUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CalcColorTableUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DisposeColorPickMethodUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DisposeColorPickMethodUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppInitPickMethodProcInfo = $00000FA0;
	uppRecordColorsProcInfo = $00003FE0;
	uppCalcColorTableProcInfo = $00003EE0;
	uppDisposeColorPickMethodProcInfo = $000000E0;
	{
	 *  NewInitPickMethodUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewInitPickMethodUPP(userRoutine: InitPickMethodProcPtr): InitPickMethodUPP; { old name was NewInitPickMethodProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewRecordColorsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewRecordColorsUPP(userRoutine: RecordColorsProcPtr): RecordColorsUPP; { old name was NewRecordColorsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCalcColorTableUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCalcColorTableUPP(userRoutine: CalcColorTableProcPtr): CalcColorTableUPP; { old name was NewCalcColorTableProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDisposeColorPickMethodUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDisposeColorPickMethodUPP(userRoutine: DisposeColorPickMethodProcPtr): DisposeColorPickMethodUPP; { old name was NewDisposeColorPickMethodProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeInitPickMethodUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeInitPickMethodUPP(userUPP: InitPickMethodUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeRecordColorsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeRecordColorsUPP(userUPP: RecordColorsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCalcColorTableUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCalcColorTableUPP(userUPP: CalcColorTableUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDisposeColorPickMethodUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDisposeColorPickMethodUPP(userUPP: DisposeColorPickMethodUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeInitPickMethodUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeInitPickMethodUPP(colorsRequested: SInt16; VAR dataRef: UInt32; VAR colorBankType: SInt16; userRoutine: InitPickMethodUPP): OSErr; { old name was CallInitPickMethodProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeRecordColorsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeRecordColorsUPP(dataRef: UInt32; VAR colorsArray: RGBColor; colorCount: SInt32; VAR uniqueColors: SInt32; userRoutine: RecordColorsUPP): OSErr; { old name was CallRecordColorsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCalcColorTableUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeCalcColorTableUPP(dataRef: UInt32; colorsRequested: SInt16; colorBankPtr: UNIV Ptr; VAR resultPtr: CSpecArray; userRoutine: CalcColorTableUPP): OSErr; { old name was CallCalcColorTableProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDisposeColorPickMethodUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDisposeColorPickMethodUPP(dataRef: UInt32; userRoutine: DisposeColorPickMethodUPP): OSErr; { old name was CallDisposeColorPickMethodProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  GetPictInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPictInfo(thePictHandle: PicHandle; VAR thePictInfo: PictInfo; verb: INTEGER; colorsRequested: INTEGER; colorPickMethod: INTEGER; version: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0800, $A831;
	{$ENDC}

{
 *  GetPixMapInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixMapInfo(thePixMapHandle: PixMapHandle; VAR thePictInfo: PictInfo; verb: INTEGER; colorsRequested: INTEGER; colorPickMethod: INTEGER; version: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0801, $A831;
	{$ENDC}

{
 *  NewPictInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPictInfo(VAR thePictInfoID: PictInfoID; verb: INTEGER; colorsRequested: INTEGER; colorPickMethod: INTEGER; version: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0602, $A831;
	{$ENDC}

{
 *  RecordPictInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RecordPictInfo(thePictInfoID: PictInfoID; thePictHandle: PicHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0403, $A831;
	{$ENDC}

{
 *  RecordPixMapInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RecordPixMapInfo(thePictInfoID: PictInfoID; thePixMapHandle: PixMapHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $A831;
	{$ENDC}

{
 *  RetrievePictInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RetrievePictInfo(thePictInfoID: PictInfoID; VAR thePictInfo: PictInfo; colorsRequested: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0505, $A831;
	{$ENDC}

{
 *  DisposePictInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposePictInfo(thePictInfoID: PictInfoID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $A831;
	{$ENDC}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposPictInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DisposPictInfo(thePictInfoID: PictInfoID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $A831;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PictUtilsIncludes}

{$ENDC} {__PICTUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
