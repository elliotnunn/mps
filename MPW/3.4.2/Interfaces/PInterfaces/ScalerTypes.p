{
 	File:		ScalerTypes.p
 
 	Contains:	Apple public font scaler object and constant definitions
 
 	Version:	Technology:	Quickdraw GX 1.1
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
 UNIT ScalerTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCALERTYPES__}
{$SETC __SCALERTYPES__ := 1}

{$I+}
{$SETC ScalerTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$IFC UNDEFINED __GXMATH__}
{$I GXMath.p}
{$ENDC}
{	FixMath.p													}

{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}
{	GXTypes.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{$SETC scalerTypeIncludes := 1}

CONST
	truetypeFontFormatTag		= 'true';
	type1FontFormatTag			= 'typ1';
	nfntFontFormatTag			= 'nfnt';

	scaler_first_error			= 1;
	scaler_first_warning		= 1024;

	kOFAVersion1Dot0			= $10000;
	kOFAVersion1Dot1			= $10100;						{ added scalerVariationInfo }

	scaler_no_problem			= 0;							{ Everything went OK }
	scaler_null_context			= scaler_first_error;			{ Client passed a null context pointer }
	scaler_null_input			= scaler_first_error + 1;		{ Client passed a null input pointer }
	scaler_invalid_context		= scaler_first_error + 2;		{ There was a problem with the context }
	scaler_invalid_input		= scaler_first_error + 3;		{ There was a problem with an input }
	scaler_invalid_font_data	= scaler_first_error + 4;		{ A portion of the font was corrupt }
	scaler_new_block_failed		= scaler_first_error + 5;		{ A call to NewBlock() failed }
	scaler_get_font_table_failed = scaler_first_error + 6;		{ The table was present (length > 0) but couldn't be read }
	scaler_bitmap_alloc_failed	= scaler_first_error + 7;		{ Call to allocate bitmap permanent block failed }
	scaler_outline_alloc_failed	= scaler_first_error + 8;		{ Call to allocate outline permanent block failed }
	scaler_required_table_missing = scaler_first_error + 9;		{ A needed font table was not found }
	scaler_unsupported_outline_format = scaler_first_error + 10; { Couldn't create an outline of the desired format }
	scaler_unsupported_stream_format = scaler_first_error + 11;	{ ScalerStreamFont() call can't supply any requested format }
	scaler_unsupported_font_format = scaler_first_error + 12;	{ No scaler supports the font format }
	scaler_hinting_error		= scaler_first_error + 13;		{ An error occurred during hinting }
	scaler_scan_error			= scaler_first_error + 14;		{ An error occurred in scan conversion }
	scaler_internal_error		= scaler_first_error + 15;		{ Scaler has a bug }
	scaler_invalid_matrix		= scaler_first_error + 16;		{ The transform matrix was unusable }
	scaler_fixed_overflow		= scaler_first_error + 17;		{ An overflow ocurred during matrix operations }
	scaler_API_version_mismatch	= scaler_first_error + 18;		{ Scaler requires a newer/older version of the scaler API }
	scaler_streaming_aborted	= scaler_first_error + 19;		{ StreamFunction callback indicated that streaming should cease }
	scaler_last_error			= scaler_streaming_aborted;
	scaler_no_output			= scaler_first_warning;			{ Couldn't fulfill any glyph request. }
	scaler_fake_metrics			= scaler_first_warning;			{ Returned metrics aren't based on information in the font }
	scaler_fake_linespacing		= scaler_first_warning;			{ Linespacing metrics not based on information in the font }
	scaler_glyph_substitution	= scaler_first_warning;			{ Requested glyph out of range, a substitute was used }
	scaler_last_warning			= scaler_glyph_substitution;

	
TYPE
	scalerError = LONGINT;

{ ScalerOpen output type }
	scalerInfo = RECORD
		format:					gxFontFormatTag;						{ Font format supported by this scaler }
		scalerVersion:			Fixed;									{ Version number of the scaler }
		APIVersion:				Fixed;									{ Version of API implemented (compare with version in scalerContext) }
	END;

{ ScalerNewFont output type }

CONST
	requiresLayoutFont			= 1;
	hasNormalLayoutFont			= 2;
	canReorderFont				= 4;
	canRearrangeFont			= 8;
	hasOutlinesFont				= 16;

	
TYPE
	scalerFontFlag = LONGINT;

	scalerFontInfo = RECORD
		unitsPerEm:				LONGINT;
		flags:					scalerFontFlag;
		numGlyphs:				LONGINT;
	END;

{ ScalerNewTransform input types }
{ ScalerNewVariation1Dot1 output type }
	scalerFixedRectangle = RECORD
		left:					Fixed;
		top:					Fixed;
		right:					Fixed;
		bottom:					Fixed;
	END;

	scalerVariationInfo = RECORD
		bounds:					scalerFixedRectangle;
	END;

{ ScalerNewTransform input types }

CONST
	applyHintsTransform			= 1;							{ Execute hinting instructions (grid fit) }
	exactBitmapTransform		= 2;							{ Use embedded gxBitmap iff exact size }
	useThresholdTransform		= 4;							{ Use scaled gxBitmap (if any) if below outline threshold }
	verticalTransform			= 8;							{ Glyphs will be in vertical orientation }
	deviceMetricsTransform		= 16;							{ All metrics should be device (vs. fractional) }
	allScalerTransformFlags		= applyHintsTransform + exactBitmapTransform + useThresholdTransform + verticalTransform + deviceMetricsTransform;

	
TYPE
	scalerTransformFlag = LONGINT;

	scalerTransform = RECORD
		flags:					scalerTransformFlag;					{ Hint, embedded gxBitmap control, etc. }
		pointSize:				Fixed;									{ The desired pointsize }
		fontMatrix:				^gxMapping;								{ The 3x3 matrix to apply to glyphs }
		resolution:				gxPoint;								{ 2D device resolution }
		spotSize:				gxPoint;								{ 2D pixel size }
	END;

{ ScalerNewTransform output type }
	scalerTransformInfo = RECORD
		before:					gxPoint;								{ Spacing of the line before }
		after:					gxPoint;								{ Spacing of the line after }
		caretAngle:				gxPoint;								{ Rise (y) and run (x) of the insertion caret }
		caretOffset:			gxPoint;								{ Adjustment to caret for variants like italic }
	END;

{ ScalerNewGlyph input types }

CONST
	noImageGlyph				= 1;							{ Don't return the bitmap image for this glyph }

	
TYPE
	scalerGlyphFlag = LONGINT;

{ QuickDraw GX outline }

CONST
	pathOutlineFormat			= 'path';

	
TYPE
	scalerOutlineFormat = LONGINT;

	scalerGlyph = RECORD
		glyphIndex:				LONGINT;								{ Index of the glyph to be considered }
		bandingTop:				LONGINT;								{ Banding controls (scanline numbers) top=bottom=0 means no banding }
		bandingBottom:			LONGINT;
		format:					scalerOutlineFormat;					{ Format of outline to return, ignored if no outline desired }
		flags:					scalerGlyphFlag;						{ Control generation of image representation }
	END;

{ ScalerNewGlyph output types }
	scalerMetrics = RECORD
		advance:				gxPoint;
		sideBearing:			gxPoint;
		otherSideBearing:		gxPoint;
	END;

	scalerRectangle = RECORD
		xMin:					LONGINT;
		yMin:					LONGINT;
		xMax:					LONGINT;
		yMax:					LONGINT;
	END;

{ ScalerKernGlyphs input/output types }

CONST
	lineStartKerning			= 1;							{ Array of glyphs starts a line }
	lineEndKerning				= 2;							{ Array of glyphs ends a line }
	noCrossKerning				= 4;							{ Prohibit cross kerning }
	allScalerKerningFlags		= lineStartKerning + lineEndKerning + noCrossKerning;

	
TYPE
	scalerKerningFlag = LONGINT;


CONST
	noStakeKerningNote			= 1;							{ Indicates a glyph was involver in a kerning pair/group }
	crossStreamResetKerningNote	= 2;							{ Indicates a return-to-baseline in cross-stream kerning }

	
TYPE
	scalerKerningNote = INTEGER;


CONST
	noKerningAppliedOutput		= $0001;						{ All kerning values were zero, kerning call had no effect }

{ These are bit-fields }
	
TYPE
	scalerKerningOutput = LONGINT;

	scalerKerning = RECORD
		numGlyphs:				LONGINT;								{ Number of glyphs in the glyphs array }
		scaleFactor:			Fract;									{ Amount of kerning to apply (0 == none, fract1 == all) }
		flags:					scalerKerningFlag;						{ Various control flags }
		glyphs:					^INTEGER;								{ Pointer to the array of glyphs to be kerned }
		info:					scalerKerningOutput;					{ Qualitative results of kerning }
	END;

{ ScalerStream input/output types }

CONST
	cexec68K					= $0001;
	truetypeStreamType			= $0001;
	type1StreamType				= $0002;
	type3StreamType				= $0004;
	type42StreamType			= $0008;
	type42GXStreamType			= $0010;
	portableStreamType			= $0020;
	flattenedStreamType			= $0040;
	evenOddModifierStreamType	= $8000;

{ Possible streamed font formats }
	
TYPE
	scalerStreamTypeFlag = LONGINT;


CONST
	downloadStreamAction		= 0;							{ Transmit the (possibly sparse) font data }
	asciiDownloadStreamAction	= 1;							{ Transmit font data to a 7-bit ASCII destination }
	fontSizeQueryStreamAction	= 2;							{ Estimate in-printer memory used if the font were downloaded }
	encodingOnlyStreamAction	= 3;							{ Transmit only the encoding for the font }
	prerequisiteQueryStreamAction = 4;							{ Return a list of prerequisite items needed for the font }
	prerequisiteItemStreamAction = 5;							{ Transmit a specified prerequisite item }
	variationQueryStreamAction	= 6;							{ Return information regarding support for variation streaming }
	variationPSOperatorStreamAction = 7;						{ Transmit Postscript code necessary to effect variation of a font }

	
TYPE
	scalerStreamAction = LONGINT;


CONST
	selectAllVariations			= -1;							{ Special variationCount value meaning include all variation data }


TYPE
	scalerPrerequisiteItem = RECORD
		enumeration:			LONGINT;								{ Shorthand tag identifying the item }
		size:					LONGINT;								{ Worst case vm in printer item requires }
		name:					ARRAY [0..0] OF SInt8; (* unsigned char *) { Name to be used by the client when emitting the item (Pascal string) }
	END;

	scalerStream = RECORD
		streamRefCon:			Ptr;									{ <-	private reference for client }
		targetVersion:			^CHAR;									{ <-	e.g. Postscript printer name (C string) }
		types:					scalerStreamTypeFlag;					{ <->	Data stream formats desired/supplied }
		action:					scalerStreamAction;						{ <- 	What action to take }
		memorySize:				LONGINT;								{ ->	Worst case memory use (vm) in printer or as sfnt }
		variationCount:			LONGINT;								{ <-	The number of variations, or selectAllVariations }
		variations:				^gxFontVariation;						{ <-	A pointer to an array of the variations }
		CASE INTEGER OF
		0: (
			encoding:					^INTEGER;							{ <-	Intention is * unsigned short[256] }
			glyphBits:					^LONGINT;							{ <->	Bitvector: a bit for each glyph, 1 = desired/supplied }
			name:						^CHAR;								{ <->	The printer font name to use/used (C string) }
		   );
		1: (
			size:						LONGINT;							{ -> 	Size of the prereq. list in bytes (0 indicates no prerequisites)}
			list:						Ptr;								{ <-	Pointer to client block to hold list (nil = list size query only) }
		   );
		2: (
			prerequisiteItem:			LONGINT;							{ <- 	Enumeration value for the prerequisite item to be streamed.}
		   );
		3: (
			variationQueryResult:		LONGINT;							{ ->	Output from the variationQueryStreamAction }
		   );

	END;

	scalerStreamData = RECORD
		hexFlag:				LONGINT;								{ Indicates that the data is to be interpreted as hex, versus binary }
		byteCount:				LONGINT;								{ Number of bytes in the data being streamed }
		data:					Ptr;									{ Pointer to the data being streamed }
	END;


CONST
	scalerScratchBlock			= -1;							{ Scaler alloced/freed temporary memory }
	scalerOpenBlock				= 0;							{ Five permanent input/state block types }
	scalerFontBlock				= 1;
	scalerVariationBlock		= 2;
	scalerTransformBlock		= 3;
	scalerGlyphBlock			= 4;
	scalerBlockCount			= 5;							{ Number of permanent block types }
	scalerOutlineBlock			= scalerBlockCount;				{ Two output block types }
	scalerBitmapBlock			= scalerBlockCount + 1;

	
TYPE
	scalerBlockType = LONGINT;

{ special tag used only by scalers to access an sfnt's directory }

CONST
	sfntDirectoryTag			= 'dir ';

{ Type definitions for function pointers used with the scalerContext structure }
TYPE
	GetFontTableProcPtr = ProcPtr;  { FUNCTION GetFontTable(VAR context: scalerContext; tableTag: gxFontTableTag; offset: LONGINT; length: LONGINT; data: UNIV Ptr): LONGINT; }
	ReleaseFontTableProcPtr = ProcPtr;  { PROCEDURE ReleaseFontTable(VAR context: scalerContext; fontData: UNIV Ptr); }
	NewBlockProcPtr = ProcPtr;  { FUNCTION NewBlock(VAR context: scalerContext; size: LONGINT; theType: scalerBlockType; oldBlock: UNIV Ptr): Ptr; }
	DisposeBlockProcPtr = ProcPtr;  { PROCEDURE DisposeBlock(VAR context: scalerContext; scratchData: UNIV Ptr; theType: scalerBlockType); }
	StreamFunctionProcPtr = ProcPtr;  { FUNCTION StreamFunction(VAR context: scalerContext; VAR streamInfo: scalerStream; (CONST)VAR dataInfo: scalerStreamData): LONGINT; }
	ScanLineFunctionProcPtr = ProcPtr;  { PROCEDURE ScanLineFunction(VAR context: scalerContext; (CONST)VAR scanLine: scalerBitmap); }
	PostErrorFunctionProcPtr = ProcPtr;  { PROCEDURE PostErrorFunction(VAR context: scalerContext; theProblem: scalerError); }
	ScalerFunctionProcPtr = ProcPtr;  { PROCEDURE ScalerFunction(VAR context: scalerContext; data: UNIV Ptr); }
	GetFontTableUPP = UniversalProcPtr;
	ReleaseFontTableUPP = UniversalProcPtr;
	NewBlockUPP = UniversalProcPtr;
	DisposeBlockUPP = UniversalProcPtr;
	StreamFunctionUPP = UniversalProcPtr;
	ScanLineFunctionUPP = UniversalProcPtr;
	PostErrorFunctionUPP = UniversalProcPtr;
	ScalerFunctionUPP = UniversalProcPtr;

	scalerBitmap = RECORD
		image:					^CHAR;									{ Pointer to pixels }
		topLeft:				gxPoint;								{ Bitmap positioning relative to client's origin }
		bounds:					scalerRectangle;						{ Bounding box of bitmap }
		rowBytes:				LONGINT;								{ Width in bytes }
	END;

{ scalerContext: the vehicle with which the caller and scaler communicate }
	scalerContext = RECORD
		version:				Fixed;									{ Version of the scaler API implemented by the caller }
		theFont:				Ptr;									{ Caller's private reference to the font being processed }
		format:					gxFontFormatTag;						{ Format of the sfnt font data, corresponds to the scaler }
		GetFontTable:			GetFontTableUPP;						{ Callback for accessing sfnt tables or portions thereof }
		ReleaseFontTable:		ReleaseFontTableUPP;					{ Callback for releasing sfnt tables }
		NewBlock:				NewBlockUPP;							{ Callback for allocating and/or growing permanent and scratch blocks }
		DisposeBlock:			DisposeBlockUPP;						{ Callback for freeing permanent and scratch blocks }
		StreamFunction:			StreamFunctionUPP;						{ Callback for transmitting blocks of data during streaming }
		ScanLineFunction:		ScanLineFunctionUPP;					{ Callback for emitting individual bitmap scanlines during scan conversion }
		PostErrorFunction:		PostErrorFunctionUPP;					{ Callback for posting errors and warnings }
		scalerBlocks:			ARRAY [0..scalerBlockCount-1] OF Ptr;	{ Array of permanent scaler blocks }
		ScalerFunction:			ScalerFunctionUPP;						{ Callback for scaler-specific tracing, debugging, etc. }
	END;


CONST
	uppGetFontTableProcInfo = $0000FFF1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 4 byte result; }
	uppReleaseFontTableProcInfo = $000003C1; { PROCEDURE (4 byte param, 4 byte param); }
	uppNewBlockProcInfo = $00003FF1; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 4 byte result; }
	uppDisposeBlockProcInfo = $00000FC1; { PROCEDURE (4 byte param, 4 byte param, 4 byte param); }
	uppStreamFunctionProcInfo = $00000FF1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 4 byte result; }
	uppScanLineFunctionProcInfo = $000003C1; { PROCEDURE (4 byte param, 4 byte param); }
	uppPostErrorFunctionProcInfo = $000003C1; { PROCEDURE (4 byte param, 4 byte param); }
	uppScalerFunctionProcInfo = $000003C1; { PROCEDURE (4 byte param, 4 byte param); }

FUNCTION NewGetFontTableProc(userRoutine: GetFontTableProcPtr): GetFontTableUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewReleaseFontTableProc(userRoutine: ReleaseFontTableProcPtr): ReleaseFontTableUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNewBlockProc(userRoutine: NewBlockProcPtr): NewBlockUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDisposeBlockProc(userRoutine: DisposeBlockProcPtr): DisposeBlockUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewStreamFunctionProc(userRoutine: StreamFunctionProcPtr): StreamFunctionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewScanLineFunctionProc(userRoutine: ScanLineFunctionProcPtr): ScanLineFunctionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPostErrorFunctionProc(userRoutine: PostErrorFunctionProcPtr): PostErrorFunctionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewScalerFunctionProc(userRoutine: ScalerFunctionProcPtr): ScalerFunctionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGetFontTableProc(VAR context: scalerContext; tableTag: gxFontTableTag; offset: LONGINT; length: LONGINT; data: UNIV Ptr; userRoutine: GetFontTableUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallReleaseFontTableProc(VAR context: scalerContext; fontData: UNIV Ptr; userRoutine: ReleaseFontTableUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallNewBlockProc(VAR context: scalerContext; size: LONGINT; theType: scalerBlockType; oldBlock: UNIV Ptr; userRoutine: NewBlockUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDisposeBlockProc(VAR context: scalerContext; scratchData: UNIV Ptr; theType: scalerBlockType; userRoutine: DisposeBlockUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallStreamFunctionProc(VAR context: scalerContext; VAR streamInfo: scalerStream; {CONST}VAR dataInfo: scalerStreamData; userRoutine: StreamFunctionUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallScanLineFunctionProc(VAR context: scalerContext; {CONST}VAR scanLine: scalerBitmap; userRoutine: ScanLineFunctionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallPostErrorFunctionProc(VAR context: scalerContext; theProblem: scalerError; userRoutine: PostErrorFunctionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallScalerFunctionProc(VAR context: scalerContext; data: UNIV Ptr; userRoutine: ScalerFunctionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScalerTypesIncludes}

{$ENDC} {__SCALERTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
