{
 	File:		CMApplication.p
 
 	Contains:	Color Matching Interfaces
 
 	Version:	Technology:	ColorSync 2.0
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
 UNIT CMApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMAPPLICATION__}
{$SETC __CMAPPLICATION__ := 1}

{$I+}
{$SETC CMApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	OSUtils.p													}
{		Memory.p												}
{	Finder.p													}

{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{	Errors.p													}
{	Dialogs.p													}
{		Menus.p													}
{		Controls.p												}
{		Windows.p												}
{			Events.p											}
{		TextEdit.p												}

{$IFC UNDEFINED __CMICCPROFILE__}
{$I CMICCProfile.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	gestaltColorSync20			= $0200;

	kDefaultCMMSignature		= 'appl';

{ Macintosh 68K trap word }
	cmTrap						= $ABEE;

{ PicComment IDs }
	cmBeginProfile				= 220;
	cmEndProfile				= 221;
	cmEnableMatching			= 222;
	cmDisableMatching			= 223;
	cmComment					= 224;

{ PicComment selectors for cmComment }
	cmBeginProfileSel			= 0;
	cmContinueProfileSel		= 1;
	cmEndProfileSel				= 2;

{ Defines for version 1.0 CMProfileSearchRecord.fieldMask }
	cmMatchCMMType				= $00000001;
	cmMatchApplProfileVersion	= $00000002;
	cmMatchDataType				= $00000004;
	cmMatchDeviceType			= $00000008;
	cmMatchDeviceManufacturer	= $00000010;
	cmMatchDeviceModel			= $00000020;
	cmMatchDeviceAttributes		= $00000040;
	cmMatchFlags				= $00000080;
	cmMatchOptions				= $00000100;
	cmMatchWhite				= $00000200;
	cmMatchBlack				= $00000400;

{ Defines for version 2.0 CMSearchRecord.searchMask }
	cmMatchAnyProfile			= $00000000;
	cmMatchProfileCMMType		= $00000001;
	cmMatchProfileClass			= $00000002;
	cmMatchDataColorSpace		= $00000004;
	cmMatchProfileConnectionSpace = $00000008;
	cmMatchManufacturer			= $00000010;
	cmMatchModel				= $00000020;
	cmMatchAttributes			= $00000040;
	cmMatchProfileFlags			= $00000080;

{ Result codes }
{ General Errors }
	cmProfileError				= -170;
	cmMethodError				= -171;
	cmMethodNotFound			= -175;							{ CMM not present }
	cmProfileNotFound			= -176;							{ Responder error }
	cmProfilesIdentical			= -177;							{ Profiles the same }
	cmCantConcatenateError		= -178;							{ Profile can't be concatenated }
	cmCantXYZ					= -179;							{ CMM cant handle XYZ space }
	cmCantDeleteProfile			= -180;							{ Responder error }
	cmUnsupportedDataType		= -181;							{ Responder error }
	cmNoCurrentProfile			= -182;							{ Responder error }
{ Profile Access Errors }
	cmElementTagNotFound		= -4200;
	cmIndexRangeErr				= -4201;						{ Index out of range }
	cmCantDeleteElement			= -4202;
	cmFatalProfileErr			= -4203;
	cmInvalidProfile			= -4204;						{ A Profile must contain a 'cs1 ' tag to be valid }
	cmInvalidProfileLocation	= -4205;						{ Operation not supported for this profile location }
{ Profile Search Errors }
	cmInvalidSearch				= -4206;						{ Bad Search Handle }
	cmSearchError				= -4207;
	cmErrIncompatibleProfile	= -4208;
{ Other ColorSync Errors }
	cmInvalidColorSpace			= -4209;						{ Profile colorspace does not match bitmap type }
	cmInvalidSrcMap				= -4210;						{ Source pix/bit map was invalid }
	cmInvalidDstMap				= -4211;						{ Destination pix/bit map was invalid }
	cmNoGDevicesError			= -4212;						{ Begin/End Matching -- no gdevices available }
	cmInvalidProfileComment		= -4213;						{ Bad Profile comment during drawpicture }
{ Color Conversion Errors }
	cmRangeOverFlow				= -4214;						{ One or more output color value overflows in color conversion 
														all input color values will still be converted, and the overflown 
														will be clipped }
{ Other Profile Access Errors }
	cmCantCopyModifiedV1Profile	= -4215;						{ It is illegal to copy version 1 profiles that  
														have been modified }

{ deviceType values for ColorSync 1.0 Device Profile access }
	cmSystemDevice				= 'sys ';
	cmGDevice					= 'gdev';

{ Commands for CMFlattenUPP(…) }
	cmOpenReadSpool				= 1;
	cmOpenWriteSpool			= 2;
	cmReadSpool					= 3;
	cmWriteSpool				= 4;
	cmCloseSpool				= 5;

{ Flags for PostScript-related functions }
	cmPS7bit					= 1;
	cmPS8bit					= 2;

	
TYPE
	CMProfileRef = Ptr;

{ Abstract data type for Profile search result }
	CMProfileSearchRef = Ptr;

{ Abstract data type for BeginMatching(…) reference }
	CMMatchRef = Ptr;

{ Abstract data type for ColorWorld reference }
	CMWorldRef = Ptr;

{ Caller-supplied progress function for Bitmap & PixMap matching routines }
{ Caller-supplied filter function for Profile search }
	CMFlattenProcPtr = ProcPtr;  { FUNCTION CMFlatten(command: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr; }
	CMBitmapCallBackProcPtr = ProcPtr;  { FUNCTION CMBitmapCallBack(progress: LONGINT; refCon: UNIV Ptr): BOOLEAN; }
	CMProfileFilterProcPtr = ProcPtr;  { FUNCTION CMProfileFilter(prof: CMProfileRef; refCon: UNIV Ptr): BOOLEAN; }
	CMFlattenUPP = UniversalProcPtr;
	CMBitmapCallBackUPP = UniversalProcPtr;
	CMProfileFilterUPP = UniversalProcPtr;

CONST
	uppCMFlattenProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppCMBitmapCallBackProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppCMProfileFilterProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewCMFlattenProc(userRoutine: CMFlattenProcPtr): CMFlattenUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMBitmapCallBackProc(userRoutine: CMBitmapCallBackProcPtr): CMBitmapCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCMProfileFilterProc(userRoutine: CMProfileFilterProcPtr): CMProfileFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallCMFlattenProc(command: LONGINT; VAR size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CMFlattenUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallCMBitmapCallBackProc(progress: LONGINT; refCon: UNIV Ptr; userRoutine: CMBitmapCallBackUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallCMProfileFilterProc(prof: CMProfileRef; refCon: UNIV Ptr; userRoutine: CMProfileFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	CMError = LONGINT;

{ For 1.0 and 2.0 profile header variants }
{ CMAppleProfileHeader }
	CMAppleProfileHeader = RECORD
		CASE INTEGER OF
		0: (
			cm1:						CMHeader;
		   );
		1: (
			cm2:						CM2Header;
		   );
	END;

{ Param for CWConcatColorWorld(…) }
	CMConcatProfileSet = RECORD
		keyIndex:				INTEGER;								{ Zero-based }
		count:					INTEGER;								{ Min 1 }
		profileSet:				ARRAY [0..0] OF CMProfileRef;			{ Variable. Ordered from Source -> Dest }
	END;

{ ColorSync color data types }
	CMRGBColor = RECORD
		red:					INTEGER;								{ 0..65535 }
		green:					INTEGER;
		blue:					INTEGER;
	END;

	CMCMYKColor = RECORD
		cyan:					INTEGER;								{ 0..65535 }
		magenta:				INTEGER;
		yellow:					INTEGER;
		black:					INTEGER;
	END;

	CMCMYColor = RECORD
		cyan:					INTEGER;								{ 0..65535 }
		magenta:				INTEGER;
		yellow:					INTEGER;
	END;

	CMHLSColor = RECORD
		hue:					INTEGER;								{ 0..65535. Fraction of circle. Red at 0 }
		lightness:				INTEGER;								{ 0..65535 }
		saturation:				INTEGER;								{ 0..65535 }
	END;

	CMHSVColor = RECORD
		hue:					INTEGER;								{ 0..65535. Fraction of circle. Red at 0 }
		saturation:				INTEGER;								{ 0..65535 }
		value:					INTEGER;								{ 0..65535 }
	END;

	CMLabColor = RECORD
		L:						INTEGER;								{ 0..65535 maps to 0..100 }
		a:						INTEGER;								{ 0..65535 maps to -128..127.996 }
		b:						INTEGER;								{ 0..65535 maps to -128..127.996 }
	END;

	CMLuvColor = RECORD
		L:						INTEGER;								{ 0..65535 maps to 0..100 }
		u:						INTEGER;								{ 0..65535 maps to -128..127.996 }
		v:						INTEGER;								{ 0..65535 maps to -128..127.996 }
	END;

	CMYxyColor = RECORD
		capY:					INTEGER;								{ 0..65535 maps to 0..1 }
		x:						INTEGER;								{ 0..65535 maps to 0..1 }
		y:						INTEGER;								{ 0..65535 maps to 0..1 }
	END;

	CMGrayColor = RECORD
		gray:					INTEGER;								{ 0..65535 }
	END;

	CMMultichannel5Color = RECORD
		components:				ARRAY [0..4] OF SInt8; (* unsigned char *) { 0..255 }
	END;

	CMMultichannel6Color = RECORD
		components:				ARRAY [0..5] OF SInt8; (* unsigned char *) { 0..255 }
	END;

	CMMultichannel7Color = RECORD
		components:				ARRAY [0..6] OF SInt8; (* unsigned char *) { 0..255 }
	END;

	CMMultichannel8Color = RECORD
		components:				ARRAY [0..7] OF SInt8; (* unsigned char *) { 0..255 }
	END;

	CMColor = RECORD
		CASE INTEGER OF
		0: (
			rgb:						CMRGBColor;
		   );
		1: (
			hsv:						CMHSVColor;
		   );
		2: (
			hls:						CMHLSColor;
		   );
		3: (
			XYZ:						CMXYZColor;
		   );
		4: (
			Lab:						CMLabColor;
		   );
		5: (
			Luv:						CMLuvColor;
		   );
		6: (
			Yxy:						CMYxyColor;
		   );
		7: (
			cmyk:						CMCMYKColor;
		   );
		8: (
			cmy:						CMCMYColor;
		   );
		9: (
			gray:						CMGrayColor;
		   );
		10: (
			mc5:						CMMultichannel5Color;
		   );
		11: (
			mc6:						CMMultichannel6Color;
		   );
		12: (
			mc7:						CMMultichannel7Color;
		   );
		13: (
			mc8:						CMMultichannel8Color;
		   );
	END;

	CMProfileSearchRecord = RECORD
		header:					CMHeader;
		fieldMask:				LONGINT;
		reserved:				ARRAY [0..1] OF LONGINT;
	END;

	CMProfileSearchRecordPtr = ^CMProfileSearchRecord;
	CMProfileSearchRecordHandle = ^CMProfileSearchRecordPtr;

{ Search definition for 2.0 }
	CMSearchRecord = RECORD
		CMMType:				OSType;
		profileClass:			OSType;
		dataColorSpace:			OSType;
		profileConnectionSpace:	OSType;
		deviceManufacturer:		LONGINT;
		deviceModel:			LONGINT;
		deviceAttributes:		ARRAY [0..1] OF LONGINT;
		profileFlags:			LONGINT;
		searchMask:				LONGINT;
		filter:					CMProfileFilterUPP;
	END;

{ GetCWInfo structures }
	CMMInfoRecord = RECORD
		CMMType:				OSType;
		CMMVersion:				LONGINT;
	END;

	CMCWInfoRecord = RECORD
		cmmCount:				LONGINT;
		cmmInfo:				ARRAY [0..1] OF CMMInfoRecord;
	END;


CONST
	cmNoColorPacking			= $0000;
	cmAlphaSpace				= $0080;
	cmWord5ColorPacking			= $0500;
	cmLong8ColorPacking			= $0800;
	cmLong10ColorPacking		= $0a00;
	cmAlphaFirstPacking			= $1000;
	cmOneBitDirectPacking		= $0b00;

	cmNoSpace					= 0;
	cmRGBSpace					= 1;
	cmCMYKSpace					= 2;
	cmHSVSpace					= 3;
	cmHLSSpace					= 4;
	cmYXYSpace					= 5;
	cmXYZSpace					= 6;
	cmLUVSpace					= 7;
	cmLABSpace					= 8;
	cmReservedSpace1			= 9;
	cmGraySpace					= 10;
	cmReservedSpace2			= 11;
	cmGamutResultSpace			= 12;
	cmRGBASpace					= cmRGBSpace + cmAlphaSpace;
	cmGrayASpace				= cmGraySpace + cmAlphaSpace;
	cmRGB16Space				= cmWord5ColorPacking + cmRGBSpace;
	cmRGB32Space				= cmLong8ColorPacking + cmRGBSpace;
	cmARGB32Space				= cmLong8ColorPacking + cmAlphaFirstPacking + cmRGBASpace;
	cmCMYK32Space				= cmLong8ColorPacking + cmCMYKSpace;
	cmHSV32Space				= cmLong10ColorPacking + cmHSVSpace;
	cmHLS32Space				= cmLong10ColorPacking + cmHLSSpace;
	cmYXY32Space				= cmLong10ColorPacking + cmYXYSpace;
	cmXYZ32Space				= cmLong10ColorPacking + cmXYZSpace;
	cmLUV32Space				= cmLong10ColorPacking + cmLUVSpace;
	cmLAB32Space				= cmLong10ColorPacking + cmLABSpace;
	cmGamutResult1Space			= cmOneBitDirectPacking + cmGamutResultSpace;

	
TYPE
	CMBitmapColorSpace = LONGINT;

	CMBitmap = RECORD
		image:					^CHAR;
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		pixelSize:				LONGINT;
		space:					CMBitmapColorSpace;
		user1:					LONGINT;
		user2:					LONGINT;
	END;

{ Classic Print Manager Stuff }

CONST
	enableColorMatchingOp		= 12;
	registerProfileOp			= 13;

{ PrGeneral parameter blocks }

TYPE
	TEnableColorMatchingBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fEnableIt:				BOOLEAN;
	END;

	TRegisterProfileBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fRegisterIt:			BOOLEAN;
	END;


CONST
	cmNoProfileBase				= 0;
	cmFileBasedProfile			= 1;
	cmHandleBasedProfile		= 2;
	cmPtrBasedProfile			= 3;


TYPE
	CMFileLocation = RECORD
		spec:					FSSpec;
	END;

	CMHandleLocation = RECORD
		h:						Handle;
	END;

	CMPtrLocation = RECORD
		p:						Ptr;
	END;

	CMProfLoc = RECORD
		CASE INTEGER OF
		0: (
			fileLoc:					CMFileLocation;
		   );
		1: (
			handleLoc:					CMHandleLocation;
		   );
		2: (
			ptrLoc:						CMPtrLocation;
		   );
	END;

	CMProfileLocation = RECORD
		locType:				INTEGER;
		u:						CMProfLoc;
	END;

{ Profile file and element access }

FUNCTION CMOpenProfile(VAR prof: CMProfileRef; {CONST}VAR theProfile: CMProfileLocation): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $001C, $ABEE;
	{$ENDC}
FUNCTION CMCloseProfile(prof: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $001D, $ABEE;
	{$ENDC}
FUNCTION CMUpdateProfile(prof: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0034, $ABEE;
	{$ENDC}
FUNCTION CMNewProfile(VAR prof: CMProfileRef; {CONST}VAR theProfile: CMProfileLocation): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $001B, $ABEE;
	{$ENDC}
FUNCTION CMCopyProfile(VAR targetProf: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; srcProf: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0025, $0ABEE;
	{$ENDC}
FUNCTION CMGetProfileLocation(prof: CMProfileRef; VAR theProfile: CMProfileLocation): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $003C, $0ABEE;
	{$ENDC}
FUNCTION CMValidateProfile(prof: CMProfileRef; VAR valid: BOOLEAN; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0026, $0ABEE;
	{$ENDC}
FUNCTION CMFlattenProfile(prof: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0031, $0ABEE;
	{$ENDC}
FUNCTION CMUnflattenProfile(VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0032, $0ABEE;
	{$ENDC}
FUNCTION CMProfileElementExists(prof: CMProfileRef; tag: OSType; VAR found: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $001E, $0ABEE;
	{$ENDC}
FUNCTION CMCountProfileElements(prof: CMProfileRef; VAR elementCount: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $001F, $0ABEE;
	{$ENDC}
FUNCTION CMGetProfileElement(prof: CMProfileRef; tag: OSType; VAR elementSize: LONGINT; elementData: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0020, $0ABEE;
	{$ENDC}
FUNCTION CMGetProfileHeader(prof: CMProfileRef; VAR header: CMAppleProfileHeader): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0039, $0ABEE;
	{$ENDC}
FUNCTION CMGetPartialProfileElement(prof: CMProfileRef; tag: OSType; offset: LONGINT; VAR byteCount: LONGINT; elementData: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0036, $0ABEE;
	{$ENDC}
FUNCTION CMSetProfileElementSize(prof: CMProfileRef; tag: OSType; elementSize: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0038, $0ABEE;
	{$ENDC}
FUNCTION CMSetPartialProfileElement(prof: CMProfileRef; tag: OSType; offset: LONGINT; byteCount: LONGINT; elementData: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0037, $0ABEE;
	{$ENDC}
FUNCTION CMGetIndProfileElementInfo(prof: CMProfileRef; index: LONGINT; VAR tag: OSType; VAR elementSize: LONGINT; VAR refs: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0021, $0ABEE;
	{$ENDC}
FUNCTION CMGetIndProfileElement(prof: CMProfileRef; index: LONGINT; VAR elementSize: LONGINT; elementData: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0022, $0ABEE;
	{$ENDC}
FUNCTION CMSetProfileElement(prof: CMProfileRef; tag: OSType; elementSize: LONGINT; elementData: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0023, $0ABEE;
	{$ENDC}
FUNCTION CMSetProfileHeader(prof: CMProfileRef; {CONST}VAR header: CMAppleProfileHeader): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $003A, $0ABEE;
	{$ENDC}
FUNCTION CMSetProfileElementReference(prof: CMProfileRef; elementTag: OSType; referenceTag: OSType): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0035, $0ABEE;
	{$ENDC}
FUNCTION CMRemoveProfileElement(prof: CMProfileRef; tag: OSType): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0024, $0ABEE;
	{$ENDC}
FUNCTION CMGetScriptProfileDescription(prof: CMProfileRef; VAR name: Str255; VAR code: ScriptCode): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $003E, $0ABEE;
	{$ENDC}
{ Low-level matching functions }
FUNCTION NCWNewColorWorld(VAR cw: CMWorldRef; src: CMProfileRef; dst: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0014, $0ABEE;
	{$ENDC}
FUNCTION CWConcatColorWorld(VAR cw: CMWorldRef; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0015, $0ABEE;
	{$ENDC}
FUNCTION CWNewLinkProfile(VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0033, $0ABEE;
	{$ENDC}
PROCEDURE CWDisposeColorWorld(cw: CMWorldRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0001, $0ABEE;
	{$ENDC}
FUNCTION CWMatchColors(cw: CMWorldRef; VAR myColors: CMColor; count: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0002, $0ABEE;
	{$ENDC}
FUNCTION CWCheckColors(cw: CMWorldRef; VAR myColors: CMColor; count: LONGINT; VAR result: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0003, $0ABEE;
	{$ENDC}
{ Bitmap matching }
FUNCTION CWMatchBitmap(cw: CMWorldRef; VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $002C, $0ABEE;
	{$ENDC}
FUNCTION CWCheckBitmap(cw: CMWorldRef; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $002D, $0ABEE;
	{$ENDC}
{ Quickdraw-specific matching }
FUNCTION CWMatchPixMap(cw: CMWorldRef; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0004, $0ABEE;
	{$ENDC}
FUNCTION CWCheckPixMap(cw: CMWorldRef; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitMap: BitMap): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0007, $0ABEE;
	{$ENDC}
FUNCTION NCMBeginMatching(src: CMProfileRef; dst: CMProfileRef; VAR myRef: CMMatchRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0016, $0ABEE;
	{$ENDC}
PROCEDURE CMEndMatching(myRef: CMMatchRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000B, $0ABEE;
	{$ENDC}
PROCEDURE NCMDrawMatchedPicture(myPicture: PicHandle; dst: CMProfileRef; VAR myRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0017, $0ABEE;
	{$ENDC}
PROCEDURE CMEnableMatchingComment(enableIt: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0002, $000D, $0ABEE;
	{$ENDC}
FUNCTION NCMUseProfileComment(prof: CMProfileRef; flags: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $003B, $0ABEE;
	{$ENDC}
{ System Profile access }
FUNCTION CMGetSystemProfile(VAR prof: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0018, $0ABEE;
	{$ENDC}
FUNCTION CMSetSystemProfile({CONST}VAR profileFileSpec: FSSpec): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0019, $0ABEE;
	{$ENDC}
{ External Profile Management }
FUNCTION CMNewProfileSearch(VAR searchSpec: CMSearchRecord; refCon: UNIV Ptr; VAR count: LONGINT; VAR searchResult: CMProfileSearchRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0027, $0ABEE;
	{$ENDC}
FUNCTION CMUpdateProfileSearch(search: CMProfileSearchRef; refCon: UNIV Ptr; VAR count: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0028, $0ABEE;
	{$ENDC}
PROCEDURE CMDisposeProfileSearch(search: CMProfileSearchRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0029, $0ABEE;
	{$ENDC}
FUNCTION CMSearchGetIndProfile(search: CMProfileSearchRef; index: LONGINT; VAR prof: CMProfileRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $002A, $0ABEE;
	{$ENDC}
FUNCTION CMSearchGetIndProfileFileSpec(search: CMProfileSearchRef; index: LONGINT; VAR profileFile: FSSpec): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $002B, $0ABEE;
	{$ENDC}
{ Utilities }
FUNCTION CMGetColorSyncFolderSpec(vRefNum: INTEGER; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0011, $0ABEE;
	{$ENDC}
FUNCTION CMGetCWInfo(cw: CMWorldRef; VAR info: CMCWInfoRecord): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $001A, $0ABEE;
	{$ENDC}
{ PS-related }
FUNCTION CMGetPS2ColorSpace(srcProf: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $002E, $0ABEE;
	{$ENDC}
FUNCTION CMGetPS2ColorRenderingIntent(srcProf: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $002F, $0ABEE;
	{$ENDC}
FUNCTION CMGetPS2ColorRendering(srcProf: CMProfileRef; dstProf: CMProfileRef; flags: LONGINT; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0018, $0030, $0ABEE;
	{$ENDC}
FUNCTION CMGetPS2ColorRenderingVMSize(srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: LONGINT; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $003D, $0ABEE;
	{$ENDC}
{ ColorSync 1.0 functions which have parallel 2.0 counterparts }
FUNCTION CWNewColorWorld(VAR cw: CMWorldRef; src: CMProfileHandle; dst: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0000, $0ABEE;
	{$ENDC}
FUNCTION ConcatenateProfiles(thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $000C, $0ABEE;
	{$ENDC}
FUNCTION CMBeginMatching(src: CMProfileHandle; dst: CMProfileHandle; VAR myRef: CMMatchRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $000A, $0ABEE;
	{$ENDC}
PROCEDURE CMDrawMatchedPicture(myPicture: PicHandle; dst: CMProfileHandle; VAR myRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0009, $0ABEE;
	{$ENDC}
FUNCTION CMUseProfileComment(profile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0008, $0ABEE;
	{$ENDC}
PROCEDURE CMGetProfileName(myProfile: CMProfileHandle; VAR IStringResult: CMIString);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $000E, $0ABEE;
	{$ENDC}
FUNCTION CMGetProfileAdditionalDataOffset(myProfile: CMProfileHandle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000F, $0ABEE;
	{$ENDC}
{ ProfileResponder functions }
FUNCTION GetProfile(deviceType: OSType; refNum: LONGINT; aProfile: CMProfileHandle; VAR returnedProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0005, $0ABEE;
	{$ENDC}
FUNCTION SetProfile(deviceType: OSType; refNum: LONGINT; newProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0006, $0ABEE;
	{$ENDC}
FUNCTION SetProfileDescription(deviceType: OSType; refNum: LONGINT; deviceData: LONGINT; hProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0010, $0ABEE;
	{$ENDC}
FUNCTION GetIndexedProfile(deviceType: OSType; refNum: LONGINT; search: CMProfileSearchRecordHandle; VAR returnProfile: CMProfileHandle; VAR index: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0012, $0ABEE;
	{$ENDC}
FUNCTION DeleteDeviceProfile(deviceType: OSType; refNum: LONGINT; deleteMe: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0013, $0ABEE;
	{$ENDC}
{$IFC OLDROUTINENAMES }

CONST
	kMatchCMMType				= cmMatchCMMType;
	kMatchApplProfileVersion	= cmMatchApplProfileVersion;
	kMatchDataType				= cmMatchDataType;
	kMatchDeviceType			= cmMatchDeviceType;
	kMatchDeviceManufacturer	= cmMatchDeviceManufacturer;
	kMatchDeviceModel			= cmMatchDeviceModel;
	kMatchDeviceAttributes		= cmMatchDeviceAttributes;
	kMatchFlags					= cmMatchFlags;
	kMatchOptions				= cmMatchOptions;
	kMatchWhite					= cmMatchWhite;
	kMatchBlack					= cmMatchBlack;

{ types }
	
TYPE
	CMYKColor = CMCMYKColor;

	CWorld = CMWorldRef;

	CMGamutResult = ^LONGINT;

{ functions }

PROCEDURE EndMatching(myRef: CMMatchRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000B, $0ABEE;
	{$ENDC}
PROCEDURE EnableMatching(enableIt: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0002, $000D, $0ABEE;
	{$ENDC}
FUNCTION GetColorSyncFolderSpec(vRefNum: INTEGER; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0011, $0ABEE;
	{$ENDC}
FUNCTION BeginMatching(src: CMProfileHandle; dst: CMProfileHandle; VAR myRef: CMMatchRef): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $000A, $0ABEE;
	{$ENDC}
PROCEDURE DrawMatchedPicture(myPicture: PicHandle; dst: CMProfileHandle; VAR myRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0009, $0ABEE;
	{$ENDC}
FUNCTION UseProfile(profile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0008, $0ABEE;
	{$ENDC}
PROCEDURE GetProfileName(myProfile: CMProfileHandle; VAR IStringResult: CMIString);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $000E, $0ABEE;
	{$ENDC}
FUNCTION GetProfileAdditionalDataOffset(myProfile: CMProfileHandle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $000F, $0ABEE;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMApplicationIncludes}

{$ENDC} {__CMAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
