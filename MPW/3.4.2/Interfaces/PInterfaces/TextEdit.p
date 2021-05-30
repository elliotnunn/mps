{
 	File:		TextEdit.p
 
 	Contains:	TextEdit Interfaces.
 
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
 UNIT TextEdit;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTEDIT__}
{$SETC __TEXTEDIT__ := 1}

{$I+}
{$SETC TextEditIncludes := UsingIncludes}
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

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	TEPtr = ^TERec;
	TEHandle = ^TEPtr;

{ 
	Important note about TEClickLoopProcPtr and WordBreakProcPtr

	At one point these were defined as returning the function result in the 
	condition code Z-bit.  This was correct, in that it was what the 68K
	implementation of TextEdit actually tested.  But, MixedMode had a different 
	idea of what returning a boolean in the Z-bit meant.  MixedMode was setting
	the Z-bit the complement of what was wanted.  
	
	Therefore, these ProcPtrs have been changed (back) to return the result in
	register D0.  It turns out that for register based routines, 
	MixedMode sets the Z-bit of the 68K emulator based on the contents 
	of the return result register.  Thus we can get the Z-bit set correctly.  
	
	But, when TextEdit is recoded in PowerPC, if it calls a 68K ClickLoop
	or WordBreak routine, register D0 had better have the result (in addition
	to the Z-bit). Therefore all 68K apps should make sure their ClickLoop or
	WordBreak routines set register D0 at the end.
}
{
	The following ProcPtrs cannot be written in or called from a high-level 
	language without the help of mixed mode or assembly glue because they 
	use the following parameter-passing conventions:

	typedef pascal void (*HighHookProcPtr)(const Rect *r, TEPtr pTE);
	typedef pascal void (*CaretHookProcPtr)(const Rect *r, TEPtr pTE);

		In:
			=> 	r						on stack
			=>	pTE						A3.L
		Out:
			none

	typedef pascal Boolean (*EOLHookProcPtr)(char theChar, TEPtr pTE, TEHandle hTE);

		In:
			=> 	theChar					D0.B
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	Boolean					Z bit of the CCR

	typedef pascal unsigned short (*WidthHookProcPtr)(unsigned short textLen,
	 unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
	typedef pascal unsigned short (*TextWidthHookProcPtr)(unsigned short textLen,
	 unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);

		In:
			=> 	textLen					D0.W
			=>	textOffset				D1.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	unsigned short			D1.W

	typedef pascal unsigned short (*NWidthHookProcPtr)(unsigned short styleRunLen,
	 unsigned short styleRunOffset, short slop, short direction, void *textBufferPtr, 
	 short *lineStart, TEPtr pTE, TEHandle hTE);

		In:
			=> 	styleRunLen				D0.W
			=>	styleRunOffset			D1.W
			=>	slop					D2.W (low)
			=>	direction				D2.W (high)
			=>	textBufferPtr			A0.L
			=>	lineStart				A2.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	unsigned short			D1.W

	typedef pascal void (*DrawHookProcPtr)(unsigned short textOffset, unsigned short drawLen,
	 void *textBufferPtr, TEPtr pTE, TEHandle hTE);

		In:
			=> 	textOffset				D0.W
			=>	drawLen					D1.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			none

	typedef pascal Boolean (*HitTestHookProcPtr)(unsigned short styleRunLen,
	 unsigned short styleRunOffset, unsigned short slop, void *textBufferPtr,
	 TEPtr pTE, TEHandle hTE, unsigned short *pixelWidth, unsigned short *charOffset, 
	 Boolean *pixelInChar);

		In:
			=> 	styleRunLen				D0.W
			=>	styleRunOffset			D1.W
			=>	slop					D2.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	pixelWidth				D0.W (low)
			<=	Boolean					D0.W (high)
			<=	charOffset				D1.W
			<=	pixelInChar				D2.W

	typedef pascal void (*TEFindWordProcPtr)(unsigned short currentPos, short caller, 
	 TEPtr pTE, TEHandle hTE, unsigned short *wordStart, unsigned short *wordEnd);

		In:
			=> 	currentPos				D0.W
			=>	caller					D2.W
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	wordStart				D0.W
			<=	wordEnd					D1.W

	typedef pascal void (*TERecalcProcPtr)(TEPtr pTE, unsigned short changeLength,
  	 unsigned short *lineStart, unsigned short *firstChar, unsigned short *lastChar);

		In:
			=> 	pTE						A3.L
			=>	changeLength			D7.W
		Out:
			<=	lineStart				D2.W
			<=	firstChar				D3.W
			<=	lastChar				D4.W

	typedef pascal void (*TEDoTextProcPtr)(TEPtr pTE, unsigned short firstChar, unsigned short lastChar,
	 					short selector, GrafPtr *currentGrafPort, short *charPosition);

		In:
			=> 	pTE						A3.L
			=>	firstChar				D3.W
			=>	lastChar				D4.W
			=>	selector				D7.W
		Out:
			<=	currentGrafPort			A0.L
			<=	charPosition			D0.W
			
}
	HighHookProcPtr = ProcPtr;  { PROCEDURE HighHook((CONST)VAR r: Rect; pTE: TEPtr); }
	EOLHookProcPtr = ProcPtr;  { FUNCTION EOLHook(theChar: ByteParameter; pTE: TEPtr; hTE: TEHandle): BOOLEAN; }
	CaretHookProcPtr = ProcPtr;  { PROCEDURE CaretHook((CONST)VAR r: Rect; pTE: TEPtr); }
	WidthHookProcPtr = ProcPtr;  { FUNCTION WidthHook(textLen: INTEGER; textOffset: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle): INTEGER; }
	TextWidthHookProcPtr = ProcPtr;  { FUNCTION TextWidthHook(textLen: INTEGER; textOffset: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle): INTEGER; }
	NWidthHookProcPtr = ProcPtr;  { FUNCTION NWidthHook(styleRunLen: INTEGER; styleRunOffset: INTEGER; slop: INTEGER; direction: INTEGER; textBufferPtr: UNIV Ptr; VAR lineStart: INTEGER; pTE: TEPtr; hTE: TEHandle): INTEGER; }
	DrawHookProcPtr = ProcPtr;  { PROCEDURE DrawHook(textOffset: INTEGER; drawLen: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle); }
	HitTestHookProcPtr = ProcPtr;  { FUNCTION HitTestHook(styleRunLen: INTEGER; styleRunOffset: INTEGER; slop: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; VAR pixelWidth: INTEGER; VAR charOffset: INTEGER; VAR pixelInChar: BOOLEAN): BOOLEAN; }
	TEFindWordProcPtr = ProcPtr;  { PROCEDURE TEFindWord(currentPos: INTEGER; caller: INTEGER; pTE: TEPtr; hTE: TEHandle; VAR wordStart: INTEGER; VAR wordEnd: INTEGER); }
	TERecalcProcPtr = ProcPtr;  { PROCEDURE TERecalc(pTE: TEPtr; changeLength: INTEGER; VAR lineStart: INTEGER; VAR firstChar: INTEGER; VAR lastChar: INTEGER); }
	TEDoTextProcPtr = ProcPtr;  { PROCEDURE TEDoText(pTE: TEPtr; firstChar: INTEGER; lastChar: INTEGER; selector: INTEGER; VAR currentGrafPort: GrafPtr; VAR charPosition: INTEGER); }
	{
		TEClickLoopProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => pTE         	A3.L
		Out:
		 <= return value	D0.B
	}
	TEClickLoopProcPtr = Register68kProcPtr;  { register FUNCTION TEClickLoop(pTE: TEPtr): BOOLEAN; }
	{
		WordBreakProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => text        	A0.L
		 => charPos     	D0.W
		Out:
		 <= return value	D0.B
	}
	WordBreakProcPtr = Register68kProcPtr;  { register FUNCTION WordBreak(text: Ptr; charPos: INTEGER): BOOLEAN; }
	HighHookUPP = UniversalProcPtr;
	EOLHookUPP = UniversalProcPtr;
	CaretHookUPP = UniversalProcPtr;
	WidthHookUPP = UniversalProcPtr;
	TextWidthHookUPP = UniversalProcPtr;
	NWidthHookUPP = UniversalProcPtr;
	DrawHookUPP = UniversalProcPtr;
	HitTestHookUPP = UniversalProcPtr;
	TEFindWordUPP = UniversalProcPtr;
	TERecalcUPP = UniversalProcPtr;
	TEDoTextUPP = UniversalProcPtr;
	TEClickLoopUPP = UniversalProcPtr;
	WordBreakUPP = UniversalProcPtr;

	TERec = RECORD
		destRect:				Rect;
		viewRect:				Rect;
		selRect:				Rect;
		lineHeight:				INTEGER;
		fontAscent:				INTEGER;
		selPoint:				Point;
		selStart:				INTEGER;
		selEnd:					INTEGER;
		active:					INTEGER;
		wordBreak:				WordBreakUPP;
		clickLoop:				TEClickLoopUPP;
		clickTime:				LONGINT;
		clickLoc:				INTEGER;
		caretTime:				LONGINT;
		caretState:				INTEGER;
		just:					INTEGER;
		teLength:				INTEGER;
		hText:					Handle;
		hDispatchRec:			LONGINT;								{ added to replace recalBack & recalLines.  it's a handle anyway }
		clikStuff:				INTEGER;
		crOnly:					INTEGER;
		txFont:					INTEGER;
		txFace:					Style;									{txFace is unpacked byte}
		txMode:					INTEGER;
		txSize:					INTEGER;
		inPort:					GrafPtr;
		highHook:				HighHookUPP;
		caretHook:				CaretHookUPP;
		nLines:					INTEGER;
		lineStarts:				ARRAY [0..16000] OF INTEGER;
	END;


CONST
{ Justification (word alignment) styles }
	teJustLeft					= 0;
	teJustCenter				= 1;
	teJustRight					= -1;
	teForceLeft					= -2;
{ new names for the Justification (word alignment) styles }
	teFlushDefault				= 0;							{flush according to the line direction }
	teCenter					= 1;							{center justify (word alignment) }
	teFlushRight				= -1;							{flush right for all scripts }
	teFlushLeft					= -2;							{flush left for all scripts }
{ Set/Replace style modes }
	fontBit						= 0;							{set font}
	faceBit						= 1;							{set face}
	sizeBit						= 2;							{set size}
	clrBit						= 3;							{set color}
	addSizeBit					= 4;							{add size mode}
	toggleBit					= 5;							{set faces in toggle mode}
	toglBit						= 5;							{ obsolete.  use toggleBit }
{ TESetStyle/TEContinuousStyle modes }
	doFont						= 1;							{ set font (family) number}
	doFace						= 2;							{set character style}
	doSize						= 4;							{set type size}
	doColor						= 8;							{set color}
	doAll						= 15;							{set all attributes}
	addSize						= 16;							{adjust type size}

	doToggle					= 32;							{toggle mode for TESetStyle}
{ offsets into TEDispatchRec }
	EOLHook						= 0;							{[UniversalProcPtr] TEEOLHook}
	DRAWHook					= 4;							{[UniversalProcPtr] TEWidthHook}
	WIDTHHook					= 8;							{[UniversalProcPtr] TEDrawHook}
	HITTESTHook					= 12;							{[UniversalProcPtr] TEHitTestHook}
	nWIDTHHook					= 24;							{[UniversalProcPtr] nTEWidthHook}
	TextWidthHook				= 28;							{[UniversalProcPtr] TETextWidthHook}
{ selectors for TECustomHook }
	intEOLHook					= 0;							{TEIntHook value}
	intDrawHook					= 1;							{TEIntHook value}
	intWidthHook				= 2;							{TEIntHook value}
	intHitTestHook				= 3;							{TEIntHook value}
	intNWidthHook				= 6;							{TEIntHook value for new version of WidthHook}
	intTextWidthHook			= 7;							{TEIntHook value for new TextWidthHook}
	teFAutoScroll				= 0;							{00000001b}
	teFAutoScr					= 0;							{00000001b  obsolete. use teFAutoScroll}
	teFTextBuffering			= 1;							{00000010b}
	teFOutlineHilite			= 2;							{00000100b}
	teFInlineInput				= 3;							{00001000b }
	teFUseTextServices			= 4;							{00010000b }

{ action for the new "bit (un)set" interface, TEFeatureFlag }
	teBitClear					= 0;
	teBitSet					= 1;							{set the selector bit}
	teBitTest					= -1;							{no change; just return the current setting}
{constants for identifying the routine that called FindWord }
	teWordSelect				= 4;							{clickExpand to select word}
	teWordDrag					= 8;							{clickExpand to drag new word}
	teFromFind					= 12;							{FindLine called it ($0C)}
	teFromRecal					= 16;							{RecalLines called it ($10)      obsolete }
{constants for identifying TEDoText selectors }
	teFind						= 0;							{TEDoText called for searching}
	teHighlight					= 1;							{TEDoText called for highlighting}
	teDraw						= -1;							{TEDoText called for drawing text}
	teCaret						= -2;							{TEDoText called for drawing the caret}

	
TYPE
	Chars = PACKED ARRAY [0..32000] OF CHAR;

	CharsPtr = ^Chars;

	CharsHandle = ^CharsPtr;

	StyleRun = RECORD
		startChar:				INTEGER;								{starting character position}
		styleIndex:				INTEGER;								{index in style table}
	END;

	STElement = RECORD
		stCount:				INTEGER;								{number of runs in this style}
		stHeight:				INTEGER;								{line height}
		stAscent:				INTEGER;								{font ascent}
		stFont:					INTEGER;								{font (family) number}
		stFace:					Style;									{character Style}
		stSize:					INTEGER;								{size in points}
		stColor:				RGBColor;								{absolute (RGB) color}
	END;

	TEStyleTable = ARRAY [0..1776] OF STElement;

	STPtr = ^TEStyleTable;
	STHandle = ^STPtr;

	LHElement = RECORD
		lhHeight:				INTEGER;								{maximum height in line}
		lhAscent:				INTEGER;								{maximum ascent in line}
	END;

	LHTable = ARRAY [0..8000] OF LHElement;

	LHPtr = ^LHTable;
	LHHandle = ^LHPtr;

	ScrpSTElement = RECORD
		scrpStartChar:			LONGINT;								{starting character position}
		scrpHeight:				INTEGER;								{starting character position}
		scrpAscent:				INTEGER;
		scrpFont:				INTEGER;
		scrpFace:				Style;									{unpacked byte}
		scrpSize:				INTEGER;
		scrpColor:				RGBColor;
	END;

{ ARRAY [0..1600] OF ScrpSTElement }
	ScrpSTTable = ARRAY [0..1600] OF ScrpSTElement;

	StScrpRec = RECORD
		scrpNStyles:			INTEGER;								{number of styles in scrap}
		scrpStyleTab:			ScrpSTTable;							{table of styles for scrap}
	END;

	StScrpPtr = ^StScrpRec;
	StScrpHandle = ^StScrpPtr;

	NullStRec = RECORD
		teReserved:				LONGINT;								{reserved for future expansion}
		nullScrap:				StScrpHandle;							{handle to scrap style table}
	END;

	NullStPtr = ^NullStRec;
	NullStHandle = ^NullStPtr;

	TEStyleRec = RECORD
		nRuns:					INTEGER;								{number of style runs}
		nStyles:				INTEGER;								{size of style table}
		styleTab:				STHandle;								{handle to style table}
		lhTab:					LHHandle;								{handle to line-height table}
		teRefCon:				LONGINT;								{reserved for application use}
		nullStyle:				NullStHandle;							{Handle to style set at null selection}
		runs:					ARRAY [0..8000] OF StyleRun;			{ARRAY [0..8000] OF StyleRun}
	END;

	TEStylePtr = ^TEStyleRec;
	TEStyleHandle = ^TEStylePtr;

	TextStyle = RECORD
		tsFont:					INTEGER;								{font (family) number}
		tsFace:					Style;									{character Style}
		tsSize:					INTEGER;								{size in point}
		tsColor:				RGBColor;								{absolute (RGB) color}
	END;

	TextStylePtr = ^TextStyle;
	TextStyleHandle = ^TextStylePtr;

	TEIntHook = INTEGER;


CONST
	uppHighHookProcInfo = $0000000F; { SPECIAL_CASE_PROCINFO( kSpecialCaseHighHook ) }
	uppEOLHookProcInfo = $0000001F; { SPECIAL_CASE_PROCINFO( kSpecialCaseEOLHook ) }
	uppCaretHookProcInfo = $0000000F; { SPECIAL_CASE_PROCINFO( kSpecialCaseCaretHook ) }
	uppWidthHookProcInfo = $0000002F; { SPECIAL_CASE_PROCINFO( kSpecialCaseWidthHook ) }
	uppTextWidthHookProcInfo = $0000002F; { SPECIAL_CASE_PROCINFO( kSpecialCaseTextWidthHook ) }
	uppNWidthHookProcInfo = $0000003F; { SPECIAL_CASE_PROCINFO( kSpecialCaseNWidthHook ) }
	uppDrawHookProcInfo = $0000004F; { SPECIAL_CASE_PROCINFO( kSpecialCaseDrawHook ) }
	uppHitTestHookProcInfo = $0000005F; { SPECIAL_CASE_PROCINFO( kSpecialCaseHitTestHook ) }
	uppTEFindWordProcInfo = $0000006F; { SPECIAL_CASE_PROCINFO( kSpecialCaseTEFindWord ) }
	uppTERecalcProcInfo = $0000009F; { SPECIAL_CASE_PROCINFO( kSpecialCaseTERecalc ) }
	uppTEDoTextProcInfo = $000000AF; { SPECIAL_CASE_PROCINFO( kSpecialCaseTEDoText ) }
	uppTEClickLoopProcInfo = $0000F812; { Register FUNCTION (4 bytes in A3): 1 byte in D0; }
	uppWordBreakProcInfo = $00029812; { Register FUNCTION (4 bytes in A0, 2 bytes in D0): 1 byte in D0; }

FUNCTION NewHighHookProc(userRoutine: HighHookProcPtr): HighHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewEOLHookProc(userRoutine: EOLHookProcPtr): EOLHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCaretHookProc(userRoutine: CaretHookProcPtr): CaretHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewWidthHookProc(userRoutine: WidthHookProcPtr): WidthHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTextWidthHookProc(userRoutine: TextWidthHookProcPtr): TextWidthHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNWidthHookProc(userRoutine: NWidthHookProcPtr): NWidthHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDrawHookProc(userRoutine: DrawHookProcPtr): DrawHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHitTestHookProc(userRoutine: HitTestHookProcPtr): HitTestHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTEFindWordProc(userRoutine: TEFindWordProcPtr): TEFindWordUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTERecalcProc(userRoutine: TERecalcProcPtr): TERecalcUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTEDoTextProc(userRoutine: TEDoTextProcPtr): TEDoTextUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTEClickLoopProc(userRoutine: TEClickLoopProcPtr): TEClickLoopUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewWordBreakProc(userRoutine: WordBreakProcPtr): WordBreakUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallHighHookProc({CONST}VAR r: Rect; pTE: TEPtr; userRoutine: HighHookUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallEOLHookProc(theChar: ByteParameter; pTE: TEPtr; hTE: TEHandle; userRoutine: EOLHookUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

PROCEDURE CallCaretHookProc({CONST}VAR r: Rect; pTE: TEPtr; userRoutine: CaretHookUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallWidthHookProc(textLen: INTEGER; textOffset: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: WidthHookUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallTextWidthHookProc(textLen: INTEGER; textOffset: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: TextWidthHookUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallNWidthHookProc(styleRunLen: INTEGER; styleRunOffset: INTEGER; slop: INTEGER; direction: INTEGER; textBufferPtr: UNIV Ptr; VAR lineStart: INTEGER; pTE: TEPtr; hTE: TEHandle; userRoutine: NWidthHookUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

PROCEDURE CallDrawHookProc(textOffset: INTEGER; drawLen: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: DrawHookUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallHitTestHookProc(styleRunLen: INTEGER; styleRunOffset: INTEGER; slop: INTEGER; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; VAR pixelWidth: INTEGER; VAR charOffset: INTEGER; VAR pixelInChar: BOOLEAN; userRoutine: HitTestHookUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

PROCEDURE CallTEFindWordProc(currentPos: INTEGER; caller: INTEGER; pTE: TEPtr; hTE: TEHandle; VAR wordStart: INTEGER; VAR wordEnd: INTEGER; userRoutine: TEFindWordUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

PROCEDURE CallTERecalcProc(pTE: TEPtr; changeLength: INTEGER; VAR lineStart: INTEGER; VAR firstChar: INTEGER; VAR lastChar: INTEGER; userRoutine: TERecalcUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

PROCEDURE CallTEDoTextProc(pTE: TEPtr; firstChar: INTEGER; lastChar: INTEGER; selector: INTEGER; VAR currentGrafPort: GrafPtr; VAR charPosition: INTEGER; userRoutine: TEDoTextUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallTEClickLoopProc(pTE: TEPtr; userRoutine: TEClickLoopUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallWordBreakProc(text: Ptr; charPos: INTEGER; userRoutine: WordBreakUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
FUNCTION TEScrapHandle : Handle;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $0AB4;			{ MOVE.l $0AB4,(SP) }
	{$ENDC}

FUNCTION TEGetScrapLength: LONGINT;
PROCEDURE TEInit;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9CC;
	{$ENDC}
FUNCTION TENew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D2;
	{$ENDC}
PROCEDURE TEDispose(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9CD;
	{$ENDC}
PROCEDURE TESetText(text: UNIV Ptr; length: LONGINT; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9CF;
	{$ENDC}
FUNCTION TEGetText(hTE: TEHandle): CharsHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9CB;
	{$ENDC}
PROCEDURE TEIdle(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DA;
	{$ENDC}
PROCEDURE TESetSelect(selStart: LONGINT; selEnd: LONGINT; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D1;
	{$ENDC}
PROCEDURE TEActivate(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D8;
	{$ENDC}
PROCEDURE TEDeactivate(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D9;
	{$ENDC}
PROCEDURE TEKey(key: CHAR; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DC;
	{$ENDC}
PROCEDURE TECut(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D6;
	{$ENDC}
PROCEDURE TECopy(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D5;
	{$ENDC}
PROCEDURE TEPaste(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DB;
	{$ENDC}
PROCEDURE TEDelete(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D7;
	{$ENDC}
PROCEDURE TEInsert(text: UNIV Ptr; length: LONGINT; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DE;
	{$ENDC}
PROCEDURE TESetAlignment(just: INTEGER; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DF;
	{$ENDC}
PROCEDURE TEUpdate({CONST}VAR rUpdate: Rect; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D3;
	{$ENDC}
PROCEDURE TETextBox(text: UNIV Ptr; length: LONGINT; {CONST}VAR box: Rect; just: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9CE;
	{$ENDC}
PROCEDURE TEScroll(dh: INTEGER; dv: INTEGER; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DD;
	{$ENDC}
PROCEDURE TESelView(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A811;
	{$ENDC}
PROCEDURE TEPinScroll(dh: INTEGER; dv: INTEGER; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A812;
	{$ENDC}
PROCEDURE TEAutoView(fAuto: BOOLEAN; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A813;
	{$ENDC}
PROCEDURE TECalText(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D0;
	{$ENDC}
FUNCTION TEGetOffset(pt: Point; hTE: TEHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A83C;
	{$ENDC}
FUNCTION TEGetPoint(offset: INTEGER; hTE: TEHandle): Point;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0008, $A83D;
	{$ENDC}
PROCEDURE TEClick(pt: Point; fExtend: BOOLEAN; h: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9D4;
	{$ENDC}
FUNCTION TEStyleNew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A83E;
	{$ENDC}
PROCEDURE TESetStyleHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}
FUNCTION TEGetStyleHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}
PROCEDURE TEGetStyle(offset: INTEGER; VAR theStyle: TextStyle; VAR lineHeight: INTEGER; VAR fontAscent: INTEGER; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0003, $A83D;
	{$ENDC}
PROCEDURE TEStylePaste(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0000, $A83D;
	{$ENDC}
PROCEDURE TESetStyle(mode: INTEGER; {CONST}VAR newStyle: TextStyle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0001, $A83D;
	{$ENDC}
PROCEDURE TEReplaceStyle(mode: INTEGER; {CONST}VAR oldStyle: TextStyle; {CONST}VAR newStyle: TextStyle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0002, $A83D;
	{$ENDC}
FUNCTION TEGetStyleScrapHandle(hTE: TEHandle): StScrpHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}
PROCEDURE TEStyleInsert(text: UNIV Ptr; length: LONGINT; hST: StScrpHandle; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0007, $A83D;
	{$ENDC}
FUNCTION TEGetHeight(endLine: LONGINT; startLine: LONGINT; hTE: TEHandle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0009, $A83D;
	{$ENDC}
FUNCTION TEContinuousStyle(VAR mode: INTEGER; VAR aStyle: TextStyle; hTE: TEHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000A, $A83D;
	{$ENDC}
PROCEDURE TEUseStyleScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}
PROCEDURE TECustomHook(which: TEIntHook; VAR addr: UniversalProcPtr; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000C, $A83D;
	{$ENDC}
FUNCTION TENumStyles(rangeStart: LONGINT; rangeEnd: LONGINT; hTE: TEHandle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000D, $A83D;
	{$ENDC}
FUNCTION TEFeatureFlag(feature: INTEGER; action: INTEGER; hTE: TEHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000E, $A83D;
	{$ENDC}
FUNCTION TEGetHiliteRgn(region: RgnHandle; hTE: TEHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000F, $A83D;
	{$ENDC}
PROCEDURE TESetScrapLength(length: LONGINT);
FUNCTION TEFromScrap: OSErr;
FUNCTION TEToScrap: OSErr;
PROCEDURE TESetClickLoop(clikProc: TEClickLoopUPP; hTE: TEHandle);
PROCEDURE TESetWordBreak(wBrkProc: WordBreakUPP; hTE: TEHandle);
{ 
	There is no function to get/set the low-mem for FindWordHook at 0x07F8.
	This is because it is not a low-mem ProcPtr. That address is the entry
	in the OS TrapTable for trap 0xA0FE.  You can use Get/SetTrapAddress to 
	acccess it.	
}
{$IFC OLDROUTINENAMES }
PROCEDURE TESetJust(just: INTEGER; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9DF;
	{$ENDC}
PROCEDURE TextBox(text: UNIV Ptr; length: LONGINT; {CONST}VAR box: Rect; just: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9CE;
	{$ENDC}
FUNCTION TEStylNew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A83E;
	{$ENDC}
PROCEDURE SetStylHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}
PROCEDURE SetStyleHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}
FUNCTION GetStylHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}
FUNCTION GetStyleHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}
PROCEDURE TEStylPaste(hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0000, $A83D;
	{$ENDC}
FUNCTION GetStylScrap(hTE: TEHandle): StScrpHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}
FUNCTION GetStyleScrap(hTE: TEHandle): StScrpHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}
PROCEDURE SetStylScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}
PROCEDURE SetStyleScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}
PROCEDURE TEStylInsert(text: UNIV Ptr; length: LONGINT; hST: StScrpHandle; hTE: TEHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0007, $A83D;
	{$ENDC}
PROCEDURE TESetScrapLen(length: LONGINT);
FUNCTION TEGetScrapLen: LONGINT;
PROCEDURE SetClikLoop(clikProc: TEClickLoopUPP; hTE: TEHandle);
PROCEDURE SetWordBreak(wBrkProc: WordBreakUPP; hTE: TEHandle);
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextEditIncludes}

{$ENDC} {__TEXTEDIT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
