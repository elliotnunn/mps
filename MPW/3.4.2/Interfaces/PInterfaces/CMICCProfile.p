{
 	File:		CMICCProfile.p
 
 	Contains:	Definitions for ColorSync 2.0 profile
 
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
 UNIT CMICCProfile;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMICCPROFILE__}
{$SETC __CMICCPROFILE__ := 1}

{$I+}
{$SETC CMICCProfileIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	cmCS2ProfileVersion			= $02000000;

{ Current Major version number }
	cmCurrentProfileMajorVersion = $02000000;

{ magic cookie number for anonymous file ID }
	cmMagicNumber				= 'acsp';

{ ColorSync profile version 1.0 }
	cmCS1ProfileVersion			= $00000100;

{**********************************************************************}
{************** ColorSync 2.0 profile specification *******************}
{**********************************************************************}
{ profile flags element values }
	cmEmbeddedProfile			= 0;							{ 0 is not embedded profile, 1 is embedded profile }
	cmEmbeddedUse				= 1;							{ 0 is to use anywhere, 1 is to use as embedded profile only }

{ data type element values }
	cmAsciiData					= 0;
	cmBinaryData				= 1;

{ rendering intent element values  }
	cmPerceptual				= 0;							{ Photographic images }
	cmRelativeColorimetric		= 1;							{ Logo Colors }
	cmSaturation				= 2;							{ Business graphics }
	cmAbsoluteColorimetric		= 3;							{ Logo Colors }

{ speed and quality flag options }
	cmNormalMode				= 0;							{ it uses the least significent two bits in the high word of flag }
	cmDraftMode					= 1;							{ it should be evaulated like this: right shift 16 bits first, mask off the }
	cmBestMode					= 2;							{ high 14 bits, and then compare with the enum to determine the option value }

{ device/media attributes element values  }
	cmReflective				= 0;							{ 0 is reflective media, 1 is transparency media }
	cmGlossy					= 1;							{ 0 is glossy, 1 is matte }

{ screen encodings  }
	cmPrtrDefaultScreens		= 0;							{ Use printer default screens.  0 is false, 1 is ture }
	cmLinesPer					= 1;							{ 0 is LinesPerCm, 1 is LinesPerInch }

{ 2.0 tag type information }
	cmNumHeaderElements			= 10;

{ public tags }
	cmAToB0Tag					= 'A2B0';
	cmAToB1Tag					= 'A2B1';
	cmAToB2Tag					= 'A2B2';
	cmBlueColorantTag			= 'bXYZ';
	cmBlueTRCTag				= 'bTRC';
	cmBToA0Tag					= 'B2A0';
	cmBToA1Tag					= 'B2A1';
	cmBToA2Tag					= 'B2A2';
	cmCalibrationDateTimeTag	= 'calt';
	cmCharTargetTag				= 'targ';
	cmCopyrightTag				= 'cprt';
	cmDeviceMfgDescTag			= 'dmnd';
	cmDeviceModelDescTag		= 'dmdd';
	cmGamutTag					= 'gamt';
	cmGrayTRCTag				= 'kTRC';
	cmGreenColorantTag			= 'gXYZ';
	cmGreenTRCTag				= 'gTRC';
	cmLuminanceTag				= 'lumi';
	cmMeasurementTag			= 'meas';
	cmMediaBlackPointTag		= 'bkpt';
	cmMediaWhitePointTag		= 'wtpt';
	cmNamedColorTag				= 'ncol';
	cmPreview0Tag				= 'pre0';
	cmPreview1Tag				= 'pre1';
	cmPreview2Tag				= 'pre2';
	cmProfileDescriptionTag		= 'desc';
	cmProfileSequenceDescTag	= 'pseq';
	cmPS2CRD0Tag				= 'psd0';
	cmPS2CRD1Tag				= 'psd1';
	cmPS2CRD2Tag				= 'psd2';
	cmPS2CRD3Tag				= 'psd3';
	cmPS2CSATag					= 'ps2s';
	cmPS2RenderingIntentTag		= 'ps2i';
	cmRedColorantTag			= 'rXYZ';
	cmRedTRCTag					= 'rTRC';
	cmScreeningDescTag			= 'scrd';
	cmScreeningTag				= 'scrn';
	cmTechnologyTag				= 'tech';
	cmUcrBgTag					= 'bfd ';
	cmViewingConditionsDescTag	= 'vued';
	cmViewingConditionsTag		= 'view';

{ custom tags }
	cmPS2CRDVMSizeTag			= 'psvm';

{ technology tag descriptions }
	cmTechnologyFilmScanner		= 'fscn';
	cmTechnologyReflectiveScanner = 'rscn';
	cmTechnologyInkJetPrinter	= 'ijet';
	cmTechnologyThermalWaxPrinter = 'twax';
	cmTechnologyElectrophotographicPrinter = 'epho';
	cmTechnologyElectrostaticPrinter = 'esta';
	cmTechnologyDyeSublimationPrinter = 'dsub';
	cmTechnologyPhotographicPaperPrinter = 'rpho';
	cmTechnologyFilmWriter		= 'fprn';
	cmTechnologyVideoMonitor	= 'vidm';
	cmTechnologyVideoCamera		= 'vidc';
	cmTechnologyProjectionTelevision = 'pjtv';
	cmTechnologyCRTDisplay		= 'CRT ';
	cmTechnologyPMDisplay		= 'PMD ';
	cmTechnologyAMDisplay		= 'AMD ';
	cmTechnologyPhotoCD			= 'KPCD';
	cmTechnologyPhotoImageSetter = 'imgs';
	cmTechnologyGravure			= 'grav';
	cmTechnologyOffsetLithography = 'offs';
	cmTechnologySilkscreen		= 'silk';
	cmTechnologyFlexography		= 'flex';

{ type signatures }
	cmSigCurveType				= 'curv';
	cmSigDataType				= 'data';
	cmSigDateTimeType			= 'dtim';
	cmSigLut16Type				= 'mft2';
	cmSigLut8Type				= 'mft1';
	cmSigMeasurementType		= 'meas';
	cmSigNamedColorType			= 'ncol';
	cmSigProfileDescriptionType	= 'desc';
	cmSigScreeningType			= 'scrn';
	cmSigS15Fixed16Type			= 'sf32';
	cmSigSignatureType			= 'sig ';
	cmSigTextType				= 'text';
	cmSigU16Fixed16Type			= 'uf32';
	cmSigU1Fixed15Type			= 'uf16';
	cmSigUInt32Type				= 'ui32';
	cmSigUInt64Type				= 'ui64';
	cmSigUInt8Type				= 'ui08';
	cmSigViewingConditionsType	= 'view';
	cmSigXYZType				= 'XYZ ';

{ Measurement type encodings }
{ Measurement Flare }
	cmFlare0					= $00000000;
	cmFlare100					= $00000001;

{ Measurement Geometry	}
	cmGeometryUnknown			= $00000000;
	cmGeometry045or450			= $00000001;
	cmGeometry0dord0			= $00000002;

{ Standard Observer	}
	cmStdobsUnknown				= $00000000;
	cmStdobs1931TwoDegrees		= $00000001;
	cmStdobs1964TenDegrees		= $00000002;

{ Standard Illuminant }
	cmIlluminantUnknown			= $00000000;
	cmIlluminantD50				= $00000001;
	cmIlluminantD65				= $00000002;
	cmIlluminantD93				= $00000003;
	cmIlluminantF2				= $00000004;
	cmIlluminantD55				= $00000005;
	cmIlluminantA				= $00000006;
	cmIlluminantEquiPower		= $00000007;
	cmIlluminantF8				= $00000008;

{ Spot Function Value }
	cmSpotFunctionUnknown		= 0;
	cmSpotFunctionDefault		= 1;
	cmSpotFunctionRound			= 2;
	cmSpotFunctionDiamond		= 3;
	cmSpotFunctionEllipse		= 4;
	cmSpotFunctionLine			= 5;
	cmSpotFunctionSquare		= 6;
	cmSpotFunctionCross			= 7;

{ Color Space Signatures }
	cmXYZData					= 'XYZ ';
	cmLabData					= 'Lab ';
	cmLuvData					= 'Luv ';
	cmYxyData					= 'Yxy ';
	cmRGBData					= 'RGB ';
	cmGrayData					= 'GRAY';
	cmHSVData					= 'HSV ';
	cmHLSData					= 'HLS ';
	cmCMYKData					= 'CMYK';
	cmCMYData					= 'CMY ';
	cmMCH5Data					= 'MCH5';
	cmMCH6Data					= 'MCH6';
	cmMCH7Data					= 'MCH7';
	cmMCH8Data					= 'MCH8';

{ profileClass enumerations }
	cmInputClass				= 'scnr';
	cmDisplayClass				= 'mntr';
	cmOutputClass				= 'prtr';
	cmLinkClass					= 'link';
	cmAbstractClass				= 'abst';
	cmColorSpaceClass			= 'spac';

{ platform enumerations }
	cmMacintosh					= 'APPL';
	cmMicrosoft					= 'MSFT';
	cmSolaris					= 'SUNW';
	cmSiliconGraphics			= 'SGI ';
	cmTaligent					= 'TGNT';

{ ColorSync 1.0 elements }
	cmCS1ChromTag				= 'chrm';
	cmCS1TRCTag					= 'trc ';
	cmCS1NameTag				= 'name';
	cmCS1CustTag				= 'cust';

{ General element data types }

TYPE
	CMDateTime = RECORD
		year:					INTEGER;
		month:					INTEGER;
		dayOfTheMonth:			INTEGER;
		hours:					INTEGER;
		minutes:				INTEGER;
		seconds:				INTEGER;
	END;

	CMFixedXYZColor = RECORD
		X:						Fixed;
		Y:						Fixed;
		Z:						Fixed;
	END;

	CMXYZComponent = INTEGER;

	CMXYZColor = RECORD
		X:						CMXYZComponent;
		Y:						CMXYZComponent;
		Z:						CMXYZComponent;
	END;

	CM2Header = RECORD
		size:					LONGINT;								{ This is the total size of the Profile }
		CMMType:				OSType;									{ CMM signature,  Registered with CS2 consortium  }
		profileVersion:			LONGINT;								{ Version of CMProfile format }
		profileClass:			OSType;									{ input, display, output, devicelink, abstract, or color conversion profile type }
		dataColorSpace:			OSType;									{ color space of data }
		profileConnectionSpace:	OSType;									{ profile connection color space }
		dateTime:				CMDateTime;								{ date and time of profile creation }
		CS2profileSignature:	OSType;									{ 'acsp' constant ColorSync 2.0 file ID }
		platform:				OSType;									{ primary profile platform, Registered with CS2 consortium }
		flags:					LONGINT;								{ profile flags }
		deviceManufacturer:		OSType;									{ Registered with CS2 consortium }
		deviceModel:			LONGINT;								{ Registered with CS2 consortium }
		deviceAttributes:		ARRAY [0..1] OF LONGINT;				{ Attributes like paper type }
		renderingIntent:		LONGINT;								{ preferred rendering intent of tagged object }
		white:					CMFixedXYZColor;						{ profile illuminant }
		reserved:				ARRAY [0..47] OF CHAR;					{ reserved for future use }
	END;

	CMTagRecord = RECORD
		tag:					OSType;									{ Registered with CS2 consortium }
		elementOffset:			LONGINT;								{ Relative to start of CMProfile }
		elementSize:			LONGINT;
	END;

	CMTagElemTable = RECORD
		count:					LONGINT;
		tagList:				ARRAY [0..0] OF CMTagRecord;			{ Variable size }
	END;

{ External 0x02002001 CMProfile }
	CM2Profile = RECORD
		header:					CM2Header;
		tagTable:				CMTagElemTable;
		elemData:				ARRAY [0..0] OF CHAR;					{ Tagged element storage. Variable size }
	END;

	CM2ProfilePtr = ^CM2Profile;
	CM2ProfileHandle = ^CM2ProfilePtr;

{ Tag Type Definitions }
	CMCurveType = RECORD
		typeDescriptor:			OSType;									{ 'curv' }
		reserved:				LONGINT;								{ fill with 0x00 }
		countValue:				LONGINT;								{ number of entries in table that follows }
		data:					ARRAY [0..0] OF INTEGER;				{ Tagged element storage. Variable size }
	END;

	CMDataType = RECORD
		typeDescriptor:			OSType;									{ 'data' }
		reserved:				LONGINT;								{ fill with 0x00 }
		dataFlag:				LONGINT;								{ 0 = ASCII, 1 = binary }
		data:					ARRAY [0..0] OF CHAR;					{ Tagged element storage. Variable size }
	END;

	CMDateTimeType = RECORD
		typeDescriptor:			OSType;									{ 'dtim' }
		reserved:				LONGINT;
		dateTime:				CMDateTime;
	END;

	CMLut16Type = RECORD
		typeDescriptor:			OSType;									{ 'mft2' }
		reserved:				LONGINT;								{ fill with 0x00 }
		inputChannels:			SInt8; (* unsigned char *)				{ Number of input channels }
		outputChannels:			SInt8; (* unsigned char *)				{ Number of output channels }
		gridPoints:				SInt8; (* unsigned char *)				{ Number of clutTable grid points }
		reserved2:				SInt8; (* unsigned char *)				{ fill with 0x00 }
		matrix:					ARRAY [0..2,0..2] OF Fixed;				{ }
		inputTableEntries:		INTEGER;								{ }
		outputTableEntries:		INTEGER;								{ }
		inputTable:				ARRAY [0..0] OF INTEGER;				{ Variable size }
		CLUT:					ARRAY [0..0] OF INTEGER;				{ Variable size }
		outputTable:			ARRAY [0..0] OF INTEGER;				{ Variable size }
	END;

	CMLut8Type = RECORD
		typeDescriptor:			OSType;									{ 'mft1' }
		reserved:				LONGINT;								{ fill with 0x00 }
		inputChannels:			SInt8; (* unsigned char *)				{ }
		outputChannels:			SInt8; (* unsigned char *)				{ }
		gridPoints:				SInt8; (* unsigned char *)				{ }
		reserved2:				SInt8; (* unsigned char *)				{ fill with 0x00 }
		matrix:					ARRAY [0..2,0..2] OF Fixed;				{ }
		inputTable:				ARRAY [0..255] OF SInt8; (* unsigned char *) { fixed size of 256 }
		CLUT:					ARRAY [0..0] OF SInt8; (* unsigned char *) { Variable size }
		outputTable:			ARRAY [0..255] OF SInt8; (* unsigned char *) { fixed size of 256 }
	END;

	CMMeasurementType = RECORD
		typeDescriptor:			OSType;									{ 'meas' }
		reserved:				LONGINT;								{ fill with 0x00 }
		standardObserver:		LONGINT;								{ 0 : unknown, 1 : CIE 1931, 2 : CIE 1964 }
		backingXYZ:				CMFixedXYZColor;						{ absolute XYZ values of backing }
		geometry:				LONGINT;								{ 0 : unknown, 1 : 0/45 or 45/0, 2 :0/d or d/0 }
		flare:					LONGINT;								{ 0 : 0%, 1 : 100% flare }
		illuminant:				LONGINT;								{ standard illuminant }
	END;

	CMNamedColorType = RECORD
		typeDescriptor:			OSType;									{ 'ncol' }
		reserved:				LONGINT;								{ fill with 0x00 }
		vendorFlag:				LONGINT;								{ }
		count:					LONGINT;								{ count of named colors in array that follows }
		prefixName:				ARRAY [0..0] OF SInt8; (* unsigned char *) { Variable size, max = 32, to access fields after this one, have to count bytes }
		suffixName:				ARRAY [0..0] OF SInt8; (* unsigned char *) { Variable size, max = 32 }
		colorName:			RECORD
				rootName:						ARRAY [0..0] OF SInt8; (* unsigned char *) { Variable size, max = 32 }
				colorCoords:					ARRAY [0..0] OF SInt8; (* unsigned char *) { Variable size  }
			END;

														{ Variable size  }
	END;

	CMTextDescriptionType = RECORD
		typeDescriptor:			OSType;									{ 'desc' }
		reserved:				LONGINT;								{ fill with 0x00 }
		ASCIICount:				LONGINT;								{ the count of "bytes" }
		ASCIIName:				ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size, to access fields after this one, have to count bytes }
		UniCodeCode:			LONGINT;
		UniCodeCount:			LONGINT;								{ the count of characters, each character has two bytes }
		UniCodeName:			ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
		ScriptCodeCode:			INTEGER;
		ScriptCodeCount:		SInt8; (* unsigned char *)				{ the count of "bytes" }
		ScriptCodeName:			ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
	END;

	CMTextType = RECORD
		typeDescriptor:			OSType;									{ 'text' }
		reserved:				LONGINT;								{ fill with 0x00 }
		text:					ARRAY [0..0] OF SInt8; (* unsigned char *) { count of text is obtained from tag size element }
	END;

	CMScreeningType = RECORD
		typeDescriptor:			OSType;									{ 'scrn' }
		reserved:				LONGINT;								{ fill with 0x00 }
		screeningFlag:			LONGINT;								{ bit 0 : use printer default screens, bit 1 : inch/cm }
		channelCount:			LONGINT;
		channelScreening:			RECORD
				frequency:						Fixed;
				angle:							Fixed;
				sportFunction:					LONGINT;
			END;

												{ Variable size }
	END;

	CMSignatureType = RECORD
		typeDescriptor:			OSType;									{ 'sig ' }
		reserved:				LONGINT;								{ fill with 0x00 }
		signature:				OSType;
	END;

	CMS15Fixed16ArrayType = RECORD
		typeDescriptor:			OSType;									{ 'sf32' }
		reserved:				LONGINT;								{ fill with 0x00 }
		value:					ARRAY [0..0] OF Fixed;					{ Variable size }
	END;

	CMU16Fixed16ArrayType = RECORD
		typeDescriptor:			OSType;									{ 'uf32' }
		reserved:				LONGINT;								{ fill with 0x00 }
		value:					ARRAY [0..0] OF LONGINT;				{ Variable size }
	END;

	CMUInt16ArrayType = RECORD
		typeDescriptor:			OSType;									{ 'ui16' }
		reserved:				LONGINT;								{ fill with 0x00 }
		value:					ARRAY [0..0] OF INTEGER;				{ Variable size }
	END;

	CMUInt32ArrayType = RECORD
		typeDescriptor:			OSType;									{ 'ui32' }
		reserved:				LONGINT;								{ fill with 0x00 }
		value:					ARRAY [0..0] OF LONGINT;				{ Variable size }
	END;

	CMUInt64ArrayType = RECORD
		typeDescriptor:			OSType;									{ 'ui64' }
		reserved:				LONGINT;								{ fill with 0x00 }
		value:					ARRAY [0..0] OF LONGINT;				{ Variable size (x2) }
	END;

	CMUInt8ArrayType = RECORD
		typeDescriptor:			OSType;									{ 'ui08' }
		reserved:				LONGINT;								{ fill with 0x00 }
		value:					ARRAY [0..0] OF SInt8; (* unsigned char *) { Variable size }
	END;

	CMViewingConditionsType = RECORD
		typeDescriptor:			OSType;									{ 'view' }
		reserved:				LONGINT;								{ fill with 0x00 }
		illuminant:				CMFixedXYZColor;						{ absolute XYZs of illuminant  in cd/m^2 }
		surround:				CMFixedXYZColor;						{ absolute XYZs of surround in cd/m^2 }
		stdIlluminant:			LONGINT;								{ see definitions of std illuminants }
	END;

	CMXYZType = RECORD
		typeDescriptor:			OSType;									{ 'XYZ ' }
		reserved:				LONGINT;								{ fill with 0x00 }
		XYZ:					ARRAY [0..0] OF CMFixedXYZColor;		{ variable size XYZ tristimulus values }
	END;

{ Profile sequence description type }
	CMProfileSequenceDescType = RECORD
		typeDescriptor:			OSType;									{ 'pseq ' }
		reserved:				LONGINT;								{ fill with 0x00 }
		count:					LONGINT;								{ Number of descriptions
														 * variable size fields to follow, to access them, must count bytes }
		profileDescription:			RECORD
				deviceMfg:						OSType;							{ Device Manufacturer }
				deviceModel:					OSType;							{ Decvice Model }
				attributes:						ARRAY [0..1] OF LONGINT;		{ Device attributes }
				technology:						OSType;							{ Technology signature }
				mfgDescASCIICount:				LONGINT;						{ the count of "bytes" }
				mfgDescASCIIName:				ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
				mfgDescUniCodeCode:				LONGINT;
				mfgDescUniCodeCount:			LONGINT;						{ the count of characters, each character has two bytes }
				mfgDescUniCodeName:				ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
				mfgDescScriptCodeCode:			LONGINT;
				mfgDescScriptCodeCount:			LONGINT;						{ the count of "bytes" }
				mfgDescScriptCodeName:			ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
				modelDescASCIICount:			LONGINT;						{ the count of "bytes" }
				modelDescASCIIName:				ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
				modelDescUniCodeCode:			LONGINT;
				modelDescUniCodeCount:			LONGINT;						{ the count of characters, each character has two bytes }
				modelDescUniCodeName:			ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
				modelDescScriptCodeCode:		INTEGER;
				modelDescScriptCodeCount:		SInt8; (* unsigned char *)		{ the count of "bytes" }
				modelDescScriptCodeName:		ARRAY [0..1] OF SInt8; (* unsigned char *) { Variable size }
			END;


	END;

{ Under color removal, black generation type }
	CMUcrBgType = RECORD
		typeDescriptor:			OSType;									{ 'bfd  ' }
		reserved:				LONGINT;								{ fill with 0x00 }
		ucrCount:				LONGINT;								{ Number of UCR entries }
		ucrValues:				ARRAY [0..0] OF INTEGER;				{ variable size }
		bgCount:				LONGINT;								{ Number of BG entries }
		bgValues:				ARRAY [0..0] OF INTEGER;				{ variable size }
		ucrbgASCII:				ARRAY [0..0] OF SInt8; (* unsigned char *) { null terminated ASCII string }
	END;

	CMIntentCRDVMSize = RECORD
		renderingIntent:		LONGINT;								{ rendering intent }
		VMSize:					LONGINT;								{ VM size taken up by the CRD }
	END;

	CMPS2CRDVMSizeType = RECORD
		typeDescriptor:			OSType;									{ 'psvm' }
		reserved:				LONGINT;								{ fill with 0x00 }
		count:					LONGINT;								{ number of intent entries }
		intentCRD:				ARRAY [0..0] OF CMIntentCRDVMSize;		{ variable size }
	END;

{**********************************************************************}
{************** ColorSync 1.0 profile specification *******************}
{**********************************************************************}

CONST
	cmGrayResponse				= 0;
	cmRedResponse				= 1;
	cmGreenResponse				= 2;
	cmBlueResponse				= 3;
	cmCyanResponse				= 4;
	cmMagentaResponse			= 5;
	cmYellowResponse			= 6;
	cmUcrResponse				= 7;
	cmBgResponse				= 8;
	cmOnePlusLastResponse		= 9;

{ Device types }
	cmMonitorDevice				= 'mntr';
	cmScannerDevice				= 'scnr';
	cmPrinterDevice				= 'prtr';


TYPE
	CMIString = RECORD
		theScript:				ScriptCode;
		theString:				Str63;
	END;

{ Profile options }

CONST
	cmPerceptualMatch			= $0000;						{ Default. For photographic images }
	cmColorimetricMatch			= $0001;						{ Exact matching when possible }
	cmSaturationMatch			= $0002;						{ For solid colors }

{ Profile flags }
	cmNativeMatchingPreferred	= $00000001;					{ Default to native not preferred }
	cmTurnOffCache				= $00000002;					{ Default to turn on CMM cache }

	
TYPE
	CMMatchOption = LONGINT;

	CMMatchFlag = LONGINT;

	CMHeader = RECORD
		size:					LONGINT;
		CMMType:				OSType;
		applProfileVersion:		LONGINT;
		dataType:				OSType;
		deviceType:				OSType;
		deviceManufacturer:		OSType;
		deviceModel:			LONGINT;
		deviceAttributes:		ARRAY [0..1] OF LONGINT;
		profileNameOffset:		LONGINT;
		customDataOffset:		LONGINT;
		flags:					CMMatchFlag;
		options:				CMMatchOption;
		white:					CMXYZColor;
		black:					CMXYZColor;
	END;

	CMProfileChromaticities = RECORD
		red:					CMXYZColor;
		green:					CMXYZColor;
		blue:					CMXYZColor;
		cyan:					CMXYZColor;
		magenta:				CMXYZColor;
		yellow:					CMXYZColor;
	END;

	CMProfileResponse = RECORD
		counts:					ARRAY [0..cmOnePlusLastResponse-1] OF INTEGER;
		data:					ARRAY [0..0] OF INTEGER;				{ Variable size }
	END;

	CMProfile = RECORD
		header:					CMHeader;
		profile:				CMProfileChromaticities;
		response:				CMProfileResponse;
		profileName:			CMIString;
		customData:				ARRAY [0..0] OF CHAR;					{ Variable size }
	END;

	CMProfilePtr = ^CMProfile;
	CMProfileHandle = ^CMProfilePtr;

{$IFC OLDROUTINENAMES }

CONST
	kCMApplProfileVersion		= cmCS1ProfileVersion;

	grayResponse				= cmGrayResponse;
	redResponse					= cmRedResponse;
	greenResponse				= cmGreenResponse;
	blueResponse				= cmBlueResponse;
	cyanResponse				= cmCyanResponse;
	magentaResponse				= cmMagentaResponse;
	yellowResponse				= cmYellowResponse;
	ucrResponse					= cmUcrResponse;
	bgResponse					= cmBgResponse;
	onePlusLastResponse			= cmOnePlusLastResponse;

	rgbData						= cmRGBData;
	cmykData					= cmCMYKData;
	grayData					= cmGrayData;
	xyzData						= cmXYZData;

	monitorDevice				= cmMonitorDevice;
	scannerDevice				= cmScannerDevice;
	printerDevice				= cmPrinterDevice;

	
TYPE
	XYZComponent = INTEGER;

	XYZColor = CMXYZColor;

	CMResponseData = INTEGER;

	IString = CMIString;

	CMResponseColor = LONGINT;

	responseColor = CMResponseColor;

{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMICCProfileIncludes}

{$ENDC} {__CMICCPROFILE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
