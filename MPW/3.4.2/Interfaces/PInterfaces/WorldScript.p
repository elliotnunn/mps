{
 	File:		WorldScript.p
 
 	Contains:	WorldScript I Interfaces.
 
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
 UNIT WorldScript;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __WORLDSCRIPT__}
{$SETC __WORLDSCRIPT__ := 1}

{$I+}
{$SETC WorldScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __TRAPS__}
{$I Traps.p}
{$ENDC}

{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$I QuickdrawText.p}
{$ENDC}
{	MixedMode.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	WSIOffset = UInt16;

	WSIByteCount = UInt8;

	WSIByteIndex = UInt8;

{ offset from start of sub-table to row in state table }
	WSIStateOffset = UInt16;

	WSITableOffset = UInt32;

	WSISubtableOffset = UInt16;

	WSIGlyphcode = UInt16;

	WSITableIdentifiers = UInt32;


CONST
	kScriptSettingsTag			= 'info';
	kMetamorphosisTag			= 'mort';
	kGlyphExpansionTag			= 'g2g#';
	kPropertiesTag				= 'prop';
	kJustificationTag			= 'kash';
	kCharToGlyphTag				= 'cmap';
	kGlyphToCharTag				= 'pamc';
	kFindScriptRunTag			= 'fstb';

{*** 			L O O K U P    T A B L E    T Y P E S		***}
	WSILookupSimpleArray		= 0;							{ a simple array indexed by glyph code }
	WSILookupSegmentSingle		= 2;							{ segment mapping to single value }
	WSILookupSegmentArray		= 4;							{ segment mapping to lookup array }
	WSILookupSingleTable		= 6;							{ sorted list of glyph, value pairs }
	WSILookupTrimmedArray		= 8;							{ a simple trimmed array indexed by glyph code }

	
TYPE
	WSILookupTableFormat = INTEGER;

	WSILookupValue = INTEGER;

{ An offset from the beginning of the lookup table }
	WSILookupOffset = INTEGER;

{	FORMAT SPECIFIC DEFINITIONS }
{
		lookupSimpleArray:
		
		This is a simple array which maps all glyphs in the font
		to lookup values.
	}
	WSILookupArrayHeader = RECORD
		lookupValues:			ARRAY [0..0] OF WSILookupValue;			{ The array of values indexed by glyph code }
	END;

{
		lookupTrimmedArray:
		
		This is a single trimmed array which maps a single range
		of glyhs in the font to lookup values.
	}
	WSILookupTrimmedArrayHeader = RECORD
		firstGlyph:				WSIGlyphcode;
		limitGlyph:				WSIGlyphcode;
		valueArray:				ARRAY [0..0] OF WSILookupValue;
	END;

{ The format specific part of the subtable header }
	WSILookupFormatSpecificHeader = RECORD
		CASE INTEGER OF
		0: (
			lookupArray:				WSILookupArrayHeader;
		   );
		1: (
			trimmedArray:				WSILookupTrimmedArrayHeader;
		   );
	END;

{ The overall subtable header }
	WSILookupTableHeader = RECORD
		format:					WSILookupTableFormat;					{ table format }
		fsHeader:				WSILookupFormatSpecificHeader;			{ format specific header }
	END;

{***		G L Y P H    E X P A N S I O N    ***}

CONST
{ fixed 1.0 }
	kCurrentGlyphExpansionVersion = $00010000;

	
TYPE
	GlyphExpansionFormats = INTEGER;


CONST
	GlyphExpansionLookupFormat	= 1;
	GlyphExpansionContextualFormat = 2;


TYPE
	ExpandedGlyphCluster = PACKED RECORD
		numGlyphs:				WSIByteCount;
		bestGlyph:				WSIByteIndex;
		glyphs:					ARRAY [0..0] OF WSIGlyphcode;
	END;

	ExpandedGlyphOffset = RECORD
		glyph:					WSIGlyphcode;
		offset:					WSIOffset;								{ offset to ExpandedGlyphCluster }
	END;

	GlyphExpansionStateTable = RECORD
		stateTableOffset:		WSISubtableOffset;
		classTableOffset:		WSISubtableOffset;
		actionTableOffset:		WSISubtableOffset;						{ state, class and actions tables follow here... }
	END;

	GlyphExpansionTable = RECORD
		version:				Fixed;
		format:					INTEGER;
		expansionNumer:			INTEGER;
		expansionDenom:			INTEGER;								{ num/denom ratio for expansion <2> }
		CASE INTEGER OF
		0: (
			stateTable:					GlyphExpansionStateTable;
		   );
		1: (
			lookup:						WSILookupTableHeader;				{ expanded glyph clusters follow here... }
		   );
	END;

{ Glyph-to-Character constants and types  }

CONST
	kCurrentGlyphToCharVersion	= $00010100;

	
TYPE
	GlyphToCharLookupFormats = INTEGER;


CONST
	kGlyphToCharLookup8Format	= 1;
	kGlyphToCharLookup16Format	= 2;
	kGlyphToCharLookup32Format	= 3;

	
TYPE
	GlyphToCharFontIndex = UInt8;

	QDGlyphcode = UInt8;

	GlyphToCharActionTable = RECORD
		fontNameOffset:			WSISubtableOffset;						{ offset relative to this table }
		actions:				WSILookupTableHeader;					{ only support lookupSimpleArray format for now }
	END;

	GlyphToCharActionHeader = RECORD
		numTables:				INTEGER;								{ 0..n }
		offsets:				ARRAY [0..0] OF WSISubtableOffset;		{ offsets from start of action table header }
	END;

	GlyphToCharHeader = RECORD
		version:				Fixed;
		actionOffset:			WSISubtableOffset;						{ offset to GlyphToCharActionHeader }
		format:					INTEGER;								{ size of font mask }
		mappingTable:			WSILookupTableHeader;
	END;

{ JUSTIFICATION TYPES
	WorldScript supports justification of text using insertion. The justification
	table specifies a insertion string to insert between 2 specified glyphs.
	Each combination of inter-glyph boundary can be assigned a justification priority,
	the higher the priority the more justification strings inserted at that position.
	
	The priorities for each inter-glyph boundary are specified by the justification table's
	state table.
	
	Special handling is done for scripts which use spaces to justify, because the width of 
	a space varies depending on the setting of SpaceExtra. This is why the number of spaces
	per inserting string is specified in the justification table.

}

CONST
{ 1.0 not supported }
	kCurrentJustificationVersion = $0200;

	kJustificationStateTableFormat = 1;

{ WSI's internal limitation <12> }
	kMaxJustificationStringLength = 13;

	
TYPE
	WSIJustificationPriority = UInt8;


CONST
	WSIJustificationSetMarkMask	= $80;


TYPE
	WSIJustificationStateEntry = PACKED RECORD
		markPriority:			WSIJustificationPriority;				{ non-zero priorities means insertion }
		priority:				WSIJustificationPriority;
		newState:				WSIStateOffset;
	END;

	WSIJustificationClasses = INTEGER;


CONST
	wsiJustEndOfLineClass		= 0;
	wsiJustEndOfRunClass		= 1;
	wsiJustDeletedGlyphClass	= 2;
	wsiJustUserDefinedClass		= 3;

	
TYPE
	WSIJustificationStates = INTEGER;


CONST
	wsiStartOfLineState			= 0;							{ pre-defined states }
	wsiStartOfRunState			= 1;
	wsiUserDefinedState			= 2;

{ pre-multiplied: class# * sizeof(WSIJustificationStateEntry) }
	
TYPE
	WSIJustificationClassOffset = UInt8;

	WSIJustificationStateTable = RECORD
		maxPriorities:			INTEGER;
		rowWidth:				INTEGER;								{ width of a state table row in bytes }
		classTableOffset:		INTEGER;
		stateTableOffset:		INTEGER;
	END;

	WSIJustificationHeader = RECORD
		version:				INTEGER;
		format:					INTEGER;
		scaling:				Point;									{ numer/denom scaling of priority weights <7> }
		spacesPerInsertion:		INTEGER;								{ # of $20 chars in justification insertion string <12> }
		justStringOffset:		INTEGER;								{ offset to justification string }
		stateTable:				WSIJustificationStateTable;				{ long-aligned boundary aligned w/ spacesPerInsertion field - justification string follows }
	END;

{ Line Layout's Property table version <11> }

CONST
{ v1.0 }
	currentPropsTableVersion	= $00010000;

{ ??? is this right }
	kCharToGlyphCurrentVersion	= 0100;

{ pass as priorityWeight to JustifyWSILayout to use script's current just setting }
	kScriptsDefaultJustWeight	= -1;


TYPE
	WSIGlyphInfoRec = RECORD
		qdChar:					SInt8; (* UInt8 *)
		rightToLeft:			SInt8;									{ !0 means rightToLeft, 0 means leftToRight }
		fontID:					INTEGER;
		originalOffset:			INTEGER;								{ or negative original offset if not in original text input }
		unused:					INTEGER;								{ long-align }
	END;

	WSIGlyphInfoRecPtr = ^WSIGlyphInfoRec;
	WSIGlyphInfoHandle = ^WSIGlyphInfoRecPtr;

	WSILayoutHandle = Handle;


FUNCTION NewWSILayout(layoutH: WSILayoutHandle; text: Ptr; txLength: INTEGER; lineDirection: INTEGER; flags: LONGINT; VAR err: OSErr): WSILayoutHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8414, $0040, $A8B5;
	{$ENDC}
FUNCTION JustifyWSILayout(layoutH: WSILayoutHandle; slop: Fixed; priorityWeight: INTEGER; styleRunPosition: JustStyleCode; numer: Point; denom: Point; VAR err: OSErr): WSILayoutHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8418, $0042, $A8B5;
	{$ENDC}
FUNCTION MeasureWSILayout(layoutH: WSILayoutHandle; numer: Point; denom: Point): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $840C, $0044, $A8B5;
	{$ENDC}
PROCEDURE DrawWSILayout(layoutH: WSILayoutHandle; numer: Point; denom: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $800C, $0046, $A8B5;
	{$ENDC}
{ "low-level" routines }
FUNCTION GetWSILayoutParts(layoutH: WSILayoutHandle; destH: WSIGlyphInfoHandle; VAR numGlyphs: INTEGER; VAR err: OSErr): WSIGlyphInfoHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8410, $0048, $A8B5;
	{$ENDC}
PROCEDURE DrawWSIGlyphs(length: INTEGER; qdCodes: Ptr; numer: Point; denom: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $800E, $004A, $A8B5;
	{$ENDC}
FUNCTION xMeasureWSIGlyphs(VAR qdCodes: Ptr; length: INTEGER; numer: Point; denom: Point): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $840E, $004C, $A8B5;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := WorldScriptIncludes}

{$ENDC} {__WORLDSCRIPT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
