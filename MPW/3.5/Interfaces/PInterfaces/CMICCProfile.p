{
     File:       CMICCProfile.p
 
     Contains:   ICC Profile Format Definitions
 
     Version:    Technology: ColorSync 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ICC Profile version constants  }

CONST
	cmICCProfileVersion2		= $02000000;
	cmICCProfileVersion21		= $02100000;
	cmCS2ProfileVersion			= $02000000;
	cmCS1ProfileVersion			= $00000100;					{  ColorSync 1.0 profile version  }

	{	 Current Major version number 	}
	cmProfileMajorVersionMask	= $FF000000;
	cmCurrentProfileMajorVersion = $02000000;

	{	 magic cookie number for anonymous file ID 	}
	cmMagicNumber				= 'acsp';


	{	**********************************************************************	}
	{	************** ColorSync 2.0 profile specification *******************	}
	{	**********************************************************************	}
	{	*** flags field  ***	}
	cmICCReservedFlagsMask		= $0000FFFF;					{  these bits of the flags field are defined and reserved by ICC  }
	cmEmbeddedMask				= $00000001;					{  if bit 0 is 0 then not embedded profile, if 1 then embedded profile  }
	cmEmbeddedUseMask			= $00000002;					{  if bit 1 is 0 then ok to use anywhere, if 1 then ok to use as embedded profile only  }
	cmCMSReservedFlagsMask		= $FFFF0000;					{  these bits of the flags field are defined and reserved by CMS vendor  }
	cmQualityMask				= $00030000;					{  if bits 16-17 is 0 then normal, if 1 then draft, if 2 then best  }
	cmInterpolationMask			= $00040000;					{  if bit 18 is 0 then interpolation, if 1 then lookup only  }
	cmGamutCheckingMask			= $00080000;					{  if bit 19 is 0 then create gamut checking info, if 1 then no gamut checking info  }

	{	 copyright-protection flag options 	}
	cmEmbeddedProfile			= 0;							{  0 is not embedded profile, 1 is embedded profile  }
	cmEmbeddedUse				= 1;							{  0 is to use anywhere, 1 is to use as embedded profile only  }

	{	 speed and quality flag options 	}
	cmNormalMode				= 0;							{  it uses the least significent two bits in the high word of flag  }
	cmDraftMode					= 1;							{  it should be evaulated like this: right shift 16 bits first, mask off the  }
	cmBestMode					= 2;							{  high 14 bits, and then compare with the enum to determine the option value  }


	{	*** deviceAttributes fields ***	}
	{	 deviceAttributes[0] is defined by and reserved for device vendors 	}
	{	 deviceAttributes[1] is defined by and reserved for ICC 	}
	{	 The following bits of deviceAttributes[1] are currently defined 	}
	cmReflectiveTransparentMask	= $00000001;					{  if bit 0 is 0 then reflective media, if 1 then transparency media  }
	cmGlossyMatteMask			= $00000002;					{  if bit 1 is 0 then glossy, if 1 then matte  }

	{	 device/media attributes element values  	}
	cmReflective				= 0;							{  if bit 0 is 0 then reflective media, if 1 then transparency media  }
	cmGlossy					= 1;							{  if bit 1 is 0 then glossy, if 1 then matte  }


	{	*** renderingIntent field ***	}
	cmPerceptual				= 0;							{  Photographic images  }
	cmRelativeColorimetric		= 1;							{  Logo Colors  }
	cmSaturation				= 2;							{  Business graphics  }
	cmAbsoluteColorimetric		= 3;							{  Logo Colors  }



	{	 data type element values 	}
	cmAsciiData					= 0;
	cmBinaryData				= 1;

	{	 screen encodings  	}
	cmPrtrDefaultScreens		= 0;							{  Use printer default screens.  0 is false, 1 is ture  }
	cmLinesPer					= 1;							{  0 is LinesPerCm, 1 is LinesPerInch  }

	{	 2.0 tag type information 	}
	cmNumHeaderElements			= 10;

	{	 public tags 	}
	cmAToB0Tag					= 'A2B0';
	cmAToB1Tag					= 'A2B1';
	cmAToB2Tag					= 'A2B2';
	cmBlueColorantTag			= 'bXYZ';
	cmBlueTRCTag				= 'bTRC';
	cmBToA0Tag					= 'B2A0';
	cmBToA1Tag					= 'B2A1';
	cmBToA2Tag					= 'B2A2';
	cmCalibrationDateTimeTag	= 'calt';
	cmChromaticAdaptationTag	= 'chad';
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
	cmNamedColor2Tag			= 'ncl2';
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

	{	 custom tags 	}
	cmPS2CRDVMSizeTag			= 'psvm';
	cmVideoCardGammaTag			= 'vcgt';
	cmMakeAndModelTag			= 'mmod';
	cmProfileDescriptionMLTag	= 'dscm';

	{	 technology tag descriptions 	}
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

	{	 public type signatures 	}
	cmSigCurveType				= 'curv';
	cmSigDataType				= 'data';
	cmSigDateTimeType			= 'dtim';
	cmSigLut16Type				= 'mft2';
	cmSigLut8Type				= 'mft1';
	cmSigMeasurementType		= 'meas';
	cmSigNamedColorType			= 'ncol';
	cmSigNamedColor2Type		= 'ncl2';
	cmSigProfileDescriptionType	= 'desc';
	cmSigScreeningType			= 'scrn';
	cmSigS15Fixed16Type			= 'sf32';
	cmSigSignatureType			= 'sig ';
	cmSigTextType				= 'text';
	cmSigU16Fixed16Type			= 'uf32';
	cmSigU1Fixed15Type			= 'uf16';
	cmSigUInt8Type				= 'ui08';
	cmSigUInt16Type				= 'ui16';
	cmSigUInt32Type				= 'ui32';
	cmSigUInt64Type				= 'ui64';
	cmSigUcrBgType				= 'bfd ';
	cmSigUnicodeTextType		= 'utxt';
	cmSigViewingConditionsType	= 'view';
	cmSigXYZType				= 'XYZ ';

	{	 custom type signatures 	}
	cmSigPS2CRDVMSizeType		= 'psvm';
	cmSigVideoCardGammaType		= 'vcgt';
	cmSigMakeAndModelType		= 'mmod';
	cmSigMultiLocalizedUniCodeType = 'mluc';


	{	 Measurement type encodings 	}
	{	 Measurement Flare 	}
	cmFlare0					= $00000000;
	cmFlare100					= $00000001;

	{	 Measurement Geometry 	}
	cmGeometryUnknown			= $00000000;
	cmGeometry045or450			= $00000001;
	cmGeometry0dord0			= $00000002;

	{	 Standard Observer    	}
	cmStdobsUnknown				= $00000000;
	cmStdobs1931TwoDegrees		= $00000001;
	cmStdobs1964TenDegrees		= $00000002;

	{	 Standard Illuminant 	}
	cmIlluminantUnknown			= $00000000;
	cmIlluminantD50				= $00000001;
	cmIlluminantD65				= $00000002;
	cmIlluminantD93				= $00000003;
	cmIlluminantF2				= $00000004;
	cmIlluminantD55				= $00000005;
	cmIlluminantA				= $00000006;
	cmIlluminantEquiPower		= $00000007;
	cmIlluminantF8				= $00000008;

	{	 Spot Function Value 	}
	cmSpotFunctionUnknown		= 0;
	cmSpotFunctionDefault		= 1;
	cmSpotFunctionRound			= 2;
	cmSpotFunctionDiamond		= 3;
	cmSpotFunctionEllipse		= 4;
	cmSpotFunctionLine			= 5;
	cmSpotFunctionSquare		= 6;
	cmSpotFunctionCross			= 7;

	{	 Color Space Signatures 	}
	cmXYZData					= 'XYZ ';
	cmLabData					= 'Lab ';
	cmLuvData					= 'Luv ';
	cmYxyData					= 'Yxy ';
	cmRGBData					= 'RGB ';
	cmSRGBData					= 'sRGB';
	cmGrayData					= 'GRAY';
	cmHSVData					= 'HSV ';
	cmHLSData					= 'HLS ';
	cmCMYKData					= 'CMYK';
	cmCMYData					= 'CMY ';
	cmMCH5Data					= 'MCH5';
	cmMCH6Data					= 'MCH6';
	cmMCH7Data					= 'MCH7';
	cmMCH8Data					= 'MCH8';
	cm3CLRData					= '3CLR';
	cm4CLRData					= '4CLR';
	cm5CLRData					= '5CLR';
	cm6CLRData					= '6CLR';
	cm7CLRData					= '7CLR';
	cm8CLRData					= '8CLR';
	cmNamedData					= 'NAME';

	{	 profileClass enumerations 	}
	cmInputClass				= 'scnr';
	cmDisplayClass				= 'mntr';
	cmOutputClass				= 'prtr';
	cmLinkClass					= 'link';
	cmAbstractClass				= 'abst';
	cmColorSpaceClass			= 'spac';
	cmNamedColorClass			= 'nmcl';

	{	 platform enumerations 	}
	cmMacintosh					= 'APPL';
	cmMicrosoft					= 'MSFT';
	cmSolaris					= 'SUNW';
	cmSiliconGraphics			= 'SGI ';
	cmTaligent					= 'TGNT';

	{	 ColorSync 1.0 elements 	}
	cmCS1ChromTag				= 'chrm';
	cmCS1TRCTag					= 'trc ';
	cmCS1NameTag				= 'name';
	cmCS1CustTag				= 'cust';

	{	 General element data types 	}

TYPE
	CMDateTimePtr = ^CMDateTime;
	CMDateTime = RECORD
		year:					UInt16;
		month:					UInt16;
		dayOfTheMonth:			UInt16;
		hours:					UInt16;
		minutes:				UInt16;
		seconds:				UInt16;
	END;

	CMFixedXYZColorPtr = ^CMFixedXYZColor;
	CMFixedXYZColor = RECORD
		X:						Fixed;
		Y:						Fixed;
		Z:						Fixed;
	END;

	CMXYZComponent						= UInt16;
	CMXYZColorPtr = ^CMXYZColor;
	CMXYZColor = RECORD
		X:						CMXYZComponent;
		Y:						CMXYZComponent;
		Z:						CMXYZComponent;
	END;

	CM2HeaderPtr = ^CM2Header;
	CM2Header = RECORD
		size:					UInt32;									{  This is the total size of the Profile  }
		CMMType:				OSType;									{  CMM signature,  Registered with CS2 consortium   }
		profileVersion:			UInt32;									{  Version of CMProfile format  }
		profileClass:			OSType;									{  input, display, output, devicelink, abstract, or color conversion profile type  }
		dataColorSpace:			OSType;									{  color space of data  }
		profileConnectionSpace:	OSType;									{  profile connection color space  }
		dateTime:				CMDateTime;								{  date and time of profile creation  }
		CS2profileSignature:	OSType;									{  'acsp' constant ColorSync 2.0 file ID  }
		platform:				OSType;									{  primary profile platform, Registered with CS2 consortium  }
		flags:					UInt32;									{  profile flags  }
		deviceManufacturer:		OSType;									{  Registered with ICC consortium  }
		deviceModel:			UInt32;									{  Registered with ICC consortium  }
		deviceAttributes:		ARRAY [0..1] OF UInt32;					{  Attributes[0] is for device vendors, [1] is for ICC  }
		renderingIntent:		UInt32;									{  preferred rendering intent of tagged object  }
		white:					CMFixedXYZColor;						{  profile illuminant  }
		creator:				OSType;									{  profile creator  }
		reserved:				PACKED ARRAY [0..43] OF CHAR;			{  reserved for future use  }
	END;

	CMTagRecordPtr = ^CMTagRecord;
	CMTagRecord = RECORD
		tag:					OSType;									{  Registered with CS2 consortium  }
		elementOffset:			UInt32;									{  Relative to start of CMProfile  }
		elementSize:			UInt32;
	END;

	CMTagElemTablePtr = ^CMTagElemTable;
	CMTagElemTable = RECORD
		count:					UInt32;
		tagList:				ARRAY [0..0] OF CMTagRecord;			{  variable size, determined by count  }
	END;

	CM2ProfilePtr = ^CM2Profile;
	CM2Profile = RECORD
		header:					CM2Header;
		tagTable:				CMTagElemTable;
		elemData:				SInt8;									{  variable size data for tagged element storage  }
	END;

	CM2ProfileHandle					= ^CM2ProfilePtr;
	{	 Tag Type Definitions 	}
	CMAdaptationMatrixTypePtr = ^CMAdaptationMatrixType;
	CMAdaptationMatrixType = RECORD
		typeDescriptor:			OSType;									{  'sf32' = cmSigS15Fixed16Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		adaptationMatrix:		ARRAY [0..8] OF Fixed;					{  fixed size of nine matrix entries  }
	END;

	CMCurveTypePtr = ^CMCurveType;
	CMCurveType = RECORD
		typeDescriptor:			OSType;									{  'curv' = cmSigCurveType  }
		reserved:				UInt32;									{  fill with 0x00  }
		countValue:				UInt32;									{  number of entries in table that follows  }
		data:					ARRAY [0..0] OF UInt16;					{  variable size, determined by countValue  }
	END;

	CMDataTypePtr = ^CMDataType;
	CMDataType = RECORD
		typeDescriptor:			OSType;									{  'data' = cmSigDataType }
		reserved:				UInt32;									{  fill with 0x00  }
		dataFlag:				UInt32;									{  0 = ASCII, 1 = binary  }
		data:					SInt8;									{  variable size, determined by tag element size  }
	END;

	CMDateTimeTypePtr = ^CMDateTimeType;
	CMDateTimeType = RECORD
		typeDescriptor:			OSType;									{  'dtim' = cmSigDateTimeType  }
		reserved:				UInt32;									{  fill with 0x00  }
		dateTime:				CMDateTime;								{   }
	END;

	CMLut16TypePtr = ^CMLut16Type;
	CMLut16Type = RECORD
		typeDescriptor:			OSType;									{  'mft2' = cmSigLut16Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		inputChannels:			SInt8;									{  Number of input channels  }
		outputChannels:			SInt8;									{  Number of output channels  }
		gridPoints:				SInt8;									{  Number of clutTable grid points  }
		reserved2:				SInt8;									{  fill with 0x00  }
		matrix:					ARRAY [0..2,0..2] OF Fixed;				{   }
		inputTableEntries:		UInt16;									{  Number of entries in 1-D input luts  }
		outputTableEntries:		UInt16;									{  Number of entries in 1-D output luts  }
		inputTable:				ARRAY [0..0] OF UInt16;					{  variable size, determined by inputChannels*inputTableEntries  }
	END;

	CMLut8TypePtr = ^CMLut8Type;
	CMLut8Type = RECORD
		typeDescriptor:			OSType;									{  'mft1' = cmSigLut8Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		inputChannels:			SInt8;									{  Number of input channels  }
		outputChannels:			SInt8;									{  Number of output channels  }
		gridPoints:				SInt8;									{  Number of clutTable grid points  }
		reserved2:				SInt8;									{  fill with 0x00  }
		matrix:					ARRAY [0..2,0..2] OF Fixed;				{   }
		inputTable:				SInt8;									{  variable size, determined by inputChannels*256  }
	END;

	CMMeasurementTypePtr = ^CMMeasurementType;
	CMMeasurementType = RECORD
		typeDescriptor:			OSType;									{  'meas' = cmSigMeasurementType  }
		reserved:				UInt32;									{  fill with 0x00  }
		standardObserver:		UInt32;									{  cmStdobsUnknown, cmStdobs1931TwoDegrees, cmStdobs1964TenDegrees  }
		backingXYZ:				CMFixedXYZColor;						{  absolute XYZ values of backing  }
		geometry:				UInt32;									{  cmGeometryUnknown, cmGeometry045or450 (0/45), cmGeometry0dord0 (0/d or d/0)  }
		flare:					UInt32;									{  cmFlare0, cmFlare100  }
		illuminant:				UInt32;									{  cmIlluminantUnknown, cmIlluminantD50, ...  }
	END;

	CMNamedColorTypePtr = ^CMNamedColorType;
	CMNamedColorType = RECORD
		typeDescriptor:			OSType;									{  'ncol' = cmSigNamedColorType  }
		reserved:				UInt32;									{  fill with 0x00  }
		vendorFlag:				UInt32;									{   }
		count:					UInt32;									{  count of named colors in array that follows  }
		prefixName:				SInt8;									{  variable size, max = 32  }
	END;

	CMNamedColor2EntryTypePtr = ^CMNamedColor2EntryType;
	CMNamedColor2EntryType = RECORD
		rootName:				PACKED ARRAY [0..31] OF UInt8;			{  32 byte field.  7 bit ASCII null terminated  }
		PCSColorCoords:			ARRAY [0..2] OF UInt16;					{  Lab or XYZ color  }
		DeviceColorCoords:		ARRAY [0..0] OF UInt16;					{  variable size  }
	END;

	CMNamedColor2TypePtr = ^CMNamedColor2Type;
	CMNamedColor2Type = RECORD
		typeDescriptor:			OSType;									{  'ncl2' = cmSigNamedColor2Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		vendorFlag:				UInt32;									{  lower 16 bits reserved for ICC use  }
		count:					UInt32;									{  count of named colors in array that follows  }
		deviceChannelCount:		UInt32;									{  number of device channels, 0 indicates no device value available  }
		prefixName:				PACKED ARRAY [0..31] OF UInt8;			{  Fixed 32 byte size.  7 bit ASCII null terminated  }
		suffixName:				PACKED ARRAY [0..31] OF UInt8;			{  Fixed 32 byte size.  7 bit ASCII null terminated  }
		data:					SInt8;									{  variable size data for CMNamedColor2EntryType  }
	END;

	CMTextDescriptionTypePtr = ^CMTextDescriptionType;
	CMTextDescriptionType = PACKED RECORD
		typeDescriptor:			OSType;									{  'desc' = cmSigProfileDescriptionType  }
		reserved:				UInt32;									{  fill with 0x00  }
		ASCIICount:				UInt32;									{  Count of bytes (including null terminator)   }
		ASCIIName:				PACKED ARRAY [0..1] OF UInt8;			{  variable size, determined by ASCIICount.  7 bit ASCII null terminated  }
	END;

	CMTextTypePtr = ^CMTextType;
	CMTextType = RECORD
		typeDescriptor:			OSType;									{  'text' = cmSigTextType  }
		reserved:				UInt32;									{  fill with 0x00  }
		text:					SInt8;									{  variable size, determined by tag element size  }
	END;

	CMUnicodeTextTypePtr = ^CMUnicodeTextType;
	CMUnicodeTextType = RECORD
		typeDescriptor:			OSType;									{  'utxt' = cmSigUnicodeTextType  }
		reserved:				UInt32;									{  fill with 0x00  }
		text:					ARRAY [0..0] OF UniChar;				{  variable size, determined by tag element size   }
	END;

	CMScreeningChannelRecPtr = ^CMScreeningChannelRec;
	CMScreeningChannelRec = RECORD
		frequency:				Fixed;
		angle:					Fixed;
		spotFunction:			UInt32;
	END;

	CMScreeningTypePtr = ^CMScreeningType;
	CMScreeningType = RECORD
		typeDescriptor:			OSType;									{  'scrn' = cmSigScreeningType  }
		reserved:				UInt32;									{  fill with 0x00  }
		screeningFlag:			UInt32;									{  bit 0 : use printer default screens, bit 1 : inch/cm  }
		channelCount:			UInt32;									{   }
		channelInfo:			ARRAY [0..0] OF CMScreeningChannelRec;	{  variable size, determined by channelCount  }
	END;

	CMSignatureTypePtr = ^CMSignatureType;
	CMSignatureType = RECORD
		typeDescriptor:			OSType;									{  'sig ' = cmSigSignatureType  }
		reserved:				UInt32;									{  fill with 0x00  }
		signature:				OSType;
	END;

	CMS15Fixed16ArrayTypePtr = ^CMS15Fixed16ArrayType;
	CMS15Fixed16ArrayType = RECORD
		typeDescriptor:			OSType;									{  'sf32' = cmSigS15Fixed16Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		value:					ARRAY [0..0] OF Fixed;					{  variable size, determined by tag element size  }
	END;

	CMU16Fixed16ArrayTypePtr = ^CMU16Fixed16ArrayType;
	CMU16Fixed16ArrayType = RECORD
		typeDescriptor:			OSType;									{  'uf32' = cmSigU16Fixed16Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		value:					ARRAY [0..0] OF UInt32;					{  variable size, determined by tag element size  }
	END;

	CMUInt8ArrayTypePtr = ^CMUInt8ArrayType;
	CMUInt8ArrayType = RECORD
		typeDescriptor:			OSType;									{  'ui08' = cmSigUInt8Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		value:					SInt8;									{  variable size, determined by tag element size  }
	END;

	CMUInt16ArrayTypePtr = ^CMUInt16ArrayType;
	CMUInt16ArrayType = RECORD
		typeDescriptor:			OSType;									{  'ui16' = cmSigUInt16Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		value:					ARRAY [0..0] OF UInt16;					{  variable size, determined by tag element size  }
	END;

	CMUInt32ArrayTypePtr = ^CMUInt32ArrayType;
	CMUInt32ArrayType = RECORD
		typeDescriptor:			OSType;									{  'ui32' = cmSigUInt32Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		value:					ARRAY [0..0] OF UInt32;					{  variable size, determined by tag element size  }
	END;

	CMUInt64ArrayTypePtr = ^CMUInt64ArrayType;
	CMUInt64ArrayType = RECORD
		typeDescriptor:			OSType;									{  'ui64' = cmSigUInt64Type  }
		reserved:				UInt32;									{  fill with 0x00  }
		value:					ARRAY [0..0] OF UInt32;					{  variable size, determined by tag element size  }
	END;

	CMViewingConditionsTypePtr = ^CMViewingConditionsType;
	CMViewingConditionsType = RECORD
		typeDescriptor:			OSType;									{  'view' = cmSigViewingConditionsType  }
		reserved:				UInt32;									{  fill with 0x00  }
		illuminant:				CMFixedXYZColor;						{  absolute XYZs of illuminant  in cd/m^2  }
		surround:				CMFixedXYZColor;						{  absolute XYZs of surround in cd/m^2  }
		stdIlluminant:			UInt32;									{  see definitions of std illuminants  }
	END;

	CMXYZTypePtr = ^CMXYZType;
	CMXYZType = RECORD
		typeDescriptor:			OSType;									{  'XYZ ' = cmSigXYZType  }
		reserved:				UInt32;									{  fill with 0x00  }
		XYZ:					ARRAY [0..0] OF CMFixedXYZColor;		{  variable size, determined by tag element size  }
	END;

	CMProfileSequenceDescTypePtr = ^CMProfileSequenceDescType;
	CMProfileSequenceDescType = RECORD
		typeDescriptor:			OSType;									{  'pseq' = cmProfileSequenceDescTag  }
		reserved:				UInt32;									{  fill with 0x00  }
		count:					UInt32;									{  Number of descriptions  }
		data:					SInt8;									{  variable size data explained in ICC spec  }
	END;

	CMUcrBgTypePtr = ^CMUcrBgType;
	CMUcrBgType = RECORD
		typeDescriptor:			OSType;									{  'bfd ' = cmSigUcrBgType  }
		reserved:				UInt32;									{  fill with 0x00  }
		ucrCount:				UInt32;									{  Number of UCR entries  }
		ucrValues:				ARRAY [0..0] OF UInt16;					{  variable size, determined by ucrCount  }
	END;

	{	 Private Tag Type Definitions 	}
	CMIntentCRDVMSizePtr = ^CMIntentCRDVMSize;
	CMIntentCRDVMSize = RECORD
		renderingIntent:		LONGINT;								{  rendering intent  }
		VMSize:					UInt32;									{  VM size taken up by the CRD  }
	END;

	CMPS2CRDVMSizeTypePtr = ^CMPS2CRDVMSizeType;
	CMPS2CRDVMSizeType = RECORD
		typeDescriptor:			OSType;									{  'psvm' = cmSigPS2CRDVMSizeType  }
		reserved:				UInt32;									{  fill with 0x00  }
		count:					UInt32;									{  number of intent entries  }
		intentCRD:				ARRAY [0..0] OF CMIntentCRDVMSize;		{  variable size, determined by count  }
	END;


CONST
	cmVideoCardGammaTableType	= 0;
	cmVideoCardGammaFormulaType	= 1;


TYPE
	CMVideoCardGammaTablePtr = ^CMVideoCardGammaTable;
	CMVideoCardGammaTable = RECORD
		channels:				UInt16;									{  # of gamma channels (1 or 3)  }
		entryCount:				UInt16;									{  1-based number of entries per channel  }
		entrySize:				UInt16;									{  size in bytes of each entry  }
		data:					SInt8;									{  variable size, determined by channels*entryCount*entrySize  }
	END;

	CMVideoCardGammaFormulaPtr = ^CMVideoCardGammaFormula;
	CMVideoCardGammaFormula = RECORD
		redGamma:				Fixed;									{  must be > 0.0  }
		redMin:					Fixed;									{  must be > 0.0 and < 1.0  }
		redMax:					Fixed;									{  must be > 0.0 and < 1.0  }
		greenGamma:				Fixed;									{  must be > 0.0  }
		greenMin:				Fixed;									{  must be > 0.0 and < 1.0  }
		greenMax:				Fixed;									{  must be > 0.0 and < 1.0  }
		blueGamma:				Fixed;									{  must be > 0.0  }
		blueMin:				Fixed;									{  must be > 0.0 and < 1.0  }
		blueMax:				Fixed;									{  must be > 0.0 and < 1.0  }
	END;

	CMVideoCardGammaPtr = ^CMVideoCardGamma;
	CMVideoCardGamma = RECORD
		tagType:				UInt32;
		CASE INTEGER OF
		0: (
			table:				CMVideoCardGammaTable;
			);
		1: (
			formula:			CMVideoCardGammaFormula;
			);
	END;

	CMVideoCardGammaTypePtr = ^CMVideoCardGammaType;
	CMVideoCardGammaType = RECORD
		typeDescriptor:			OSType;									{  'vcgt' = cmSigVideoCardGammaType  }
		reserved:				UInt32;									{  fill with 0x00  }
		gamma:					CMVideoCardGamma;
	END;

	CMMakeAndModelPtr = ^CMMakeAndModel;
	CMMakeAndModel = RECORD
		manufacturer:			OSType;
		model:					UInt32;
		serialNumber:			UInt32;
		manufactureDate:		UInt32;
		reserved1:				UInt32;									{  fill with 0x00  }
		reserved2:				UInt32;									{  fill with 0x00  }
		reserved3:				UInt32;									{  fill with 0x00  }
		reserved4:				UInt32;									{  fill with 0x00  }
	END;

	CMMakeAndModelTypePtr = ^CMMakeAndModelType;
	CMMakeAndModelType = RECORD
		typeDescriptor:			OSType;									{  'mmod' = cmSigMakeAndModelType  }
		reserved:				UInt32;									{  fill with 0x00  }
		makeAndModel:			CMMakeAndModel;
	END;

	CMMultiLocalizedUniCodeEntryRecPtr = ^CMMultiLocalizedUniCodeEntryRec;
	CMMultiLocalizedUniCodeEntryRec = RECORD
		languageCode:			PACKED ARRAY [0..1] OF CHAR;			{  language code from ISO-639  }
		regionCode:				PACKED ARRAY [0..1] OF CHAR;			{  region code from ISO-3166  }
		textLength:				UInt32;									{  the length in bytes of the string  }
		textOffset:				UInt32;									{  the offset from the start of tag in bytes  }
	END;

	CMMultiLocalizedUniCodeTypePtr = ^CMMultiLocalizedUniCodeType;
	CMMultiLocalizedUniCodeType = RECORD
		typeDescriptor:			OSType;									{  'mluc' = cmSigMultiLocalizedUniCodeType  }
		reserved:				UInt32;									{  fill with 0x00  }
		entryCount:				UInt32;									{  1-based number of name records that follow  }
		entrySize:				UInt32;									{  size in bytes of name records that follow  }
																		{  variable-length data for storage of CMMultiLocalizedUniCodeEntryRec  }
																		{  variable-length data for storage of Unicode strings }
	END;

	{	**********************************************************************	}
	{	************** ColorSync 1.0 profile specification *******************	}
	{	**********************************************************************	}

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


	{	 Device types 	}
	cmMonitorDevice				= 'mntr';
	cmScannerDevice				= 'scnr';
	cmPrinterDevice				= 'prtr';



TYPE
	CMIStringPtr = ^CMIString;
	CMIString = RECORD
		theScript:				ScriptCode;
		theString:				Str63;
	END;

	{	 Profile options 	}

CONST
	cmPerceptualMatch			= $0000;						{  Default. For photographic images  }
	cmColorimetricMatch			= $0001;						{  Exact matching when possible  }
	cmSaturationMatch			= $0002;						{  For solid colors  }

	{	 Profile flags 	}
	cmNativeMatchingPreferred	= $00000001;					{  Default to native not preferred  }
	cmTurnOffCache				= $00000002;					{  Default to turn on CMM cache  }


TYPE
	CMMatchOption						= LONGINT;
	CMMatchFlag							= LONGINT;
	CMHeaderPtr = ^CMHeader;
	CMHeader = RECORD
		size:					UInt32;
		CMMType:				OSType;
		applProfileVersion:		UInt32;
		dataType:				OSType;
		deviceType:				OSType;
		deviceManufacturer:		OSType;
		deviceModel:			UInt32;
		deviceAttributes:		ARRAY [0..1] OF UInt32;
		profileNameOffset:		UInt32;
		customDataOffset:		UInt32;
		flags:					CMMatchFlag;
		options:				CMMatchOption;
		white:					CMXYZColor;
		black:					CMXYZColor;
	END;

	CMProfileChromaticitiesPtr = ^CMProfileChromaticities;
	CMProfileChromaticities = RECORD
		red:					CMXYZColor;
		green:					CMXYZColor;
		blue:					CMXYZColor;
		cyan:					CMXYZColor;
		magenta:				CMXYZColor;
		yellow:					CMXYZColor;
	END;

	CMProfileResponsePtr = ^CMProfileResponse;
	CMProfileResponse = RECORD
		counts:					ARRAY [0..8] OF UInt16;
		data:					ARRAY [0..0] OF UInt16;					{  Variable size  }
	END;

	CMProfilePtr = ^CMProfile;
	CMProfile = RECORD
		header:					CMHeader;
		profile:				CMProfileChromaticities;
		response:				CMProfileResponse;
		profileName:			CMIString;
		customData:				SInt8;									{  Variable size  }
	END;

	CMProfileHandle						= ^CMProfilePtr;
{$IFC OLDROUTINENAMES }

CONST
	kCMApplProfileVersion		= $00000100;

	grayResponse				= 0;
	redResponse					= 1;
	greenResponse				= 2;
	blueResponse				= 3;
	cyanResponse				= 4;
	magentaResponse				= 5;
	yellowResponse				= 6;
	ucrResponse					= 7;
	bgResponse					= 8;
	onePlusLastResponse			= 9;

	rgbData						= 'RGB ';
	cmykData					= 'CMYK';
	grayData					= 'GRAY';
	xyzData						= 'XYZ ';

	monitorDevice				= 'mntr';
	scannerDevice				= 'scnr';
	printerDevice				= 'prtr';


TYPE
	XYZComponent						= UInt16;
	XYZColor							= CMXYZColor;
	XYZColorPtr 						= ^XYZColor;
	CMResponseData						= UInt16;
	IString								= CMIString;
	IStringPtr 							= ^IString;
	CMResponseColor						= LONGINT;
	responseColor						= CMResponseColor;
{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMICCProfileIncludes}

{$ENDC} {__CMICCPROFILE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
