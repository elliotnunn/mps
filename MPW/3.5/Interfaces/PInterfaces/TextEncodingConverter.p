{
     File:       TextEncodingConverter.p
 
     Contains:   Text Encoding Conversion Interfaces.
 
     Version:    Technology: Mac OS 9.0
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
 UNIT TextEncodingConverter;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTENCODINGCONVERTER__}
{$SETC __TEXTENCODINGCONVERTER__ := 1}

{$I+}
{$SETC TextEncodingConverterIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	TECPluginSignature					= OSType;
	TECPluginVersion					= UInt32;
	{	 plugin signatures 	}

CONST
	kTECSignature				= 'encv';
	kTECUnicodePluginSignature	= 'puni';
	kTECJapanesePluginSignature	= 'pjpn';
	kTECChinesePluginSignature	= 'pzho';
	kTECKoreanPluginSignature	= 'pkor';


	{	 converter object reference 	}

TYPE
	TECObjectRef    = ^LONGINT; { an opaque 32-bit type }
	TECObjectRefPtr = ^TECObjectRef;  { when a VAR xx:TECObjectRef parameter can be nil, it is changed to xx: TECObjectRefPtr }
	TECSnifferObjectRef    = ^LONGINT; { an opaque 32-bit type }
	TECSnifferObjectRefPtr = ^TECSnifferObjectRef;  { when a VAR xx:TECSnifferObjectRef parameter can be nil, it is changed to xx: TECSnifferObjectRefPtr }
	TECPluginSig						= OSType;
	TECConversionInfoPtr = ^TECConversionInfo;
	TECConversionInfo = RECORD
		sourceEncoding:			TextEncoding;
		destinationEncoding:	TextEncoding;
		reserved1:				UInt16;
		reserved2:				UInt16;
	END;

	{	 return number of encodings types supported by user's configuraton of the encoding converter 	}
	{
	 *  TECCountAvailableTextEncodings()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION TECCountAvailableTextEncodings(VAR numberEncodings: ItemCount): OSStatus;

{ fill in an array of type TextEncoding passed in by the user with types of encodings the current configuration of the encoder can handle. }
{
 *  TECGetAvailableTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetAvailableTextEncodings(VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus;

{ return number of from-to encoding conversion pairs supported  }
{
 *  TECCountDirectTextEncodingConversions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCountDirectTextEncodingConversions(VAR numberOfEncodings: ItemCount): OSStatus;

{ fill in an array of type TextEncodingPair passed in by the user with types of encoding pairs the current configuration of the encoder can handle. }
{
 *  TECGetDirectTextEncodingConversions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetDirectTextEncodingConversions(VAR availableConversions: TECConversionInfo; maxAvailableConversions: ItemCount; VAR actualAvailableConversions: ItemCount): OSStatus;

{ return number of encodings a given encoding can be converter into }
{
 *  TECCountDestinationTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCountDestinationTextEncodings(inputEncoding: TextEncoding; VAR numberOfEncodings: ItemCount): OSStatus;

{ fill in an array of type TextEncodingPair passed in by the user with types of encodings pairs the current configuration of the encoder can handle. }
{
 *  TECGetDestinationTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetDestinationTextEncodings(inputEncoding: TextEncoding; VAR destinationEncodings: TextEncoding; maxDestinationEncodings: ItemCount; VAR actualDestinationEncodings: ItemCount): OSStatus;

{ get info about a text encoding }
{
 *  TECGetTextEncodingInternetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetTextEncodingInternetName(textEncoding: TextEncoding; VAR encodingName: Str255): OSStatus;

{
 *  TECGetTextEncodingFromInternetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetTextEncodingFromInternetName(VAR textEncoding: TextEncoding; encodingName: Str255): OSStatus;

{ create/dispose converters }
{
 *  TECCreateConverter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCreateConverter(VAR newEncodingConverter: TECObjectRef; inputEncoding: TextEncoding; outputEncoding: TextEncoding): OSStatus;

{
 *  TECCreateConverterFromPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCreateConverterFromPath(VAR newEncodingConverter: TECObjectRef; {CONST}VAR inPath: TextEncoding; inEncodings: ItemCount): OSStatus;

{
 *  TECDisposeConverter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECDisposeConverter(newEncodingConverter: TECObjectRef): OSStatus;

{ convert text encodings }
{
 *  TECClearConverterContextInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECClearConverterContextInfo(encodingConverter: TECObjectRef): OSStatus;

{
 *  TECConvertText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECConvertText(encodingConverter: TECObjectRef; inputBuffer: ConstTextPtr; inputBufferLength: ByteCount; VAR actualInputLength: ByteCount; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount): OSStatus;

{
 *  TECFlushText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECFlushText(encodingConverter: TECObjectRef; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount): OSStatus;

{ one-to-many routines }
{
 *  TECCountSubTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCountSubTextEncodings(inputEncoding: TextEncoding; VAR numberOfEncodings: ItemCount): OSStatus;

{
 *  TECGetSubTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetSubTextEncodings(inputEncoding: TextEncoding; VAR subEncodings: TextEncoding; maxSubEncodings: ItemCount; VAR actualSubEncodings: ItemCount): OSStatus;

{
 *  TECGetEncodingList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetEncodingList(encodingConverter: TECObjectRef; VAR numEncodings: ItemCount; VAR encodingList: Handle): OSStatus;

{
 *  TECCreateOneToManyConverter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCreateOneToManyConverter(VAR newEncodingConverter: TECObjectRef; inputEncoding: TextEncoding; numOutputEncodings: ItemCount; {CONST}VAR outputEncodings: TextEncoding): OSStatus;

{
 *  TECConvertTextToMultipleEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECConvertTextToMultipleEncodings(encodingConverter: TECObjectRef; inputBuffer: ConstTextPtr; inputBufferLength: ByteCount; VAR actualInputLength: ByteCount; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount; VAR outEncodingsBuffer: TextEncodingRun; maxOutEncodingRuns: ItemCount; VAR actualOutEncodingRuns: ItemCount): OSStatus;

{
 *  TECFlushMultipleEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECFlushMultipleEncodings(encodingConverter: TECObjectRef; outputBuffer: TextPtr; outputBufferLength: ByteCount; VAR actualOutputLength: ByteCount; VAR outEncodingsBuffer: TextEncodingRun; maxOutEncodingRuns: ItemCount; VAR actualOutEncodingRuns: ItemCount): OSStatus;

{ international internet info }
{
 *  TECCountWebTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCountWebTextEncodings(locale: RegionCode; VAR numberEncodings: ItemCount): OSStatus;

{
 *  TECGetWebTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetWebTextEncodings(locale: RegionCode; VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus;

{
 *  TECCountMailTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCountMailTextEncodings(locale: RegionCode; VAR numberEncodings: ItemCount): OSStatus;

{
 *  TECGetMailTextEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetMailTextEncodings(locale: RegionCode; VAR availableEncodings: TextEncoding; maxAvailableEncodings: ItemCount; VAR actualAvailableEncodings: ItemCount): OSStatus;

{ examine text encodings }
{
 *  TECCountAvailableSniffers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCountAvailableSniffers(VAR numberOfEncodings: ItemCount): OSStatus;

{
 *  TECGetAvailableSniffers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECGetAvailableSniffers(VAR availableSniffers: TextEncoding; maxAvailableSniffers: ItemCount; VAR actualAvailableSniffers: ItemCount): OSStatus;

{
 *  TECCreateSniffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECCreateSniffer(VAR encodingSniffer: TECSnifferObjectRef; VAR testEncodings: TextEncoding; numTextEncodings: ItemCount): OSStatus;

{
 *  TECSniffTextEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECSniffTextEncoding(encodingSniffer: TECSnifferObjectRef; inputBuffer: TextPtr; inputBufferLength: ByteCount; VAR testEncodings: TextEncoding; numTextEncodings: ItemCount; VAR numErrsArray: ItemCount; maxErrs: ItemCount; VAR numFeaturesArray: ItemCount; maxFeatures: ItemCount): OSStatus;

{
 *  TECDisposeSniffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECDisposeSniffer(encodingSniffer: TECSnifferObjectRef): OSStatus;

{
 *  TECClearSnifferContextInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TECClearSnifferContextInfo(encodingSniffer: TECSnifferObjectRef): OSStatus;

{$IFC CALL_NOT_IN_CARBON }
{
 *  TECSetBasicOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in TextEncodingConverter 1.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TECSetBasicOptions(encodingConverter: TECObjectRef; controlFlags: OptionBits): OSStatus;

{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextEncodingConverterIncludes}

{$ENDC} {__TEXTENCODINGCONVERTER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
