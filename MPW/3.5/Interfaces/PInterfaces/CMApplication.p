{
     File:       CMApplication.p
 
     Contains:   Color Matching Interfaces
 
     Version:    Technology: ColorSync 3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1992-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CMICCPROFILE__}
{$I CMICCProfile.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CMTYPES__}
{$I CMTypes.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}


{$SETC _DECLARE_CS_QD_API_ := 1 }
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC TARGET_API_MAC_OS8 }
{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{$ENDC}  {TARGET_API_MAC_OS8}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kDefaultCMMSignature		= 'appl';

	{	 Macintosh 68K trap word 	}
	cmTrap						= $ABEE;


	{	 PicComment IDs 	}
	cmBeginProfile				= 220;
	cmEndProfile				= 221;
	cmEnableMatching			= 222;
	cmDisableMatching			= 223;
	cmComment					= 224;

	{	 PicComment selectors for cmComment 	}
	cmBeginProfileSel			= 0;
	cmContinueProfileSel		= 1;
	cmEndProfileSel				= 2;
	cmProfileIdentifierSel		= 3;


	{	 Defines for version 1.0 CMProfileSearchRecord.fieldMask 	}
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

	{	 Defines for version 2.0 CMSearchRecord.searchMask 	}
	cmMatchAnyProfile			= $00000000;
	cmMatchProfileCMMType		= $00000001;
	cmMatchProfileClass			= $00000002;
	cmMatchDataColorSpace		= $00000004;
	cmMatchProfileConnectionSpace = $00000008;
	cmMatchManufacturer			= $00000010;
	cmMatchModel				= $00000020;
	cmMatchAttributes			= $00000040;
	cmMatchProfileFlags			= $00000080;


	{	 Flags for PostScript-related functions 	}
	cmPS7bit					= 1;
	cmPS8bit					= 2;

	{	 Flags for profile embedding functions 	}
	cmEmbedWholeProfile			= $00000000;
	cmEmbedProfileIdentifier	= $00000001;

	{	 Commands for CMFlattenUPP() 	}
	cmOpenReadSpool				= 1;
	cmOpenWriteSpool			= 2;
	cmReadSpool					= 3;
	cmWriteSpool				= 4;
	cmCloseSpool				= 5;

	{	 Commands for CMAccessUPP() 	}
	cmOpenReadAccess			= 1;
	cmOpenWriteAccess			= 2;
	cmReadAccess				= 3;
	cmWriteAccess				= 4;
	cmCloseAccess				= 5;
	cmCreateNewAccess			= 6;
	cmAbortWriteAccess			= 7;
	cmBeginAccess				= 8;
	cmEndAccess					= 9;


	{	 Use types for CMGet/SetDefaultProfileByUse() 	}
	cmInputUse					= 'inpt';
	cmOutputUse					= 'outp';
	cmDisplayUse				= 'dply';
	cmProofUse					= 'pruf';


	{	 Union of 1.0 and 2.0 profile header variants 	}

TYPE
	CMAppleProfileHeaderPtr = ^CMAppleProfileHeader;
	CMAppleProfileHeader = RECORD
		CASE INTEGER OF
		0: (
			cm1:				CMHeader;
			);
		1: (
			cm2:				CM2Header;
			);
	END;

	{	 CWConcatColorWorld() definitions 	}
	CMConcatProfileSetPtr = ^CMConcatProfileSet;
	CMConcatProfileSet = RECORD
		keyIndex:				UInt16;									{  Zero-based  }
		count:					UInt16;									{  Min 1  }
		profileSet:				ARRAY [0..0] OF CMProfileRef;			{  Variable. Ordered from Source -> Dest  }
	END;

	{	 NCWConcatColorWorld() definitions 	}
	NCMConcatProfileSpecPtr = ^NCMConcatProfileSpec;
	NCMConcatProfileSpec = RECORD
		renderingIntent:		UInt32;									{  renderingIntent override  }
		transformTag:			UInt32;									{  transform enumerations defined below  }
		profile:				CMProfileRef;							{  profile  }
	END;

	NCMConcatProfileSetPtr = ^NCMConcatProfileSet;
	NCMConcatProfileSet = RECORD
		cmm:					OSType;									{  e.g. 'KCMS', 'appl', ...  uniquely ids the cmm, or 0000  }
		flags:					UInt32;									{  specify quality, lookup only, no gamut checking ...  }
		flagsMask:				UInt32;									{  which bits of 'flags' to use to override profile  }
		profileCount:			UInt32;									{  how many ProfileSpecs in the following set  }
		profileSpecs:			ARRAY [0..0] OF NCMConcatProfileSpec;	{  Variable. Ordered from Source -> Dest  }
	END;


CONST
	kNoTransform				= 0;							{  Not used  }
	kUseAtoB					= 1;							{  Use 'A2B*' tag from this profile or equivalent  }
	kUseBtoA					= 2;							{  Use 'B2A*' tag from this profile or equivalent  }
	kUseBtoB					= 3;							{  Use 'pre*' tag from this profile or equivalent  }
																{  For typical device profiles the following synonyms may be useful  }
	kDeviceToPCS				= 1;							{  Device Dependent to Device Independent  }
	kPCSToDevice				= 2;							{  Device Independent to Device Dependent  }
	kPCSToPCS					= 3;							{  Independent, through device's gamut  }
	kUseProfileIntent			= $FFFFFFFF;					{  For renderingIntent in NCMConcatProfileSpec     }


	{	 ColorSync color data types 	}

TYPE
	CMRGBColorPtr = ^CMRGBColor;
	CMRGBColor = RECORD
		red:					UInt16;									{  0..65535  }
		green:					UInt16;
		blue:					UInt16;
	END;

	CMCMYKColorPtr = ^CMCMYKColor;
	CMCMYKColor = RECORD
		cyan:					UInt16;									{  0..65535  }
		magenta:				UInt16;
		yellow:					UInt16;
		black:					UInt16;
	END;

	CMCMYColorPtr = ^CMCMYColor;
	CMCMYColor = RECORD
		cyan:					UInt16;									{  0..65535  }
		magenta:				UInt16;
		yellow:					UInt16;
	END;

	CMHLSColorPtr = ^CMHLSColor;
	CMHLSColor = RECORD
		hue:					UInt16;									{  0..65535. Fraction of circle. Red at 0  }
		lightness:				UInt16;									{  0..65535  }
		saturation:				UInt16;									{  0..65535  }
	END;

	CMHSVColorPtr = ^CMHSVColor;
	CMHSVColor = RECORD
		hue:					UInt16;									{  0..65535. Fraction of circle. Red at 0  }
		saturation:				UInt16;									{  0..65535  }
		value:					UInt16;									{  0..65535  }
	END;

	CMLabColorPtr = ^CMLabColor;
	CMLabColor = RECORD
		L:						UInt16;									{  0..65535 maps to 0..100  }
		a:						UInt16;									{  0..65535 maps to -128..127.996  }
		b:						UInt16;									{  0..65535 maps to -128..127.996  }
	END;

	CMLuvColorPtr = ^CMLuvColor;
	CMLuvColor = RECORD
		L:						UInt16;									{  0..65535 maps to 0..100  }
		u:						UInt16;									{  0..65535 maps to -128..127.996  }
		v:						UInt16;									{  0..65535 maps to -128..127.996  }
	END;

	CMYxyColorPtr = ^CMYxyColor;
	CMYxyColor = RECORD
		capY:					UInt16;									{  0..65535 maps to 0..1  }
		x:						UInt16;									{  0..65535 maps to 0..1  }
		y:						UInt16;									{  0..65535 maps to 0..1  }
	END;

	CMGrayColorPtr = ^CMGrayColor;
	CMGrayColor = RECORD
		gray:					UInt16;									{  0..65535  }
	END;

	CMMultichannel5ColorPtr = ^CMMultichannel5Color;
	CMMultichannel5Color = RECORD
		components:				PACKED ARRAY [0..4] OF UInt8;			{  0..255  }
	END;

	CMMultichannel6ColorPtr = ^CMMultichannel6Color;
	CMMultichannel6Color = RECORD
		components:				PACKED ARRAY [0..5] OF UInt8;			{  0..255  }
	END;

	CMMultichannel7ColorPtr = ^CMMultichannel7Color;
	CMMultichannel7Color = RECORD
		components:				PACKED ARRAY [0..6] OF UInt8;			{  0..255  }
	END;

	CMMultichannel8ColorPtr = ^CMMultichannel8Color;
	CMMultichannel8Color = RECORD
		components:				PACKED ARRAY [0..7] OF UInt8;			{  0..255  }
	END;

	CMNamedColorPtr = ^CMNamedColor;
	CMNamedColor = RECORD
		namedColorIndex:		UInt32;									{  0..a lot  }
	END;

	CMColorPtr = ^CMColor;
	CMColor = RECORD
		CASE INTEGER OF
		0: (
			rgb:				CMRGBColor;
			);
		1: (
			hsv:				CMHSVColor;
			);
		2: (
			hls:				CMHLSColor;
			);
		3: (
			XYZ:				CMXYZColor;
			);
		4: (
			Lab:				CMLabColor;
			);
		5: (
			Luv:				CMLuvColor;
			);
		6: (
			Yxy:				CMYxyColor;
			);
		7: (
			cmyk:				CMCMYKColor;
			);
		8: (
			cmy:				CMCMYColor;
			);
		9: (
			gray:				CMGrayColor;
			);
		10: (
			mc5:				CMMultichannel5Color;
			);
		11: (
			mc6:				CMMultichannel6Color;
			);
		12: (
			mc7:				CMMultichannel7Color;
			);
		13: (
			mc8:				CMMultichannel8Color;
			);
		14: (
			namedColor:			CMNamedColor;
			);
	END;

	{	 GetIndexedProfile() search definition 	}
	CMProfileSearchRecordPtr = ^CMProfileSearchRecord;
	CMProfileSearchRecord = RECORD
		header:					CMHeader;
		fieldMask:				UInt32;
		reserved:				ARRAY [0..1] OF UInt32;
	END;

	CMProfileSearchRecordHandle			= ^CMProfileSearchRecordPtr;
	{	 CMNewProfileSearch() search definition 	}
	CMSearchRecordPtr = ^CMSearchRecord;
	CMSearchRecord = RECORD
		CMMType:				OSType;
		profileClass:			OSType;
		dataColorSpace:			OSType;
		profileConnectionSpace:	OSType;
		deviceManufacturer:		UInt32;
		deviceModel:			UInt32;
		deviceAttributes:		ARRAY [0..1] OF UInt32;
		profileFlags:			UInt32;
		searchMask:				UInt32;
		filter:					CMProfileFilterUPP;
	END;

	{	 CMMIterateUPP() structure 	}
	CMMInfoPtr = ^CMMInfo;
	CMMInfo = RECORD
		dataSize:				UInt32;									{  Size of this structure - compatibility }
		CMMType:				OSType;									{  Signature, e.g. 'appl', 'HDM ' or 'KCMS' }
		CMMMfr:					OSType;									{  Vendor, e.g. 'appl' }
		CMMVersion:				UInt32;									{  CMM version number }
		ASCIIName:				PACKED ARRAY [0..31] OF UInt8;			{  pascal string - name }
		ASCIIDesc:				PACKED ARRAY [0..255] OF UInt8;			{  pascal string - description or copyright }
		UniCodeNameCount:		UniCharCount;							{  count of UniChars in following array }
		UniCodeName:			ARRAY [0..31] OF UniChar;				{  the name in UniCode chars }
		UniCodeDescCount:		UniCharCount;							{  count of UniChars in following array }
		UniCodeDesc:			ARRAY [0..255] OF UniChar;				{  the description in UniCode chars }
	END;

	{	 GetCWInfo() structures 	}
	CMMInfoRecordPtr = ^CMMInfoRecord;
	CMMInfoRecord = RECORD
		CMMType:				OSType;
		CMMVersion:				LONGINT;
	END;

	CMCWInfoRecordPtr = ^CMCWInfoRecord;
	CMCWInfoRecord = RECORD
		cmmCount:				UInt32;
		cmmInfo:				ARRAY [0..1] OF CMMInfoRecord;
	END;

	{	 profile identifier structures 	}
	CMProfileIdentifierPtr = ^CMProfileIdentifier;
	CMProfileIdentifier = RECORD
		profileHeader:			CM2Header;
		calibrationDate:		CMDateTime;
		ASCIIProfileDescriptionLen: UInt32;
		ASCIIProfileDescription: SInt8;									{  variable length  }
	END;

	{	 colorspace masks 	}

CONST
	cmColorSpaceSpaceMask		= $0000003F;
	cmColorSpacePremulAlphaMask	= $00000040;
	cmColorSpaceAlphaMask		= $00000080;
	cmColorSpaceSpaceAndAlphaMask = $000000FF;
	cmColorSpacePackingMask		= $0000FF00;
	cmColorSpaceEncodingMask	= $000F0000;
	cmColorSpaceReservedMask	= $FFF00000;

	{	 packing formats 	}
	cmNoColorPacking			= $0000;
	cmWord5ColorPacking			= $0500;
	cmWord565ColorPacking		= $0600;
	cmLong8ColorPacking			= $0800;
	cmLong10ColorPacking		= $0A00;
	cmAlphaFirstPacking			= $1000;
	cmOneBitDirectPacking		= $0B00;
	cmAlphaLastPacking			= $0000;
	cm8_8ColorPacking			= $2800;
	cm16_8ColorPacking			= $2000;
	cm24_8ColorPacking			= $2100;
	cm32_8ColorPacking			= $0800;
	cm40_8ColorPacking			= $2200;
	cm48_8ColorPacking			= $2300;
	cm56_8ColorPacking			= $2400;
	cm64_8ColorPacking			= $2500;
	cm32_16ColorPacking			= $2600;
	cm48_16ColorPacking			= $2900;
	cm64_16ColorPacking			= $2A00;
	cm32_32ColorPacking			= $2700;
	cmLittleEndianPacking		= $4000;
	cmReverseChannelPacking		= $8000;

	{	 channel encoding format 	}
	cmSRGB16ChannelEncoding		= $00010000;					{  used for sRGB64 encoding ( ±3.12 format) }

	{	 general colorspaces 	}
	cmNoSpace					= $0000;
	cmRGBSpace					= $0001;
	cmCMYKSpace					= $0002;
	cmHSVSpace					= $0003;
	cmHLSSpace					= $0004;
	cmYXYSpace					= $0005;
	cmXYZSpace					= $0006;
	cmLUVSpace					= $0007;
	cmLABSpace					= $0008;
	cmReservedSpace1			= $0009;
	cmGraySpace					= $000A;
	cmReservedSpace2			= $000B;
	cmGamutResultSpace			= $000C;
	cmNamedIndexedSpace			= $0010;
	cmMCFiveSpace				= $0011;
	cmMCSixSpace				= $0012;
	cmMCSevenSpace				= $0013;
	cmMCEightSpace				= $0014;
	cmAlphaPmulSpace			= $0040;
	cmAlphaSpace				= $0080;
	cmRGBASpace					= $0081;
	cmGrayASpace				= $008A;
	cmRGBAPmulSpace				= $00C1;
	cmGrayAPmulSpace			= $00CA;

	{	 supported CMBitmapColorSpaces - Each of the following is a 	}
	{	 combination of a general colospace and a packing formats. 	}
	{	 Each can also be or'd with cmReverseChannelPacking. 	}
	cmGray8Space				= $280A;
	cmGray16Space				= $000A;
	cmGray16LSpace				= $400A;
	cmGrayA16Space				= $208A;
	cmGrayA32Space				= $008A;
	cmGrayA32LSpace				= $408A;
	cmGrayA16PmulSpace			= $20CA;
	cmGrayA32PmulSpace			= $00CA;
	cmGrayA32LPmulSpace			= $40CA;
	cmRGB16Space				= $0501;
	cmRGB16LSpace				= $4501;
	cmRGB565Space				= $0601;
	cmRGB565LSpace				= $4601;
	cmRGB24Space				= $2101;
	cmRGB32Space				= $0801;
	cmRGB48Space				= $2901;
	cmRGB48LSpace				= $6901;
	cmARGB32Space				= $1881;
	cmARGB64Space				= $3A81;
	cmARGB64LSpace				= $7A81;
	cmRGBA32Space				= $0881;
	cmRGBA64Space				= $2A81;
	cmRGBA64LSpace				= $6A81;
	cmARGB32PmulSpace			= $18C1;
	cmARGB64PmulSpace			= $3AC1;
	cmARGB64LPmulSpace			= $7AC1;
	cmRGBA32PmulSpace			= $08C1;
	cmRGBA64PmulSpace			= $2AC1;
	cmRGBA64LPmulSpace			= $6AC1;
	cmCMYK32Space				= $0802;
	cmCMYK64Space				= $2A02;
	cmCMYK64LSpace				= $6A02;
	cmHSV32Space				= $0A03;
	cmHLS32Space				= $0A04;
	cmYXY32Space				= $0A05;
	cmXYZ24Space				= $2106;
	cmXYZ32Space				= $0A06;
	cmXYZ48Space				= $2906;
	cmXYZ48LSpace				= $6906;
	cmLUV32Space				= $0A07;
	cmLAB24Space				= $2108;
	cmLAB32Space				= $0A08;
	cmLAB48Space				= $2908;
	cmLAB48LSpace				= $6908;
	cmGamutResult1Space			= $0B0C;
	cmNamedIndexed32Space		= $2710;
	cmNamedIndexed32LSpace		= $6710;
	cmMCFive8Space				= $2211;
	cmMCSix8Space				= $2312;
	cmMCSeven8Space				= $2413;
	cmMCEight8Space				= $2514;



TYPE
	CMBitmapColorSpace					= UInt32;
	CMBitmapPtr = ^CMBitmap;
	CMBitmap = RECORD
		image:					CStringPtr;
		width:					LONGINT;
		height:					LONGINT;
		rowBytes:				LONGINT;
		pixelSize:				LONGINT;
		space:					CMBitmapColorSpace;
		user1:					LONGINT;
		user2:					LONGINT;
	END;

	{	 CMConvertXYZToXYZ() definitions 	}
	CMChromaticAdaptation				= UInt32;

CONST
	cmUseDefaultChromaticAdaptation = 0;
	cmLinearChromaticAdaptation	= 1;
	cmVonKriesChromaticAdaptation = 2;
	cmBradfordChromaticAdaptation = 3;


	{	 Profile Locations 	}
	CS_MAX_PATH					= 256;

	cmNoProfileBase				= 0;
	cmFileBasedProfile			= 1;
	cmHandleBasedProfile		= 2;
	cmPtrBasedProfile			= 3;
	cmProcedureBasedProfile		= 4;
	cmPathBasedProfile			= 5;
	cmBufferBasedProfile		= 6;


TYPE
	CMFileLocationPtr = ^CMFileLocation;
	CMFileLocation = RECORD
		spec:					FSSpec;
	END;

	CMHandleLocationPtr = ^CMHandleLocation;
	CMHandleLocation = RECORD
		h:						Handle;
	END;

	CMPtrLocationPtr = ^CMPtrLocation;
	CMPtrLocation = RECORD
		p:						Ptr;
	END;

	CMProcedureLocationPtr = ^CMProcedureLocation;
	CMProcedureLocation = RECORD
		proc:					CMProfileAccessUPP;
		refCon:					Ptr;
	END;

	CMPathLocationPtr = ^CMPathLocation;
	CMPathLocation = RECORD
		path:					PACKED ARRAY [0..255] OF CHAR;
	END;

	CMBufferLocationPtr = ^CMBufferLocation;
	CMBufferLocation = RECORD
		buffer:					Ptr;
		size:					UInt32;
	END;

	CMProfLocPtr = ^CMProfLoc;
	CMProfLoc = RECORD
		CASE INTEGER OF
		0: (
			fileLoc:			CMFileLocation;
			);
		1: (
			handleLoc:			CMHandleLocation;
			);
		2: (
			ptrLoc:				CMPtrLocation;
			);
		3: (
			procLoc:			CMProcedureLocation;
			);
		4: (
			pathLoc:			CMPathLocation;
			);
		5: (
			bufferLoc:			CMBufferLocation;
			);
	END;

	CMProfileLocationPtr = ^CMProfileLocation;
	CMProfileLocation = RECORD
		locType:				INTEGER;
		u:						CMProfLoc;
	END;

{$IFC TARGET_OS_MAC }

CONST
	cmOriginalProfileLocationSize = 72;
	cmCurrentProfileLocationSize = 258;

{$ELSEC}

CONST
	cmOriginalProfileLocationSize = 258;
	cmCurrentProfileLocationSize = 258;

{$ENDC}  {TARGET_OS_MAC}

	{	 Typedef for Profile MD5 message digest 	}

TYPE
	CMProfileMD5						= PACKED ARRAY [0..15] OF UInt8;
	CMProfileMD5Ptr						= ^CMProfileMD5;
	{	 Struct and enums used for Profile iteration 	}

CONST
	cmProfileIterateDataVersion1 = $00010000;
	cmProfileIterateDataVersion2 = $00020000;					{  Added makeAndModel }
	cmProfileIterateDataVersion3 = $00030000;					{  Added MD5 digest }


TYPE
	CMProfileIterateDataPtr = ^CMProfileIterateData;
	CMProfileIterateData = RECORD
		dataVersion:			UInt32;									{  cmProfileIterateDataVersion2  }
		header:					CM2Header;
		code:					ScriptCode;
		name:					Str255;
		location:				CMProfileLocation;
		uniCodeNameCount:		UniCharCount;
		uniCodeName:			UniCharPtr;
		asciiName:				Ptr;
		makeAndModel:			CMMakeAndModelPtr;
		digest:					CMProfileMD5Ptr;
	END;

	{	 Caller-supplied callback function for Profile & CMM iteration 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CMProfileIterateProcPtr = FUNCTION(VAR iterateData: CMProfileIterateData; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMProfileIterateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CMMIterateProcPtr = FUNCTION(VAR iterateData: CMMInfo; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CMMIterateProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CMProfileIterateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMProfileIterateUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CMMIterateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CMMIterateUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppCMProfileIterateProcInfo = $000003E0;
	uppCMMIterateProcInfo = $000003E0;
	{
	 *  NewCMProfileIterateUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in 3.0 and later
	 	}
FUNCTION NewCMProfileIterateUPP(userRoutine: CMProfileIterateProcPtr): CMProfileIterateUPP; { old name was NewCMProfileIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCMMIterateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NewCMMIterateUPP(userRoutine: CMMIterateProcPtr): CMMIterateUPP; { old name was NewCMMIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeCMProfileIterateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMProfileIterateUPP(userUPP: CMProfileIterateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCMMIterateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE DisposeCMMIterateUPP(userUPP: CMMIterateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeCMProfileIterateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMProfileIterateUPP(VAR iterateData: CMProfileIterateData; refCon: UNIV Ptr; userRoutine: CMProfileIterateUPP): OSErr; { old name was CallCMProfileIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCMMIterateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION InvokeCMMIterateUPP(VAR iterateData: CMMInfo; refCon: UNIV Ptr; userRoutine: CMMIterateUPP): OSErr; { old name was CallCMMIterateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{ Profile file and element access }
{
 *  CMNewProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMNewProfile(VAR prof: CMProfileRef; {CONST}VAR theProfile: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001B, $ABEE;
	{$ENDC}

{
 *  CMOpenProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMOpenProfile(VAR prof: CMProfileRef; {CONST}VAR theProfile: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001C, $ABEE;
	{$ENDC}

{
 *  CMCloseProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMCloseProfile(prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $001D, $ABEE;
	{$ENDC}

{
 *  CMUpdateProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMUpdateProfile(prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0034, $ABEE;
	{$ENDC}

{
 *  CMCopyProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMCopyProfile(VAR targetProf: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; srcProf: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0025, $ABEE;
	{$ENDC}

{
 *  CMValidateProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMValidateProfile(prof: CMProfileRef; VAR valid: BOOLEAN; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0026, $ABEE;
	{$ENDC}

{
 *  CMGetProfileLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetProfileLocation(prof: CMProfileRef; VAR theProfile: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003C, $ABEE;
	{$ENDC}

{
 *  NCMGetProfileLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NCMGetProfileLocation(prof: CMProfileRef; VAR theProfile: CMProfileLocation; VAR locationSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0059, $ABEE;
	{$ENDC}

{
 *  CMFlattenProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMFlattenProfile(prof: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0031, $ABEE;
	{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC CALL_NOT_IN_CARBON }
{
 *  CMUnflattenProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMUnflattenProfile(VAR resultFileSpec: FSSpec; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0032, $ABEE;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}

{
 *  CMGetProfileHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetProfileHeader(prof: CMProfileRef; VAR header: CMAppleProfileHeader): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0039, $ABEE;
	{$ENDC}

{
 *  CMSetProfileHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetProfileHeader(prof: CMProfileRef; {CONST}VAR header: CMAppleProfileHeader): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003A, $ABEE;
	{$ENDC}

{
 *  CMProfileElementExists()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMProfileElementExists(prof: CMProfileRef; tag: OSType; VAR found: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $001E, $ABEE;
	{$ENDC}

{
 *  CMCountProfileElements()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMCountProfileElements(prof: CMProfileRef; VAR elementCount: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001F, $ABEE;
	{$ENDC}

{
 *  CMGetProfileElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetProfileElement(prof: CMProfileRef; tag: OSType; VAR elementSize: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0020, $ABEE;
	{$ENDC}

{
 *  CMSetProfileElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetProfileElement(prof: CMProfileRef; tag: OSType; elementSize: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0023, $ABEE;
	{$ENDC}

{
 *  CMSetProfileElementSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetProfileElementSize(prof: CMProfileRef; tag: OSType; elementSize: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0038, $ABEE;
	{$ENDC}

{
 *  CMSetProfileElementReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetProfileElementReference(prof: CMProfileRef; elementTag: OSType; referenceTag: OSType): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0035, $ABEE;
	{$ENDC}

{
 *  CMGetPartialProfileElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetPartialProfileElement(prof: CMProfileRef; tag: OSType; offset: UInt32; VAR byteCount: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0036, $ABEE;
	{$ENDC}

{
 *  CMSetPartialProfileElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetPartialProfileElement(prof: CMProfileRef; tag: OSType; offset: UInt32; byteCount: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0037, $ABEE;
	{$ENDC}

{
 *  CMGetIndProfileElementInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetIndProfileElementInfo(prof: CMProfileRef; index: UInt32; VAR tag: OSType; VAR elementSize: UInt32; VAR refs: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0021, $ABEE;
	{$ENDC}

{
 *  CMGetIndProfileElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetIndProfileElement(prof: CMProfileRef; index: UInt32; VAR elementSize: UInt32; elementData: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0022, $ABEE;
	{$ENDC}

{
 *  CMRemoveProfileElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMRemoveProfileElement(prof: CMProfileRef; tag: OSType): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0024, $ABEE;
	{$ENDC}

{
 *  CMGetScriptProfileDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetScriptProfileDescription(prof: CMProfileRef; VAR name: Str255; VAR code: ScriptCode): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $003E, $ABEE;
	{$ENDC}

{
 *  CMGetProfileDescriptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetProfileDescriptions(prof: CMProfileRef; aName: CStringPtr; VAR aCount: UInt32; VAR mName: Str255; VAR mCode: ScriptCode; VAR uName: UniChar; VAR uCount: UniCharCount): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001A, $0067, $ABEE;
	{$ENDC}

{
 *  CMSetProfileDescriptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetProfileDescriptions(prof: CMProfileRef; aName: ConstCStringPtr; aCount: UInt32; mName: Str255; mCode: ScriptCode; {CONST}VAR uName: UniChar; uCount: UniCharCount): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001A, $0068, $ABEE;
	{$ENDC}

{
 *  CMCopyProfileLocalizedStringDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMCopyProfileLocalizedStringDictionary(prof: CMProfileRef; tag: OSType; VAR theDict: CFDictionaryRef): CMError;

{
 *  CMSetProfileLocalizedStringDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetProfileLocalizedStringDictionary(prof: CMProfileRef; tag: OSType; theDict: CFDictionaryRef): CMError;

{
 *  CMCopyProfileLocalizedString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMCopyProfileLocalizedString(prof: CMProfileRef; tag: OSType; reqLocale: CFStringRef; VAR locale: CFStringRef; VAR str: CFStringRef): CMError;

{
 *  CMCloneProfileRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMCloneProfileRef(prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0042, $ABEE;
	{$ENDC}

{
 *  CMGetProfileRefCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetProfileRefCount(prof: CMProfileRef; VAR count: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0043, $ABEE;
	{$ENDC}

{
 *  CMProfileModified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMProfileModified(prof: CMProfileRef; VAR modified: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0044, $ABEE;
	{$ENDC}

{
 *  CMGetProfileMD5()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetProfileMD5(prof: CMProfileRef; VAR digest: CMProfileMD5): CMError;


{ named Color access functions }
{
 *  CMGetNamedColorInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetNamedColorInfo(prof: CMProfileRef; VAR deviceChannels: UInt32; VAR deviceColorSpace: OSType; VAR PCSColorSpace: OSType; VAR count: UInt32; prefix: StringPtr; suffix: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001C, $0046, $ABEE;
	{$ENDC}

{
 *  CMGetNamedColorValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetNamedColorValue(prof: CMProfileRef; name: StringPtr; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0047, $ABEE;
	{$ENDC}

{
 *  CMGetIndNamedColorValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetIndNamedColorValue(prof: CMProfileRef; index: UInt32; VAR deviceColor: CMColor; VAR PCSColor: CMColor): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0048, $ABEE;
	{$ENDC}

{
 *  CMGetNamedColorIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetNamedColorIndex(prof: CMProfileRef; name: StringPtr; VAR index: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0049, $ABEE;
	{$ENDC}

{
 *  CMGetNamedColorName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetNamedColorName(prof: CMProfileRef; index: UInt32; name: StringPtr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $004A, $ABEE;
	{$ENDC}


{ General-purpose matching functions }
{
 *  NCWNewColorWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NCWNewColorWorld(VAR cw: CMWorldRef; src: CMProfileRef; dst: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0014, $ABEE;
	{$ENDC}

{
 *  CWConcatColorWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CWConcatColorWorld(VAR cw: CMWorldRef; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0015, $ABEE;
	{$ENDC}

{
 *  CWNewLinkProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CWNewLinkProfile(VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: CMConcatProfileSet): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0033, $ABEE;
	{$ENDC}

{
 *  NCWConcatColorWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NCWConcatColorWorld(VAR cw: CMWorldRef; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0061, $ABEE;
	{$ENDC}

{
 *  NCWNewLinkProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NCWNewLinkProfile(VAR prof: CMProfileRef; {CONST}VAR targetLocation: CMProfileLocation; VAR profileSet: NCMConcatProfileSet; proc: CMConcatCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0062, $ABEE;
	{$ENDC}

{
 *  CWDisposeColorWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE CWDisposeColorWorld(cw: CMWorldRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0001, $ABEE;
	{$ENDC}

{
 *  CWMatchColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CWMatchColors(cw: CMWorldRef; VAR myColors: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0002, $ABEE;
	{$ENDC}

{
 *  CWCheckColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CWCheckColors(cw: CMWorldRef; VAR myColors: CMColor; count: UInt32; VAR result: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0003, $ABEE;
	{$ENDC}

{
 *  CWMatchBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CWMatchBitmap(cw: CMWorldRef; VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR matchedBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $002C, $ABEE;
	{$ENDC}

{
 *  CWCheckBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CWCheckBitmap(cw: CMWorldRef; {CONST}VAR bitmap: CMBitmap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitmap: CMBitmap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $002D, $ABEE;
	{$ENDC}

{ Quickdraw-specific matching }
{$IFC TARGET_OS_MAC AND _DECLARE_CS_QD_API_ }
{
 *  CWMatchPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION CWMatchPixMap(cw: CMWorldRef; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0004, $ABEE;
	{$ENDC}

{
 *  CWCheckPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION CWCheckPixMap(cw: CMWorldRef; VAR myPixMap: PixMap; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr; VAR resultBitMap: BitMap): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0007, $ABEE;
	{$ENDC}

{
 *  NCMBeginMatching()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION NCMBeginMatching(src: CMProfileRef; dst: CMProfileRef; VAR myRef: CMMatchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0016, $ABEE;
	{$ENDC}

{
 *  CMEndMatching()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE CMEndMatching(myRef: CMMatchRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000B, $ABEE;
	{$ENDC}

{
 *  NCMDrawMatchedPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE NCMDrawMatchedPicture(myPicture: PicHandle; dst: CMProfileRef; VAR myRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0017, $ABEE;
	{$ENDC}

{
 *  CMEnableMatchingComment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE CMEnableMatchingComment(enableIt: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0002, $000D, $ABEE;
	{$ENDC}

{
 *  NCMUseProfileComment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION NCMUseProfileComment(prof: CMProfileRef; flags: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $003B, $ABEE;
	{$ENDC}

{$ENDC}

{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  CWMatchHBITMAP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CWMatchHBITMAP(cw: CMWorldRef; hBitmap: HBITMAP; progressProc: CMBitmapCallBackUPP; refCon: UNIV Ptr): CMError;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}

{
 *  CMCreateProfileIdentifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMCreateProfileIdentifier(prof: CMProfileRef; ident: CMProfileIdentifierPtr; VAR size: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0041, $ABEE;
	{$ENDC}


{ System Profile access }
{
 *  CMGetSystemProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetSystemProfile(VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0018, $ABEE;
	{$ENDC}

{
 *  CMSetSystemProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetSystemProfile({CONST}VAR profileFileSpec: FSSpec): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0019, $ABEE;
	{$ENDC}

{
 *  NCMSetSystemProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NCMSetSystemProfile({CONST}VAR profLoc: CMProfileLocation): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0064, $ABEE;
	{$ENDC}

{
 *  CMGetDefaultProfileBySpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetDefaultProfileBySpace(dataColorSpace: OSType; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005A, $ABEE;
	{$ENDC}

{
 *  CMSetDefaultProfileBySpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetDefaultProfileBySpace(dataColorSpace: OSType; prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005B, $ABEE;
	{$ENDC}

{$IFC TARGET_OS_MAC }
{
 *  CMGetProfileByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetProfileByAVID(theID: CMDisplayIDType; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005C, $ABEE;
	{$ENDC}

{
 *  CMSetProfileByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetProfileByAVID(theID: CMDisplayIDType; prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005D, $ABEE;
	{$ENDC}

{
 *  CMGetGammaByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetGammaByAVID(theID: CMDisplayIDType; VAR gamma: CMVideoCardGamma; VAR size: UInt32): CMError;

{
 *  CMSetGammaByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetGammaByAVID(theID: CMDisplayIDType; VAR gamma: CMVideoCardGamma): CMError;

{$ENDC}  {TARGET_OS_MAC}

{ Profile access by Use }
{
 *  CMGetDefaultProfileByUse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetDefaultProfileByUse(use: OSType; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0069, $ABEE;
	{$ENDC}

{
 *  CMSetDefaultProfileByUse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSetDefaultProfileByUse(use: OSType; prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0079, $ABEE;
	{$ENDC}

{ Profile Management }
{
 *  CMNewProfileSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMNewProfileSearch(VAR searchSpec: CMSearchRecord; refCon: UNIV Ptr; VAR count: UInt32; VAR searchResult: CMProfileSearchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0027, $ABEE;
	{$ENDC}

{
 *  CMUpdateProfileSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMUpdateProfileSearch(search: CMProfileSearchRef; refCon: UNIV Ptr; VAR count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0028, $ABEE;
	{$ENDC}

{
 *  CMDisposeProfileSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
PROCEDURE CMDisposeProfileSearch(search: CMProfileSearchRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0029, $ABEE;
	{$ENDC}

{
 *  CMSearchGetIndProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSearchGetIndProfile(search: CMProfileSearchRef; index: UInt32; VAR prof: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $002A, $ABEE;
	{$ENDC}

{
 *  CMSearchGetIndProfileFileSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMSearchGetIndProfileFileSpec(search: CMProfileSearchRef; index: UInt32; VAR profileFile: FSSpec): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $002B, $ABEE;
	{$ENDC}

{
 *  CMProfileIdentifierFolderSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMProfileIdentifierFolderSearch(ident: CMProfileIdentifierPtr; VAR matchedCount: UInt32; VAR searchResult: CMProfileSearchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $003F, $ABEE;
	{$ENDC}

{
 *  CMProfileIdentifierListSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMProfileIdentifierListSearch(ident: CMProfileIdentifierPtr; VAR profileList: CMProfileRef; listSize: UInt32; VAR matchedCount: UInt32; VAR matchedList: CMProfileRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0040, $ABEE;
	{$ENDC}

{
 *  CMIterateColorSyncFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMIterateColorSyncFolder(proc: CMProfileIterateUPP; VAR seed: UInt32; VAR count: UInt32; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0058, $ABEE;
	{$ENDC}

{
 *  NCMUnflattenProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION NCMUnflattenProfile(VAR targetLocation: CMProfileLocation; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0065, $ABEE;
	{$ENDC}

{ Utilities }
{$IFC TARGET_OS_MAC }
{
 *  CMGetColorSyncFolderSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetColorSyncFolderSpec(vRefNum: INTEGER; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0011, $ABEE;
	{$ENDC}

{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_WIN32 OR TARGET_OS_UNIX }
{$IFC CALL_NOT_IN_CARBON }
{
 *  CMGetColorSyncFolderPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetColorSyncFolderPath(createFolder: BOOLEAN; lpBuffer: CStringPtr; uSize: UInt32): CMError;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
 *  CMGetCWInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetCWInfo(cw: CMWorldRef; VAR info: CMCWInfoRecord): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $001A, $ABEE;
	{$ENDC}

{$IFC TARGET_API_MAC_OS8 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  CMConvertProfile2to1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMConvertProfile2to1(profv2: CMProfileRef; VAR profv1: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0045, $ABEE;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_API_MAC_OS8}

{
 *  CMGetPreferredCMM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetPreferredCMM(VAR cmmType: OSType; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $005E, $ABEE;
	{$ENDC}

{
 *  CMIterateCMMInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMIterateCMMInfo(proc: CMMIterateUPP; VAR count: UInt32; refCon: UNIV Ptr): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0063, $ABEE;
	{$ENDC}

{
 *  CMGetColorSyncVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetColorSyncVersion(VAR version: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0066, $ABEE;
	{$ENDC}

{
 *  CMLaunchControlPanel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMLaunchControlPanel(flags: UInt32): CMError;

{ ColorSpace conversion functions }
{
 *  CMConvertXYZToLab()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertXYZToLab({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004B, $ABEE;
	{$ENDC}

{
 *  CMConvertLabToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertLabToXYZ({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004C, $ABEE;
	{$ENDC}

{
 *  CMConvertXYZToLuv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertXYZToLuv({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004D, $ABEE;
	{$ENDC}

{
 *  CMConvertLuvToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertLuvToXYZ({CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $004E, $ABEE;
	{$ENDC}

{
 *  CMConvertXYZToYxy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertXYZToYxy({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $004F, $ABEE;
	{$ENDC}

{
 *  CMConvertYxyToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertYxyToXYZ({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0050, $ABEE;
	{$ENDC}

{
 *  CMConvertRGBToHLS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertRGBToHLS({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0051, $ABEE;
	{$ENDC}

{
 *  CMConvertHLSToRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertHLSToRGB({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0052, $ABEE;
	{$ENDC}

{
 *  CMConvertRGBToHSV()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertRGBToHSV({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0053, $ABEE;
	{$ENDC}

{
 *  CMConvertHSVToRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertHSVToRGB({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0054, $ABEE;
	{$ENDC}

{
 *  CMConvertRGBToGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertRGBToGray({CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0055, $ABEE;
	{$ENDC}

{
 *  CMConvertXYZToFixedXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertXYZToFixedXYZ({CONST}VAR src: CMXYZColor; VAR dst: CMFixedXYZColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0056, $ABEE;
	{$ENDC}

{
 *  CMConvertFixedXYZToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMConvertFixedXYZToXYZ({CONST}VAR src: CMFixedXYZColor; VAR dst: CMXYZColor; count: UInt32): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0057, $ABEE;
	{$ENDC}

{
 *  CMConvertXYZToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMConvertXYZToXYZ({CONST}VAR src: CMColor; {CONST}VAR srcIlluminant: CMXYZColor; VAR dst: CMColor; {CONST}VAR dstIlluminant: CMXYZColor; method: CMChromaticAdaptation; count: UInt32): CMError;


{ PS-related }
{
 *  CMGetPS2ColorSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetPS2ColorSpace(srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $002E, $ABEE;
	{$ENDC}

{
 *  CMGetPS2ColorRenderingIntent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetPS2ColorRenderingIntent(srcProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $002F, $ABEE;
	{$ENDC}

{
 *  CMGetPS2ColorRendering()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetPS2ColorRendering(srcProf: CMProfileRef; dstProf: CMProfileRef; flags: UInt32; proc: CMFlattenUPP; refCon: UNIV Ptr; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $0030, $ABEE;
	{$ENDC}

{
 *  CMGetPS2ColorRenderingVMSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in 3.0 and later
 }
FUNCTION CMGetPS2ColorRenderingVMSize(srcProf: CMProfileRef; dstProf: CMProfileRef; VAR vmSize: UInt32; VAR preferredCMMnotfound: BOOLEAN): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $003D, $ABEE;
	{$ENDC}


{ ColorSync 1.0 functions which have parallel 2.0 counterparts }
{$IFC TARGET_API_MAC_OS8 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  CWNewColorWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CWNewColorWorld(VAR cw: CMWorldRef; src: CMProfileHandle; dst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0000, $ABEE;
	{$ENDC}

{
 *  ConcatenateProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ConcatenateProfiles(thru: CMProfileHandle; dst: CMProfileHandle; VAR newDst: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $000C, $ABEE;
	{$ENDC}

{
 *  CMBeginMatching()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMBeginMatching(src: CMProfileHandle; dst: CMProfileHandle; VAR myRef: CMMatchRef): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $000A, $ABEE;
	{$ENDC}

{
 *  CMDrawMatchedPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMDrawMatchedPicture(myPicture: PicHandle; dst: CMProfileHandle; VAR myRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0009, $ABEE;
	{$ENDC}

{
 *  CMUseProfileComment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMUseProfileComment(profile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0008, $ABEE;
	{$ENDC}

{
 *  CMGetProfileName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMGetProfileName(myProfile: CMProfileHandle; VAR IStringResult: CMIString);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000E, $ABEE;
	{$ENDC}

{
 *  CMGetProfileAdditionalDataOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetProfileAdditionalDataOffset(myProfile: CMProfileHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000F, $ABEE;
	{$ENDC}


{ ProfileResponder definitions }
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	cmSystemDevice				= 'sys ';
	cmGDevice					= 'gdev';

	{	 ProfileResponder functions 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GetProfile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION GetProfile(deviceType: OSType; refNum: LONGINT; aProfile: CMProfileHandle; VAR returnedProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0005, $ABEE;
	{$ENDC}

{
 *  SetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetProfile(deviceType: OSType; refNum: LONGINT; newProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0006, $ABEE;
	{$ENDC}

{
 *  SetProfileDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetProfileDescription(deviceType: OSType; refNum: LONGINT; deviceData: LONGINT; hProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0010, $ABEE;
	{$ENDC}

{
 *  GetIndexedProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetIndexedProfile(deviceType: OSType; refNum: LONGINT; search: CMProfileSearchRecordHandle; VAR returnProfile: CMProfileHandle; VAR index: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0012, $ABEE;
	{$ENDC}

{
 *  DeleteDeviceProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DeleteDeviceProfile(deviceType: OSType; refNum: LONGINT; deleteMe: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0013, $ABEE;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OLDROUTINENAMES }
{ old constants }

TYPE
	CMFlattenProc						= CMFlattenProcPtr;
	CMBitmapCallBackProc				= CMBitmapCallBackProcPtr;
	CMProfileFilterProc					= CMProfileFilterProcPtr;

CONST
	qdSystemDevice				= 'sys ';
	qdGDevice					= 'gdev';


	kMatchCMMType				= $00000001;
	kMatchApplProfileVersion	= $00000002;
	kMatchDataType				= $00000004;
	kMatchDeviceType			= $00000008;
	kMatchDeviceManufacturer	= $00000010;
	kMatchDeviceModel			= $00000020;
	kMatchDeviceAttributes		= $00000040;
	kMatchFlags					= $00000080;
	kMatchOptions				= $00000100;
	kMatchWhite					= $00000200;
	kMatchBlack					= $00000400;

	{	 old types 	}

TYPE
	CMYKColor							= CMCMYKColor;
	CMYKColorPtr 						= ^CMYKColor;
	CWorld								= CMWorldRef;
	CMGamutResult						= ^LONGINT;
	{	 old functions 	}
{$ENDC}  {OLDROUTINENAMES}
{  Deprecated stuff }
{ PrGeneral parameter blocks }

CONST
	enableColorMatchingOp		= 12;
	registerProfileOp			= 13;


TYPE
	TEnableColorMatchingBlkPtr = ^TEnableColorMatchingBlk;
	TEnableColorMatchingBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fEnableIt:				BOOLEAN;
		filler:					SInt8;
	END;

	TRegisterProfileBlkPtr = ^TRegisterProfileBlk;
	TRegisterProfileBlk = RECORD
		iOpCode:				INTEGER;
		iError:					INTEGER;
		lReserved:				LONGINT;
		hPrint:					THPrint;
		fRegisterIt:			BOOLEAN;
		filler:					SInt8;
	END;

{$ENDC}  {TARGET_API_MAC_OS8}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMApplicationIncludes}

{$ENDC} {__CMAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
