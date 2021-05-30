{
     File:       UnicodeConverter.p
 
     Contains:   Types, constants, and prototypes for Unicode Converter
 
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
 UNIT UnicodeConverter;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __UNICODECONVERTER__}
{$SETC __UNICODECONVERTER__ := 1}

{$I+}
{$SETC UnicodeConverterIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Unicode conversion contexts: }

TYPE
	TextToUnicodeInfo    = ^LONGINT; { an opaque 32-bit type }
	TextToUnicodeInfoPtr = ^TextToUnicodeInfo;  { when a VAR xx:TextToUnicodeInfo parameter can be nil, it is changed to xx: TextToUnicodeInfoPtr }
	UnicodeToTextInfo    = ^LONGINT; { an opaque 32-bit type }
	UnicodeToTextInfoPtr = ^UnicodeToTextInfo;  { when a VAR xx:UnicodeToTextInfo parameter can be nil, it is changed to xx: UnicodeToTextInfoPtr }
	UnicodeToTextRunInfo    = ^LONGINT; { an opaque 32-bit type }
	UnicodeToTextRunInfoPtr = ^UnicodeToTextRunInfo;  { when a VAR xx:UnicodeToTextRunInfo parameter can be nil, it is changed to xx: UnicodeToTextRunInfoPtr }
	ConstTextToUnicodeInfo				= TextToUnicodeInfo;
	ConstUnicodeToTextInfo				= UnicodeToTextInfo;
	{	 UnicodeMapVersion type & values 	}
	UnicodeMapVersion					= SInt32;

CONST
	kUnicodeUseLatestMapping	= -1;
	kUnicodeUseHFSPlusMapping	= 4;

	{	 Types used in conversion 	}

TYPE
	UnicodeMappingPtr = ^UnicodeMapping;
	UnicodeMapping = RECORD
		unicodeEncoding:		TextEncoding;
		otherEncoding:			TextEncoding;
		mappingVersion:			UnicodeMapVersion;
	END;

	ConstUnicodeMappingPtr				= ^UnicodeMapping;
	{	 Control flags for ConvertFromUnicodeToText and ConvertFromTextToUnicode 	}

CONST
	kUnicodeUseFallbacksBit		= 0;
	kUnicodeKeepInfoBit			= 1;
	kUnicodeDirectionalityBits	= 2;
	kUnicodeVerticalFormBit		= 4;
	kUnicodeLooseMappingsBit	= 5;
	kUnicodeStringUnterminatedBit = 6;
	kUnicodeTextRunBit			= 7;
	kUnicodeKeepSameEncodingBit	= 8;
	kUnicodeForceASCIIRangeBit	= 9;
	kUnicodeNoHalfwidthCharsBit	= 10;
	kUnicodeTextRunHeuristicsBit = 11;

	kUnicodeUseFallbacksMask	= $00000001;
	kUnicodeKeepInfoMask		= $00000002;
	kUnicodeDirectionalityMask	= $0000000C;
	kUnicodeVerticalFormMask	= $00000010;
	kUnicodeLooseMappingsMask	= $00000020;
	kUnicodeStringUnterminatedMask = $00000040;
	kUnicodeTextRunMask			= $00000080;
	kUnicodeKeepSameEncodingMask = $00000100;
	kUnicodeForceASCIIRangeMask	= $00000200;
	kUnicodeNoHalfwidthCharsMask = $00000400;
	kUnicodeTextRunHeuristicsMask = $00000800;

	{	 Values for kUnicodeDirectionality field 	}
	kUnicodeDefaultDirection	= 0;
	kUnicodeLeftToRight			= 1;
	kUnicodeRightToLeft			= 2;

	{	 Directionality masks for control flags 	}
	kUnicodeDefaultDirectionMask = $00;
	kUnicodeLeftToRightMask		= $04;
	kUnicodeRightToLeftMask		= $08;


	{	 Control flags for TruncateForUnicodeToText: 	}
	{
	   Now TruncateForUnicodeToText uses control flags from the same set as used by
	   ConvertFromTextToUnicode, ConvertFromUnicodeToText, etc., but only
	   kUnicodeStringUnterminatedMask is meaningful for TruncateForUnicodeToText.
	   
	   Previously two special control flags were defined for TruncateForUnicodeToText:
	        kUnicodeTextElementSafeBit = 0
	        kUnicodeRestartSafeBit = 1
	   However, neither of these was implemented.
	   Instead of implementing kUnicodeTextElementSafeBit, we now use
	   kUnicodeStringUnterminatedMask since it accomplishes the same thing and avoids
	   having special flags just for TruncateForUnicodeToText
	   Also, kUnicodeRestartSafeBit is unnecessary, since restart-safeness is handled by
	   setting kUnicodeKeepInfoBit with ConvertFromUnicodeToText.
	   If TruncateForUnicodeToText is called with one or both of the old special control
	   flags set (bits 0 or 1), it will not generate a paramErr, but the old bits have no
	   effect on its operation.
	}

	{	 Filter bits for filter field in QueryUnicodeMappings and CountUnicodeMappings: 	}
	kUnicodeMatchUnicodeBaseBit	= 0;
	kUnicodeMatchUnicodeVariantBit = 1;
	kUnicodeMatchUnicodeFormatBit = 2;
	kUnicodeMatchOtherBaseBit	= 3;
	kUnicodeMatchOtherVariantBit = 4;
	kUnicodeMatchOtherFormatBit	= 5;

	kUnicodeMatchUnicodeBaseMask = $00000001;
	kUnicodeMatchUnicodeVariantMask = $00000002;
	kUnicodeMatchUnicodeFormatMask = $00000004;
	kUnicodeMatchOtherBaseMask	= $00000008;
	kUnicodeMatchOtherVariantMask = $00000010;
	kUnicodeMatchOtherFormatMask = $00000020;

	{	 Control flags for SetFallbackUnicodeToText 	}
	kUnicodeFallbackSequencingBits = 0;

	kUnicodeFallbackSequencingMask = $00000003;
	kUnicodeFallbackInterruptSafeMask = $00000004;				{  To indicate that caller fallback routine doesn’t move memory }

	{	 values for kUnicodeFallbackSequencing field 	}
	kUnicodeFallbackDefaultOnly	= 0;
	kUnicodeFallbackCustomOnly	= 1;
	kUnicodeFallbackDefaultFirst = 2;
	kUnicodeFallbackCustomFirst	= 3;


	{	 Caller-supplied entry point to a fallback handler 	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	UnicodeToTextFallbackProcPtr = FUNCTION(VAR iSrcUniStr: UniChar; iSrcUniStrLen: ByteCount; VAR oSrcConvLen: ByteCount; oDestStr: TextPtr; iDestStrLen: ByteCount; VAR oDestConvLen: ByteCount; iInfoPtr: LogicalAddress; iUnicodeMappingPtr: ConstUnicodeMappingPtr): OSStatus;
{$ELSEC}
	UnicodeToTextFallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	UnicodeToTextFallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	UnicodeToTextFallbackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppUnicodeToTextFallbackProcInfo = $003FFFF0;
	{
	 *  NewUnicodeToTextFallbackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewUnicodeToTextFallbackUPP(userRoutine: UnicodeToTextFallbackProcPtr): UnicodeToTextFallbackUPP; { old name was NewUnicodeToTextFallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeUnicodeToTextFallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeUnicodeToTextFallbackUPP(userUPP: UnicodeToTextFallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeUnicodeToTextFallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeUnicodeToTextFallbackUPP(VAR iSrcUniStr: UniChar; iSrcUniStrLen: ByteCount; VAR oSrcConvLen: ByteCount; oDestStr: TextPtr; iDestStrLen: ByteCount; VAR oDestConvLen: ByteCount; iInfoPtr: LogicalAddress; iUnicodeMappingPtr: ConstUnicodeMappingPtr; userRoutine: UnicodeToTextFallbackUPP): OSStatus; { old name was CallUnicodeToTextFallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{ Function prototypes }
{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM }
{
    Routine to Initialize the Unicode Converter and cleanup once done with it. 
    These routines must be called from Static Library clients.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  InitializeUnicodeConverter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitializeUnicodeConverter(TECFileName: StringPtr): OSStatus;

{
 *  TerminateUnicodeConverter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TerminateUnicodeConverter;

{  Note: the old names (InitializeUnicode, TerminateUnicode) for the above are still exported. }
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
 *  CreateTextToUnicodeInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateTextToUnicodeInfo(iUnicodeMapping: ConstUnicodeMappingPtr; VAR oTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;

{
 *  CreateTextToUnicodeInfoByEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateTextToUnicodeInfoByEncoding(iEncoding: TextEncoding; VAR oTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;

{
 *  CreateUnicodeToTextInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateUnicodeToTextInfo(iUnicodeMapping: ConstUnicodeMappingPtr; VAR oUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;

{
 *  CreateUnicodeToTextInfoByEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateUnicodeToTextInfoByEncoding(iEncoding: TextEncoding; VAR oUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;

{
 *  CreateUnicodeToTextRunInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateUnicodeToTextRunInfo(iNumberOfMappings: ItemCount; {CONST}VAR iUnicodeMappings: UnicodeMapping; VAR oUnicodeToTextInfo: UnicodeToTextRunInfo): OSStatus;

{
 *  CreateUnicodeToTextRunInfoByEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateUnicodeToTextRunInfoByEncoding(iNumberOfEncodings: ItemCount; {CONST}VAR iEncodings: TextEncoding; VAR oUnicodeToTextInfo: UnicodeToTextRunInfo): OSStatus;

{
 *  CreateUnicodeToTextRunInfoByScriptCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateUnicodeToTextRunInfoByScriptCode(iNumberOfScriptCodes: ItemCount; {CONST}VAR iScripts: ScriptCode; VAR oUnicodeToTextInfo: UnicodeToTextRunInfo): OSStatus;

{ Change the TextToUnicodeInfo to another mapping. }
{
 *  ChangeTextToUnicodeInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeTextToUnicodeInfo(ioTextToUnicodeInfo: TextToUnicodeInfo; iUnicodeMapping: ConstUnicodeMappingPtr): OSStatus;

{ Change the UnicodeToTextInfo to another mapping. }
{
 *  ChangeUnicodeToTextInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeUnicodeToTextInfo(ioUnicodeToTextInfo: UnicodeToTextInfo; iUnicodeMapping: ConstUnicodeMappingPtr): OSStatus;


{
 *  DisposeTextToUnicodeInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeTextToUnicodeInfo(VAR ioTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;

{
 *  DisposeUnicodeToTextInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeUnicodeToTextInfo(VAR ioUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;

{
 *  DisposeUnicodeToTextRunInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeUnicodeToTextRunInfo(VAR ioUnicodeToTextRunInfo: UnicodeToTextRunInfo): OSStatus;

{
 *  ConvertFromTextToUnicode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertFromTextToUnicode(iTextToUnicodeInfo: TextToUnicodeInfo; iSourceLen: ByteCount; iSourceStr: ConstLogicalAddress; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oSourceRead: ByteCount; VAR oUnicodeLen: ByteCount; VAR oUnicodeStr: UniChar): OSStatus;

{
 *  ConvertFromUnicodeToText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertFromUnicodeToText(iUnicodeToTextInfo: UnicodeToTextInfo; iUnicodeLen: ByteCount; {CONST}VAR iUnicodeStr: UniChar; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oInputRead: ByteCount; VAR oOutputLen: ByteCount; oOutputStr: LogicalAddress): OSStatus;

{
 *  ConvertFromUnicodeToTextRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertFromUnicodeToTextRun(iUnicodeToTextInfo: UnicodeToTextRunInfo; iUnicodeLen: ByteCount; {CONST}VAR iUnicodeStr: UniChar; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oInputRead: ByteCount; VAR oOutputLen: ByteCount; oOutputStr: LogicalAddress; iEncodingRunBufLen: ItemCount; VAR oEncodingRunOutLen: ItemCount; VAR oEncodingRuns: TextEncodingRun): OSStatus;

{
 *  ConvertFromUnicodeToScriptCodeRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertFromUnicodeToScriptCodeRun(iUnicodeToTextInfo: UnicodeToTextRunInfo; iUnicodeLen: ByteCount; {CONST}VAR iUnicodeStr: UniChar; iControlFlags: OptionBits; iOffsetCount: ItemCount; iOffsetArray: LongIntPtr; VAR oOffsetCount: ItemCount; oOffsetArray: LongIntPtr; iOutputBufLen: ByteCount; VAR oInputRead: ByteCount; VAR oOutputLen: ByteCount; oOutputStr: LogicalAddress; iScriptRunBufLen: ItemCount; VAR oScriptRunOutLen: ItemCount; VAR oScriptCodeRuns: ScriptCodeRun): OSStatus;

{ Truncate a multibyte string at a safe place. }
{
 *  TruncateForTextToUnicode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TruncateForTextToUnicode(iTextToUnicodeInfo: ConstTextToUnicodeInfo; iSourceLen: ByteCount; iSourceStr: ConstLogicalAddress; iMaxLen: ByteCount; VAR oTruncatedLen: ByteCount): OSStatus;

{ Truncate a Unicode string at a safe place. }
{
 *  TruncateForUnicodeToText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TruncateForUnicodeToText(iUnicodeToTextInfo: ConstUnicodeToTextInfo; iSourceLen: ByteCount; {CONST}VAR iSourceStr: UniChar; iControlFlags: OptionBits; iMaxLen: ByteCount; VAR oTruncatedLen: ByteCount): OSStatus;

{ Convert a Pascal string to Unicode string. }
{
 *  ConvertFromPStringToUnicode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertFromPStringToUnicode(iTextToUnicodeInfo: TextToUnicodeInfo; iPascalStr: Str255; iOutputBufLen: ByteCount; VAR oUnicodeLen: ByteCount; VAR oUnicodeStr: UniChar): OSStatus;

{ Convert a Unicode string to Pascal string. }
{
 *  ConvertFromUnicodeToPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertFromUnicodeToPString(iUnicodeToTextInfo: UnicodeToTextInfo; iUnicodeLen: ByteCount; {CONST}VAR iUnicodeStr: UniChar; VAR oPascalStr: Str255): OSStatus;

{ Count the available conversion mappings. }
{
 *  CountUnicodeMappings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountUnicodeMappings(iFilter: OptionBits; iFindMapping: ConstUnicodeMappingPtr; VAR oActualCount: ItemCount): OSStatus;

{ Get a list of the available conversion mappings. }
{
 *  QueryUnicodeMappings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QueryUnicodeMappings(iFilter: OptionBits; iFindMapping: ConstUnicodeMappingPtr; iMaxCount: ItemCount; VAR oActualCount: ItemCount; VAR oReturnedMappings: UnicodeMapping): OSStatus;

{ Setup the fallback handler for converting Unicode To Text. }
{
 *  SetFallbackUnicodeToText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetFallbackUnicodeToText(iUnicodeToTextInfo: UnicodeToTextInfo; iFallback: UnicodeToTextFallbackUPP; iControlFlags: OptionBits; iInfoPtr: LogicalAddress): OSStatus;

{ Setup the fallback handler for converting Unicode To TextRuns. }
{
 *  SetFallbackUnicodeToTextRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetFallbackUnicodeToTextRun(iUnicodeToTextRunInfo: UnicodeToTextRunInfo; iFallback: UnicodeToTextFallbackUPP; iControlFlags: OptionBits; iInfoPtr: LogicalAddress): OSStatus;

{ Re-initialize all state information kept by the context objects. }
{
 *  ResetTextToUnicodeInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.3 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResetTextToUnicodeInfo(ioTextToUnicodeInfo: TextToUnicodeInfo): OSStatus;

{ Re-initialize all state information kept by the context objects. }
{
 *  ResetUnicodeToTextInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResetUnicodeToTextInfo(ioUnicodeToTextInfo: UnicodeToTextInfo): OSStatus;

{ Re-initialize all state information kept by the context objects in TextRun conversions. }
{
 *  ResetUnicodeToTextRunInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResetUnicodeToTextRunInfo(ioUnicodeToTextRunInfo: UnicodeToTextRunInfo): OSStatus;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := UnicodeConverterIncludes}

{$ENDC} {__UNICODECONVERTER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
