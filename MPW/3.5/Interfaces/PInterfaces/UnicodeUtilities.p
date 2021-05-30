{
     File:       UnicodeUtilities.p
 
     Contains:   Types, constants, prototypes for Unicode Utilities (Unicode input and text utils)
 
     Version:    Technology: Mac OS 9.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT UnicodeUtilities;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __UNICODEUTILITIES__}
{$SETC __UNICODEUTILITIES__ := 1}

{$I+}
{$SETC UnicodeUtilitiesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{$IFC UNDEFINED __MACLOCALES__}
{$I MacLocales.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   -------------------------------------------------------------------------------------------------
   CONSTANTS & DATA STRUCTURES for UCKeyTranslate & UCKeyboardLayout ('uchr' resource)
   -------------------------------------------------------------------------------------------------
}

{
   -------------------------------------------------------------------------------------------------
   UCKeyOutput & related stuff
   The interpretation of UCKeyOutput depends on bits 15-14.
   If they are 01, then bits 0-13 are an index in UCKeyStateRecordsIndex (resource-wide list).
   If they are 10, then bits 0-13 are an index in UCKeySequenceDataIndex (resource-wide list),
     or if UCKeySequenceDataIndex is not present or the index is beyond the end of the list,
     then bits 0-15 are a single Unicode character.
   Otherwise, bits 0-15 are a single Unicode character; a value of 0xFFFE-0xFFFF means no character
     output.
   UCKeyCharSeq is similar, but does not support indices in UCKeyStateRecordsIndex. For bits 15-14:
   If they are 10, then bits 0-13 are an index in UCKeySequenceDataIndex (resource-wide list),
     or if UCKeySequenceDataIndex is not present or the index is beyond the end of the list,
     then bits 0-15 are a single Unicode character.
   Otherwise, bits 0-15 are a single Unicode character; a value of 0xFFFE-0xFFFF means no character
     output.
   -------------------------------------------------------------------------------------------------
}


TYPE
	UCKeyOutput							= UInt16;
	UCKeyCharSeq						= UInt16;

CONST
	kUCKeyOutputStateIndexMask	= $4000;
	kUCKeyOutputSequenceIndexMask = $8000;
	kUCKeyOutputTestForIndexMask = $C000;						{  test bits 14-15 }
	kUCKeyOutputGetIndexMask	= $3FFF;						{  get bits 0-13 }

	{
	   -------------------------------------------------------------------------------------------------
	   UCKeyStateRecord & related stuff
	   The UCKeyStateRecord information is used as follows. If the current state is zero,
	   output stateZeroCharData and set the state to stateZeroNextState. If the current state
	   is non-zero and there is an entry for it in stateEntryData, then output the corresponding
	   charData and set the state to nextState. Otherwise, output the state terminator from
	   UCKeyStateTerminators for the current state (or nothing if there is no UCKeyStateTerminators
	   table or it has no entry for the current state), then output stateZeroCharData and set the
	   state to stateZeroNextState.
	   -------------------------------------------------------------------------------------------------
	}


TYPE
	UCKeyStateRecordPtr = ^UCKeyStateRecord;
	UCKeyStateRecord = RECORD
		stateZeroCharData:		UCKeyCharSeq;
		stateZeroNextState:		UInt16;
		stateEntryCount:		UInt16;
		stateEntryFormat:		UInt16;
																		{  This is followed by an array of stateEntryCount elements }
																		{  in the specified format. Here we just show a dummy array. }
		stateEntryData:			ARRAY [0..0] OF UInt32;
	END;

	{
	   Here are the codes for entry formats currently defined.
	   Each entry maps from curState to charData and nextState.
	}

CONST
	kUCKeyStateEntryTerminalFormat = $0001;
	kUCKeyStateEntryRangeFormat	= $0002;

	{
	   For UCKeyStateEntryTerminal -
	   nextState is always 0, so we don't have a field for it
	}


TYPE
	UCKeyStateEntryTerminalPtr = ^UCKeyStateEntryTerminal;
	UCKeyStateEntryTerminal = RECORD
		curState:				UInt16;
		charData:				UCKeyCharSeq;
	END;

	{
	   For UCKeyStateEntryRange -
	   If curState >= curStateStart and curState <= curStateStart+curStateRange,
	   then it matches the entry, and we transform charData and nextState as follows:
	   If charData < 0xFFFE, then charData += (curState-curStateStart)*deltaMultiplier
	   If nextState != 0, then nextState += (curState-curStateStart)*deltaMultiplier
	}
	UCKeyStateEntryRangePtr = ^UCKeyStateEntryRange;
	UCKeyStateEntryRange = RECORD
		curStateStart:			UInt16;
		curStateRange:			SInt8;
		deltaMultiplier:		SInt8;
		charData:				UCKeyCharSeq;
		nextState:				UInt16;
	END;

	{
	   -------------------------------------------------------------------------------------------------
	   UCKeyboardLayout & related stuff
	   The UCKeyboardLayout struct given here is only for the resource header. It specifies
	   offsets to the various subtables which each have their own structs, given below.
	   The keyboardTypeHeadList array selects table offsets that depend on keyboardType. The
	   first entry in keyboardTypeHeadList is the default entry, which will be used if the
	   keyboardType passed to UCKeyTranslate does not match any other entry - i.e. does not fall
	   within the range keyboardTypeFirst..keyboardTypeLast for some entry. The first entry
	   should have keyboardTypeFirst = keyboardTypeLast = 0.
	   -------------------------------------------------------------------------------------------------
	}
	UCKeyboardTypeHeaderPtr = ^UCKeyboardTypeHeader;
	UCKeyboardTypeHeader = RECORD
		keyboardTypeFirst:		UInt32;									{  first keyboardType in this entry }
		keyboardTypeLast:		UInt32;									{  last keyboardType in this entry }
		keyModifiersToTableNumOffset: ByteOffset;						{  required }
		keyToCharTableIndexOffset: ByteOffset;							{  required }
		keyStateRecordsIndexOffset: ByteOffset;							{  0 => no table }
		keyStateTerminatorsOffset: ByteOffset;							{  0 => no table }
		keySequenceDataIndexOffset: ByteOffset;							{  0 => no table }
	END;

	UCKeyboardLayoutPtr = ^UCKeyboardLayout;
	UCKeyboardLayout = RECORD
																		{  header only; other tables accessed via offsets }
		keyLayoutHeaderFormat:	UInt16;									{  =kUCKeyLayoutHeaderFormat }
		keyLayoutDataVersion:	UInt16;									{  0x0100 = 1.0, 0x0110 = 1.1, etc. }
		keyLayoutFeatureInfoOffset: ByteOffset;							{  may be 0                        }
		keyboardTypeCount:		ItemCount;								{  Dimension for keyboardTypeHeadList[]      }
		keyboardTypeList:		ARRAY [0..0] OF UCKeyboardTypeHeader;
	END;

	{  ------------------------------------------------------------------------------------------------- }
	UCKeyLayoutFeatureInfoPtr = ^UCKeyLayoutFeatureInfo;
	UCKeyLayoutFeatureInfo = RECORD
		keyLayoutFeatureInfoFormat: UInt16;								{  =kUCKeyLayoutFeatureInfoFormat }
		reserved:				UInt16;
		maxOutputStringLength:	UniCharCount;							{  longest possible output string }
	END;

	{  ------------------------------------------------------------------------------------------------- }
	UCKeyModifiersToTableNumPtr = ^UCKeyModifiersToTableNum;
	UCKeyModifiersToTableNum = RECORD
		keyModifiersToTableNumFormat: UInt16;							{  =kUCKeyModifiersToTableNumFormat }
		defaultTableNum:		UInt16;									{  For modifier combos not in tableNum[] }
		modifiersCount:			ItemCount;								{  Dimension for tableNum[] }
		tableNum:				SInt8;
																		{  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary. }
	END;

	{  ------------------------------------------------------------------------------------------------- }
	UCKeyToCharTableIndexPtr = ^UCKeyToCharTableIndex;
	UCKeyToCharTableIndex = RECORD
		keyToCharTableIndexFormat: UInt16;								{  =kUCKeyToCharTableIndexFormat }
		keyToCharTableSize:		UInt16;									{  Max keyCode (128 for ADB keyboards) }
		keyToCharTableCount:	ItemCount;								{  Dimension for keyToCharTableOffsets[] (usually 6 to 12 tables) }
		keyToCharTableOffsets:	ARRAY [0..0] OF ByteOffset;
																		{  Each offset in keyToCharTableOffsets is from the beginning of the resource to a }
																		{  table as follows: }
																		{     UCKeyOutput       keyToCharData[keyToCharTableSize]; }
																		{  These tables follow the UCKeyToCharTableIndex. }
																		{  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary. }
	END;

	{  ------------------------------------------------------------------------------------------------- }
	UCKeyStateRecordsIndexPtr = ^UCKeyStateRecordsIndex;
	UCKeyStateRecordsIndex = RECORD
		keyStateRecordsIndexFormat: UInt16;								{  =kUCKeyStateRecordsIndexFormat }
		keyStateRecordCount:	UInt16;									{  Dimension for keyStateRecordOffsets[] }
		keyStateRecordOffsets:	ARRAY [0..0] OF ByteOffset;
																		{  Each offset in keyStateRecordOffsets is from the beginning of the resource to a }
																		{  UCKeyStateRecord. These UCKeyStateRecords follow the keyStateRecordOffsets[] array. }
																		{  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary. }
	END;

	{  ------------------------------------------------------------------------------------------------- }
	UCKeyStateTerminatorsPtr = ^UCKeyStateTerminators;
	UCKeyStateTerminators = RECORD
		keyStateTerminatorsFormat: UInt16;								{  =kUCKeyStateTerminatorsFormat }
		keyStateTerminatorCount: UInt16;								{  Dimension for keyStateTerminators[] (# of nonzero states) }
		keyStateTerminators:	ARRAY [0..0] OF UCKeyCharSeq;
																		{  Note: keyStateTerminators[0] is terminator for state 1, etc. }
																		{  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary. }
	END;

	{  ------------------------------------------------------------------------------------------------- }
	UCKeySequenceDataIndexPtr = ^UCKeySequenceDataIndex;
	UCKeySequenceDataIndex = RECORD
		keySequenceDataIndexFormat: UInt16;								{  =kUCKeySequenceDataIndexFormat }
		charSequenceCount:		UInt16;									{  Dimension of charSequenceOffsets[] is charSequenceCount+1 }
		charSequenceOffsets:	ARRAY [0..0] OF UInt16;
																		{  Each offset in charSequenceOffsets is in bytes, from the beginning of }
																		{  UCKeySequenceDataIndex to a sequence of UniChars; the next offset indicates the }
																		{  end of the sequence. The UniChar sequences follow the UCKeySequenceDataIndex. }
																		{  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary. }
	END;

	{  ------------------------------------------------------------------------------------------------- }
	{  Current format codes for the various tables (bits 12-15 indicate which table) }


CONST
	kUCKeyLayoutHeaderFormat	= $1002;
	kUCKeyLayoutFeatureInfoFormat = $2001;
	kUCKeyModifiersToTableNumFormat = $3001;
	kUCKeyToCharTableIndexFormat = $4001;
	kUCKeyStateRecordsIndexFormat = $5001;
	kUCKeyStateTerminatorsFormat = $6001;
	kUCKeySequenceDataIndexFormat = $7001;


	{
	   -------------------------------------------------------------------------------------------------
	   Constants for keyAction parameter in UCKeyTranslate() 
	   -------------------------------------------------------------------------------------------------
	}

	kUCKeyActionDown			= 0;							{  key is going down }
	kUCKeyActionUp				= 1;							{  key is going up }
	kUCKeyActionAutoKey			= 2;							{  auto-key down }
	kUCKeyActionDisplay			= 3;							{  get information for key display (as in Key Caps)       }

	{
	   -------------------------------------------------------------------------------------------------
	   Bit assignments & masks for keyTranslateOptions parameter in UCKeyTranslate() 
	   -------------------------------------------------------------------------------------------------
	}

	kUCKeyTranslateNoDeadKeysBit = 0;							{  Prevents setting any new dead-key states }

	kUCKeyTranslateNoDeadKeysMask = $00000001;

	{
	   -------------------------------------------------------------------------------------------------
	   CONSTANTS & DATA STRUCTURES for Unicode Collation
	   -------------------------------------------------------------------------------------------------
	}
	{  constant for LocaleOperationClass }
	kUnicodeCollationClass		= 'ucol';


TYPE
	CollatorRef    = ^LONGINT; { an opaque 32-bit type }
	CollatorRefPtr = ^CollatorRef;  { when a VAR xx:CollatorRef parameter can be nil, it is changed to xx: CollatorRefPtr }
	UCCollateOptions 			= UInt32;
CONST
																{  Sensitivity options }
	kUCCollateComposeInsensitiveMask = $00000002;
	kUCCollateWidthInsensitiveMask = $00000004;
	kUCCollateCaseInsensitiveMask = $00000008;
	kUCCollateDiacritInsensitiveMask = $00000010;				{  Other general options  }
	kUCCollatePunctuationSignificantMask = $00008000;			{  Number-handling options  }
	kUCCollateDigitsOverrideMask = $00010000;
	kUCCollateDigitsAsNumberMask = $00020000;

	kUCCollateStandardOptions	= $00000006;

	{
	   Special values to specify various invariant orders for UCCompareTextNoLocale.
	   These values use the high 8 bits of UCCollateOptions.
	}
	kUCCollateTypeHFSExtended	= 1;

	{  These constants are used for masking and shifting the invariant order type. }
	kUCCollateTypeSourceMask	= $000000FF;
	kUCCollateTypeShiftBits		= 24;

	kUCCollateTypeMask			= $FF000000;


TYPE
	UCCollationValue					= UInt32;
	{
	   -------------------------------------------------------------------------------------------------
	   CONSTANTS & DATA STRUCTURES for Unicode TextBreak
	   -------------------------------------------------------------------------------------------------
	}
	{  constant for LocaleOperationClass }

CONST
	kUnicodeTextBreakClass		= 'ubrk';


TYPE
	TextBreakLocatorRef    = ^LONGINT; { an opaque 32-bit type }
	TextBreakLocatorRefPtr = ^TextBreakLocatorRef;  { when a VAR xx:TextBreakLocatorRef parameter can be nil, it is changed to xx: TextBreakLocatorRefPtr }
	UCTextBreakType 			= UInt32;
CONST
	kUCTextBreakCharMask		= $00000001;
	kUCTextBreakClusterMask		= $00000004;
	kUCTextBreakWordMask		= $00000010;
	kUCTextBreakLineMask		= $00000040;


TYPE
	UCTextBreakOptions 			= UInt32;
CONST
	kUCTextBreakLeadingEdgeMask	= $00000001;
	kUCTextBreakGoBackwardsMask	= $00000002;
	kUCTextBreakIterateMask		= $00000004;

	{
	   -------------------------------------------------------------------------------------------------
	   FUNCTION PROTOTYPES
	   -------------------------------------------------------------------------------------------------
	}

	{
	 *  UCKeyTranslate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in UnicodeUtilitiesCoreLib 8.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION UCKeyTranslate({CONST}VAR keyLayoutPtr: UCKeyboardLayout; virtualKeyCode: UInt16; keyAction: UInt16; modifierKeyState: UInt32; keyboardType: UInt32; keyTranslateOptions: OptionBits; VAR deadKeyState: UInt32; maxStringLength: UniCharCount; VAR actualStringLength: UniCharCount; VAR unicodeString: UniChar): OSStatus;

{  Standard collation functions }
{
 *  UCCreateCollator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCCreateCollator(locale: LocaleRef; opVariant: LocaleOperationVariant; options: UCCollateOptions; VAR collatorRef: CollatorRef): OSStatus; C;

{
 *  UCGetCollationKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCGetCollationKey(collatorRef: CollatorRef; {CONST}VAR textPtr: UniChar; textLength: UniCharCount; maxKeySize: ItemCount; VAR actualKeySize: ItemCount; VAR collationKey: UCCollationValue): OSStatus; C;

{
 *  UCCompareCollationKeys()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesCoreLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCCompareCollationKeys({CONST}VAR key1Ptr: UCCollationValue; key1Length: ItemCount; {CONST}VAR key2Ptr: UCCollationValue; key2Length: ItemCount; VAR equivalent: BOOLEAN; VAR order: SInt32): OSStatus; C;

{
 *  UCCompareText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCCompareText(collatorRef: CollatorRef; {CONST}VAR text1Ptr: UniChar; text1Length: UniCharCount; {CONST}VAR text2Ptr: UniChar; text2Length: UniCharCount; VAR equivalent: BOOLEAN; VAR order: SInt32): OSStatus; C;

{
 *  UCDisposeCollator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCDisposeCollator(VAR collatorRef: CollatorRef): OSStatus; C;

{  Simple collation using default locale }

{
 *  UCCompareTextDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCCompareTextDefault(options: UCCollateOptions; {CONST}VAR text1Ptr: UniChar; text1Length: UniCharCount; {CONST}VAR text2Ptr: UniChar; text2Length: UniCharCount; VAR equivalent: BOOLEAN; VAR order: SInt32): OSStatus; C;


{  Simple locale-independent collation }

{
 *  UCCompareTextNoLocale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesCoreLib 8.6 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCCompareTextNoLocale(options: UCCollateOptions; {CONST}VAR text1Ptr: UniChar; text1Length: UniCharCount; {CONST}VAR text2Ptr: UniChar; text2Length: UniCharCount; VAR equivalent: BOOLEAN; VAR order: SInt32): OSStatus; C;

{  Standard text break (text boundary) functions }
{
 *  UCCreateTextBreakLocator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCCreateTextBreakLocator(locale: LocaleRef; opVariant: LocaleOperationVariant; breakTypes: UCTextBreakType; VAR breakRef: TextBreakLocatorRef): OSStatus; C;

{
 *  UCFindTextBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCFindTextBreak(breakRef: TextBreakLocatorRef; breakType: UCTextBreakType; options: UCTextBreakOptions; {CONST}VAR textPtr: UniChar; textLength: UniCharCount; startOffset: UniCharArrayOffset; VAR breakOffset: UniCharArrayOffset): OSStatus; C;

{
 *  UCDisposeTextBreakLocator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in UnicodeUtilitiesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UCDisposeTextBreakLocator(VAR breakRef: TextBreakLocatorRef): OSStatus; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := UnicodeUtilitiesIncludes}

{$ENDC} {__UNICODEUTILITIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
