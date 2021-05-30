{
     File:       Fonts.p
 
     Contains:   Public interface to the Font Manager.
 
     Version:    Technology: Mac OS
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Fonts;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FONTS__}
{$SETC __FONTS__ := 1}

{$I+}
{$SETC FontsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ATSTYPES__}
{$I ATSTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	systemFont					= 0;
	applFont					= 1;

	{	 kPlatformDefaultGuiFontID is used in QuickTime 3.0. 	}
{$IFC TARGET_OS_MAC }
	kPlatformDefaultGuiFontID	= 1;

{$ELSEC}
	kPlatformDefaultGuiFontID	= -1;

{$ENDC}  {TARGET_OS_MAC}

	commandMark					= 17;
	checkMark					= 18;
	diamondMark					= 19;
	appleMark					= 20;

	propFont					= 36864;
	prpFntH						= 36865;
	prpFntW						= 36866;
	prpFntHW					= 36867;
	fixedFont					= 45056;
	fxdFntH						= 45057;
	fxdFntW						= 45058;
	fxdFntHW					= 45059;
	fontWid						= 44208;


TYPE
	FMInputPtr = ^FMInput;
	FMInput = PACKED RECORD
		family:					INTEGER;
		size:					INTEGER;
		face:					Style;
		needBits:				BOOLEAN;
		device:					INTEGER;
		numer:					Point;
		denom:					Point;
	END;

	FMOutputPtr = ^FMOutput;
	FMOutput = PACKED RECORD
		errNum:					INTEGER;
		fontHandle:				Handle;
		boldPixels:				UInt8;
		italicPixels:			UInt8;
		ulOffset:				UInt8;
		ulShadow:				UInt8;
		ulThick:				UInt8;
		shadowPixels:			UInt8;
		extra:					SInt8;
		ascent:					UInt8;
		descent:				UInt8;
		widMax:					UInt8;
		leading:				SInt8;
		curStyle:				SInt8;
		numer:					Point;
		denom:					Point;
	END;

	FMOutPtr							= FMOutputPtr;
	FMetricRecPtr = ^FMetricRec;
	FMetricRec = RECORD
		ascent:					Fixed;									{ base line to top }
		descent:				Fixed;									{ base line to bottom }
		leading:				Fixed;									{ leading between lines }
		widMax:					Fixed;									{ maximum character width }
		wTabHandle:				Handle;									{ handle to font width table }
	END;

	FMetricRecHandle					= ^FMetricRecPtr;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  InitFonts()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE InitFonts;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FE;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetFontName(familyID: INTEGER; VAR name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FF;
	{$ENDC}

{
 *  GetFNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetFNum(name: Str255; VAR familyID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A900;
	{$ENDC}

{
 *  RealFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RealFont(fontNum: INTEGER; size: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A902;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SetFontLock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetFontLock(lockFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A903;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  FMSwapFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMSwapFont({CONST}VAR inRec: FMInput): FMOutPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A901;
	{$ENDC}

{
 *  SetFScaleDisable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetFScaleDisable(fscaleDisable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A834;
	{$ENDC}

{
 *  FontMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FontMetrics(theMetrics: FMetricRecPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A835;
	{$ENDC}

{
 *  SetFractEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetFractEnable(fractEnable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A814;
	{$ENDC}

{
 *  GetDefFontSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDefFontSize: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BA8, $6604, $3EBC, $000C;
	{$ENDC}

{
 *  IsOutline()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsOutline(numer: Point; denom: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A854;
	{$ENDC}

{
 *  SetOutlinePreferred()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetOutlinePreferred(outlinePreferred: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A854;
	{$ENDC}

{
 *  GetOutlinePreferred()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetOutlinePreferred: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $A854;
	{$ENDC}

{
 *  OutlineMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OutlineMetrics(byteCount: INTEGER; textPtr: UNIV Ptr; numer: Point; denom: Point; VAR yMax: INTEGER; VAR yMin: INTEGER; awArray: FixedPtr; lsbArray: FixedPtr; boundsArray: RectPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A854;
	{$ENDC}

{
 *  SetPreserveGlyph()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPreserveGlyph(preserveGlyph: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $A854;
	{$ENDC}

{
 *  GetPreserveGlyph()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPreserveGlyph: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A854;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  FlushFonts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FlushFonts: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A854;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetSysFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSysFont: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BA6;
	{$ENDC}

{
 *  GetAppFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetAppFont: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0984;
	{$ENDC}

{--------------------------------------------------------------------------------------}
{  Extended font data functions (available only with Mac OS 8.5 or later)              }
{--------------------------------------------------------------------------------------}
{
 *  SetAntiAliasedTextEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetAntiAliasedTextEnabled(iEnable: BOOLEAN; iMinFontSize: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $A854;
	{$ENDC}

{
 *  IsAntiAliasedTextEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsAntiAliasedTextEnabled(VAR oMinFontSize: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $A854;
	{$ENDC}

{
 *  QDTextBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE QDTextBounds(byteCount: INTEGER; textAddr: UNIV Ptr; VAR bounds: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $A854;
	{$ENDC}

{
 *  FetchFontInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FetchFontInfo(fontID: SInt16; fontSize: SInt16; fontStyle: SInt16; VAR info: FontInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $A854;
	{$ENDC}

{--------------------------------------------------------------------------------------}
{  Font access and data management functions (available only with Mac OS 9.0 or later) }
{--------------------------------------------------------------------------------------}
{ Enumeration }
{
 *  FMCreateFontFamilyIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMCreateFontFamilyIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontFamilyIterator): OSStatus; C;

{
 *  FMDisposeFontFamilyIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMDisposeFontFamilyIterator(VAR ioIterator: FMFontFamilyIterator): OSStatus; C;

{
 *  FMResetFontFamilyIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMResetFontFamilyIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontFamilyIterator): OSStatus; C;

{
 *  FMGetNextFontFamily()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetNextFontFamily(VAR ioIterator: FMFontFamilyIterator; VAR oFontFamily: FMFontFamily): OSStatus; C;

{
 *  FMCreateFontIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMCreateFontIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontIterator): OSStatus; C;

{
 *  FMDisposeFontIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMDisposeFontIterator(VAR ioIterator: FMFontIterator): OSStatus; C;

{
 *  FMResetFontIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMResetFontIterator(iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits; VAR ioIterator: FMFontIterator): OSStatus; C;

{
 *  FMGetNextFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetNextFont(VAR ioIterator: FMFontIterator; VAR oFont: FMFont): OSStatus; C;

{ Font families }
{
 *  FMCreateFontFamilyInstanceIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMCreateFontFamilyInstanceIterator(iFontFamily: FMFontFamily; VAR ioIterator: FMFontFamilyInstanceIterator): OSStatus; C;

{
 *  FMDisposeFontFamilyInstanceIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMDisposeFontFamilyInstanceIterator(VAR ioIterator: FMFontFamilyInstanceIterator): OSStatus; C;

{
 *  FMResetFontFamilyInstanceIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMResetFontFamilyInstanceIterator(iFontFamily: FMFontFamily; VAR ioIterator: FMFontFamilyInstanceIterator): OSStatus; C;

{
 *  FMGetNextFontFamilyInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetNextFontFamilyInstance(VAR ioIterator: FMFontFamilyInstanceIterator; VAR oFont: FMFont; VAR oStyle: FMFontStyle; VAR oSize: FMFontSize): OSStatus; C;

{
 *  FMGetFontFamilyFromName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFamilyFromName(iName: Str255): FMFontFamily; C;

{
 *  FMGetFontFamilyName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFamilyName(iFontFamily: FMFontFamily; VAR oName: Str255): OSStatus; C;

{
 *  FMGetFontFamilyTextEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFamilyTextEncoding(iFontFamily: FMFontFamily; VAR oTextEncoding: TextEncoding): OSStatus; C;

{
 *  FMGetFontFamilyGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFamilyGeneration(iFontFamily: FMFontFamily; VAR oGeneration: FMGeneration): OSStatus; C;

{ Fonts }
{
 *  FMGetFontFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFormat(iFont: FMFont; VAR oFormat: FourCharCode): OSStatus; C;

{
 *  FMGetFontTableDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontTableDirectory(iFont: FMFont; iLength: ByteCount; iBuffer: UNIV Ptr; VAR oActualLength: ByteCount): OSStatus; C;

{
 *  FMGetFontTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontTable(iFont: FMFont; iTag: FourCharCode; iOffset: ByteOffset; iLength: ByteCount; iBuffer: UNIV Ptr; VAR oActualLength: ByteCount): OSStatus; C;

{
 *  FMGetFontGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontGeneration(iFont: FMFont; VAR oGeneration: FMGeneration): OSStatus; C;

{
 *  FMGetFontContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontContainer(iFont: FMFont; VAR oFontContainer: FSSpec): OSStatus; C;

{ Conversion }
{
 *  FMGetFontFromFontFamilyInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFromFontFamilyInstance(iFontFamily: FMFontFamily; iStyle: FMFontStyle; VAR oFont: FMFont; VAR oIntrinsicStyle: FMFontStyle): OSStatus; C;

{
 *  FMGetFontFamilyInstanceFromFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetFontFamilyInstanceFromFont(iFont: FMFont; VAR oFontFamily: FMFontFamily; VAR oStyle: FMFontStyle): OSStatus; C;

{ Activation }
{
 *  FMActivateFonts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMActivateFonts({CONST}VAR iFontContainer: FSSpec; iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits): OSStatus; C;

{
 *  FMDeactivateFonts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMDeactivateFonts({CONST}VAR iFontContainer: FSSpec; iFilter: {Const}FMFilterPtr; iRefCon: UNIV Ptr; iOptions: OptionBits): OSStatus; C;

{
 *  FMGetGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontManager 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FMGetGeneration: FMGeneration; C;


TYPE
	FontFamilyID						= FMFontFamily;
	FontPointSize						= FMFontSize;
	{	--------------------------------------------------------------------------------------	}
	{	 Deprecated constant and type definitions                                             	}
	{	--------------------------------------------------------------------------------------	}
	{	 The font identifier constants are deprecated; use GetFNum or FMGetFontFamilyFromName
	   to find a font family from a standard QuickDraw name.
		}

CONST
	kFontIDNewYork				= 2;
	kFontIDGeneva				= 3;
	kFontIDMonaco				= 4;
	kFontIDVenice				= 5;
	kFontIDLondon				= 6;
	kFontIDAthens				= 7;
	kFontIDSanFrancisco			= 8;
	kFontIDToronto				= 9;
	kFontIDCairo				= 11;
	kFontIDLosAngeles			= 12;
	kFontIDTimes				= 20;
	kFontIDHelvetica			= 21;
	kFontIDCourier				= 22;
	kFontIDSymbol				= 23;
	kFontIDMobile				= 24;

	{	 The following data structures referenced by the low memory global variables of the
	   Font Manager are deprecated on Mac OS X and CarbonLib 1.1. The low memory global
	   variables are not shared between processes and may result in inconsistencies
	   compared to previous releases of the system software. Changes made to the
	   information contained in the low memory global variables, including any
	   indirectly referenced width tables, font family records, and font records, are
	   not reflected in the global state of the Font Manager and may only be accessed
	   through the font access and data management functions of the Font Manager or ATS.
		}

TYPE
	WidEntryPtr = ^WidEntry;
	WidEntry = RECORD
		widStyle:				INTEGER;								{ style entry applies to }
	END;

	WidTablePtr = ^WidTable;
	WidTable = RECORD
		numWidths:				INTEGER;								{ number of entries - 1 }
	END;

	AsscEntryPtr = ^AsscEntry;
	AsscEntry = RECORD
		fontSize:				INTEGER;
		fontStyle:				INTEGER;
		fontID:					INTEGER;								{ font resource ID }
	END;

	FontAssocPtr = ^FontAssoc;
	FontAssoc = RECORD
		numAssoc:				INTEGER;								{ number of entries - 1 }
	END;

	StyleTablePtr = ^StyleTable;
	StyleTable = RECORD
		fontClass:				INTEGER;
		offset:					LONGINT;
		reserved:				LONGINT;
		indexes:				PACKED ARRAY [0..47] OF CHAR;
	END;

	NameTablePtr = ^NameTable;
	NameTable = RECORD
		stringCount:			INTEGER;
		baseFontName:			Str255;
	END;

	KernPairPtr = ^KernPair;
	KernPair = RECORD
		kernFirst:				SInt8;									{ 1st character of kerned pair }
		kernSecond:				SInt8;									{ 2nd character of kerned pair }
		kernWidth:				INTEGER;								{ kerning in 1pt fixed format }
	END;

	KernEntryPtr = ^KernEntry;
	KernEntry = RECORD
		kernStyle:				INTEGER;								{ style the entry applies to }
		kernLength:				INTEGER;								{ length of this entry }
	END;

	KernTablePtr = ^KernTable;
	KernTable = RECORD
		numKerns:				INTEGER;								{ number of kerning entries }
	END;

	WidthTablePtr = ^WidthTable;
	WidthTable = PACKED RECORD
		tabData:				ARRAY [0..255] OF Fixed;				{ character widths }
		tabFont:				Handle;									{ font record used to build table }
		sExtra:					LONGINT;								{ space extra used for table }
		style:					LONGINT;								{ extra due to style }
		fID:					INTEGER;								{ font family ID }
		fSize:					INTEGER;								{ font size request }
		face:					INTEGER;								{ style (face) request }
		device:					INTEGER;								{ device requested }
		inNumer:				Point;									{ scale factors requested }
		inDenom:				Point;									{ scale factors requested }
		aFID:					INTEGER;								{ actual font family ID for table }
		fHand:					Handle;									{ family record used to build up table }
		usedFam:				BOOLEAN;								{ used fixed point family widths }
		aFace:					UInt8;									{ actual face produced }
		vOutput:				INTEGER;								{ vertical scale output value }
		hOutput:				INTEGER;								{ horizontal scale output value }
		vFactor:				INTEGER;								{ vertical scale output value }
		hFactor:				INTEGER;								{ horizontal scale output value }
		aSize:					INTEGER;								{ actual size of actual font used }
		tabSize:				INTEGER;								{ total size of table }
	END;

	WidthTableHdl						= ^WidthTablePtr;
	FamRecPtr = ^FamRec;
	FamRec = RECORD
		ffFlags:				INTEGER;								{ flags for family }
		ffFamID:				INTEGER;								{ family ID number }
		ffFirstChar:			INTEGER;								{ ASCII code of 1st character }
		ffLastChar:				INTEGER;								{ ASCII code of last character }
		ffAscent:				INTEGER;								{ maximum ascent for 1pt font }
		ffDescent:				INTEGER;								{ maximum descent for 1pt font }
		ffLeading:				INTEGER;								{ maximum leading for 1pt font }
		ffWidMax:				INTEGER;								{ maximum widMax for 1pt font }
		ffWTabOff:				LONGINT;								{ offset to width table }
		ffKernOff:				LONGINT;								{ offset to kerning table }
		ffStylOff:				LONGINT;								{ offset to style mapping table }
		ffProperty:				ARRAY [0..8] OF INTEGER;				{ style property info }
		ffIntl:					ARRAY [0..1] OF INTEGER;				{ for international use }
		ffVersion:				INTEGER;								{ version number }
	END;

	FontRecPtr = ^FontRec;
	FontRec = RECORD
		fontType:				INTEGER;								{ font type }
		firstChar:				INTEGER;								{ ASCII code of first character }
		lastChar:				INTEGER;								{ ASCII code of last character }
		widMax:					INTEGER;								{ maximum character width }
		kernMax:				INTEGER;								{ negative of maximum character kern }
		nDescent:				INTEGER;								{ negative of descent }
		fRectWidth:				INTEGER;								{ width of font rectangle }
		fRectHeight:			INTEGER;								{ height of font rectangle }
		owTLoc:					UInt16;									{ offset to offset/width table }
		ascent:					INTEGER;								{ ascent }
		descent:				INTEGER;								{ descent }
		leading:				INTEGER;								{ leading }
		rowWords:				INTEGER;								{ row width of bit image / 2  }
	END;

	FontRecHdl							= ^FontRecPtr;
	{	--------------------------------------------------------------------------------------	}
{$IFC OLDROUTINENAMES }

CONST
	newYork						= 2;
	geneva						= 3;
	monaco						= 4;
	venice						= 5;
	london						= 6;
	athens						= 7;
	sanFran						= 8;
	toronto						= 9;
	cairo						= 11;
	losAngeles					= 12;
	times						= 20;
	helvetica					= 21;
	courier						= 22;
	symbol						= 23;
	mobile						= 24;

{$ENDC}  {OLDROUTINENAMES}

{--------------------------------------------------------------------------------------}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FontsIncludes}

{$ENDC} {__FONTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
