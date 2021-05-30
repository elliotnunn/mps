{
 	File:		Dictionary.p
 
 	Contains:	Dictionary Manager Interfaces
 
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
 UNIT Dictionary;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DICTIONARY__}
{$SETC __DICTIONARY__ := 1}

{$I+}
{$SETC DictionaryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	MixedMode.p													}
{	OSUtils.p													}
{		Memory.p												}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Dictionary data insertion modes }
	kInsert						= 0;							{ Only insert the input entry if there is nothing in the dictionary that matches the key. }
	kReplace					= 1;							{ Only replace the entries which match the key with the input entry. }
	kInsertOrReplace			= 2;							{ Insert the entry if there is nothing in the dictionary which matches the key. 
						   If there is already matched entries, replace the existing matched entries with the input entry. }

{ This Was InsertMode }
	
TYPE
	DictionaryDataInsertMode = INTEGER;


CONST
{ Key attribute constants }
	kIsCaseSensitive			= $10;							{ case sensitive = 16		}
	kIsNotDiacriticalSensitive	= $20;							{ diac not sensitive = 32	}

{ Registered attribute type constants.	}
	kNoun						= -1;
	kVerb						= -2;
	kAdjective					= -3;
	kAdverb						= -4;

{ This Was AttributeType }
	
TYPE
	DictionaryEntryAttribute = SInt8;

{ Dictionary information record }
	DictionaryInformation = RECORD
		dictionaryFSSpec:		FSSpec;
		numberOfRecords:		SInt32;
		currentGarbageSize:		SInt32;
		script:					ScriptCode;
		maximumKeyLength:		SInt16;
		keyAttributes:			SInt8;
	END;

	DictionaryAttributeTable = PACKED RECORD
		datSize:				UInt8;
		datTable:				PACKED ARRAY [0..0] OF DictionaryEntryAttribute;
	END;

	DictionaryAttributeTablePtr = ^DictionaryAttributeTable;


FUNCTION InitializeDictionary({CONST}VAR theFsspecPtr: FSSpec; maximumKeyLength: SInt16; keyAttributes: ByteParameter; script: ScriptCode): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0500, $AA53;
	{$ENDC}
FUNCTION OpenDictionary({CONST}VAR theFsspecPtr: FSSpec; accessPermission: ByteParameter; VAR dictionaryReference: SInt32): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0501, $AA53;
	{$ENDC}
FUNCTION CloseDictionary(dictionaryReference: SInt32): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0202, $AA53;
	{$ENDC}
FUNCTION InsertRecordToDictionary(dictionaryReference: SInt32; key: ConstStr255Param; recordDataHandle: Handle; whichMode: DictionaryDataInsertMode): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0703, $AA53;
	{$ENDC}
FUNCTION DeleteRecordFromDictionary(dictionaryReference: SInt32; key: ConstStr255Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0404, $AA53;
	{$ENDC}
FUNCTION FindRecordInDictionary(dictionaryReference: SInt32; key: ConstStr255Param; requestedAttributeTablePointer: DictionaryAttributeTablePtr; recordDataHandle: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0805, $AA53;
	{$ENDC}
FUNCTION FindRecordByIndexInDictionary(dictionaryReference: SInt32; recordIndex: SInt32; requestedAttributeTablePointer: DictionaryAttributeTablePtr; VAR recordKey: Str255; recordDataHandle: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A06, $AA53;
	{$ENDC}
FUNCTION GetDictionaryInformation(dictionaryReference: SInt32; VAR theDictionaryInformation: DictionaryInformation): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0407, $AA53;
	{$ENDC}
FUNCTION CompactDictionary(dictionaryReference: SInt32): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0208, $AA53;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DictionaryIncludes}

{$ENDC} {__DICTIONARY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
