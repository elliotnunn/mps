{
     File:       TextEdit.p
 
     Contains:   TextEdit Interfaces.
 
     Version:    Technology: System 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	TERecPtr = ^TERec;
	TEPtr								= ^TERec;
	TEHandle							= ^TEPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	HighHookProcPtr = PROCEDURE({CONST}VAR r: Rect; pTE: TEPtr);
{$ELSEC}
	HighHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EOLHookProcPtr = FUNCTION(theChar: ByteParameter; pTE: TEPtr; hTE: TEHandle): BOOLEAN;
{$ELSEC}
	EOLHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CaretHookProcPtr = PROCEDURE({CONST}VAR r: Rect; pTE: TEPtr);
{$ELSEC}
	CaretHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WidthHookProcPtr = FUNCTION(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle): UInt16;
{$ELSEC}
	WidthHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TextWidthHookProcPtr = FUNCTION(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle): UInt16;
{$ELSEC}
	TextWidthHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	NWidthHookProcPtr = FUNCTION(styleRunLen: UInt16; styleRunOffset: UInt16; slop: INTEGER; direction: INTEGER; textBufferPtr: UNIV Ptr; VAR lineStart: INTEGER; pTE: TEPtr; hTE: TEHandle): UInt16;
{$ELSEC}
	NWidthHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DrawHookProcPtr = PROCEDURE(textOffset: UInt16; drawLen: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle);
{$ELSEC}
	DrawHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HitTestHookProcPtr = FUNCTION(styleRunLen: UInt16; styleRunOffset: UInt16; slop: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; VAR pixelWidth: UInt16; VAR charOffset: UInt16; VAR pixelInChar: BOOLEAN): BOOLEAN;
{$ELSEC}
	HitTestHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TEFindWordProcPtr = PROCEDURE(currentPos: UInt16; caller: INTEGER; pTE: TEPtr; hTE: TEHandle; VAR wordStart: UInt16; VAR wordEnd: UInt16);
{$ELSEC}
	TEFindWordProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TERecalcProcPtr = PROCEDURE(pTE: TEPtr; changeLength: UInt16; VAR lineStart: UInt16; VAR firstChar: UInt16; VAR lastChar: UInt16);
{$ELSEC}
	TERecalcProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TEDoTextProcPtr = PROCEDURE(pTE: TEPtr; firstChar: UInt16; lastChar: UInt16; selector: INTEGER; VAR currentGrafPort: GrafPtr; VAR charPosition: INTEGER);
{$ELSEC}
	TEDoTextProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TEClickLoopProcPtr = FUNCTION(pTE: TEPtr): BOOLEAN;
{$ELSEC}
	TEClickLoopProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WordBreakProcPtr = FUNCTION(text: Ptr; charPos: INTEGER): BOOLEAN;
{$ELSEC}
	WordBreakProcPtr = Register68kProcPtr;
{$ENDC}

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
	    There is no function to get/set the low-mem for FindWordHook at 0x07F8.
	    This is because it is not a low-mem ProcPtr. That address is the entry
	    in the OS TrapTable for trap 0xA0FE.  You can use Get/SetTrapAddress to 
	    acccess it. 
		}

	{	
	    The following ProcPtrs cannot be written in or called from a high-level 
	    language without the help of mixed mode or assembly glue because they 
	    use the following parameter-passing conventions:
	
	    typedef pascal void (*HighHookProcPtr)(const Rect *r, TEPtr pTE);
	    typedef pascal void (*CaretHookProcPtr)(const Rect *r, TEPtr pTE);
	
	        In:
	            =>  r                       on stack
	            =>  pTE                     A3.L
	        Out:
	            none
	
	    typedef pascal Boolean (*EOLHookProcPtr)(char theChar, TEPtr pTE, TEHandle hTE);
	
	        In:
	            =>  theChar                 D0.B
	            =>  pTE                     A3.L
	            =>  hTE                     A4.L
	        Out:
	            <=  Boolean                 Z bit of the CCR
	
	    typedef pascal unsigned short (*WidthHookProcPtr)(unsigned short textLen,
	     unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
	    typedef pascal unsigned short (*TextWidthHookProcPtr)(unsigned short textLen,
	     unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
	
	        In:
	            =>  textLen                 D0.W
	            =>  textOffset              D1.W
	            =>  textBufferPtr           A0.L
	            =>  pTE                     A3.L
	            =>  hTE                     A4.L
	        Out:
	            <=  unsigned short          D1.W
	
	    typedef pascal unsigned short (*NWidthHookProcPtr)(unsigned short styleRunLen,
	     unsigned short styleRunOffset, short slop, short direction, void *textBufferPtr, 
	     short *lineStart, TEPtr pTE, TEHandle hTE);
	
	        In:
	            =>  styleRunLen             D0.W
	            =>  styleRunOffset          D1.W
	            =>  slop                    D2.W (low)
	            =>  direction               D2.W (high)
	            =>  textBufferPtr           A0.L
	            =>  lineStart               A2.L
	            =>  pTE                     A3.L
	            =>  hTE                     A4.L
	        Out:
	            <=  unsigned short          D1.W
	
	    typedef pascal void (*DrawHookProcPtr)(unsigned short textOffset, unsigned short drawLen,
	     void *textBufferPtr, TEPtr pTE, TEHandle hTE);
	
	        In:
	            =>  textOffset              D0.W
	            =>  drawLen                 D1.W
	            =>  textBufferPtr           A0.L
	            =>  pTE                     A3.L
	            =>  hTE                     A4.L
	        Out:
	            none
	
	    typedef pascal Boolean (*HitTestHookProcPtr)(unsigned short styleRunLen,
	     unsigned short styleRunOffset, unsigned short slop, void *textBufferPtr,
	     TEPtr pTE, TEHandle hTE, unsigned short *pixelWidth, unsigned short *charOffset, 
	     Boolean *pixelInChar);
	
	        In:
	            =>  styleRunLen             D0.W
	            =>  styleRunOffset          D1.W
	            =>  slop                    D2.W
	            =>  textBufferPtr           A0.L
	            =>  pTE                     A3.L
	            =>  hTE                     A4.L
	        Out:
	            <=  pixelWidth              D0.W (low)
	            <=  Boolean                 D0.W (high)
	            <=  charOffset              D1.W
	            <=  pixelInChar             D2.W
	
	    typedef pascal void (*TEFindWordProcPtr)(unsigned short currentPos, short caller, 
	     TEPtr pTE, TEHandle hTE, unsigned short *wordStart, unsigned short *wordEnd);
	
	        In:
	            =>  currentPos              D0.W
	            =>  caller                  D2.W
	            =>  pTE                     A3.L
	            =>  hTE                     A4.L
	        Out:
	            <=  wordStart               D0.W
	            <=  wordEnd                 D1.W
	
	    typedef pascal void (*TERecalcProcPtr)(TEPtr pTE, unsigned short changeLength,
	     unsigned short *lineStart, unsigned short *firstChar, unsigned short *lastChar);
	
	        In:
	            =>  pTE                     A3.L
	            =>  changeLength            D7.W
	        Out:
	            <=  lineStart               D2.W
	            <=  firstChar               D3.W
	            <=  lastChar                D4.W
	
	    typedef pascal void (*TEDoTextProcPtr)(TEPtr pTE, unsigned short firstChar, unsigned short lastChar,
	                        short selector, GrafPtr *currentGrafPort, short *charPosition);
	
	        In:
	            =>  pTE                     A3.L
	            =>  firstChar               D3.W
	            =>  lastChar                D4.W
	            =>  selector                D7.W
	        Out:
	            <=  currentGrafPort         A0.L
	            <=  charPosition            D0.W
	            
		}
{$IFC OPAQUE_UPP_TYPES}
	HighHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HighHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	EOLHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EOLHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CaretHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CaretHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	WidthHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	WidthHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TextWidthHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TextWidthHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NWidthHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NWidthHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DrawHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DrawHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	HitTestHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HitTestHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TEFindWordUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TEFindWordUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TERecalcUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TERecalcUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TEDoTextUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TEDoTextUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TEClickLoopUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TEClickLoopUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	WordBreakUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	WordBreakUPP = UniversalProcPtr;
{$ENDC}	
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
		wordBreak:				WordBreakUPP;							{  NOTE: This field is ignored on non-Roman systems and on Carbon (see IM-Text 2-60)  }
		clickLoop:				TEClickLoopUPP;
		clickTime:				LONGINT;
		clickLoc:				INTEGER;
		caretTime:				LONGINT;
		caretState:				INTEGER;
		just:					INTEGER;
		teLength:				INTEGER;
		hText:					Handle;
		hDispatchRec:			LONGINT;								{  added to replace recalBack & recalLines.  it's a handle anyway  }
		clikStuff:				INTEGER;
		crOnly:					INTEGER;
		txFont:					INTEGER;
		txFace:					StyleField;								{ StyleField occupies 16-bits, but only first 8-bits are used }
		txMode:					INTEGER;
		txSize:					INTEGER;
		inPort:					GrafPtr;
		highHook:				HighHookUPP;
		caretHook:				CaretHookUPP;
		nLines:					INTEGER;
		lineStarts:				ARRAY [0..16000] OF INTEGER;
	END;


CONST
																{  Justification (word alignment) styles  }
	teJustLeft					= 0;
	teJustCenter				= 1;
	teJustRight					= -1;
	teForceLeft					= -2;							{  new names for the Justification (word alignment) styles  }
	teFlushDefault				= 0;							{ flush according to the line direction  }
	teCenter					= 1;							{ center justify (word alignment)  }
	teFlushRight				= -1;							{ flush right for all scripts  }
	teFlushLeft					= -2;							{ flush left for all scripts  }

																{  Set/Replace style modes  }
	fontBit						= 0;							{ set font }
	faceBit						= 1;							{ set face }
	sizeBit						= 2;							{ set size }
	clrBit						= 3;							{ set color }
	addSizeBit					= 4;							{ add size mode }
	toggleBit					= 5;							{ set faces in toggle mode }

																{  TESetStyle/TEContinuousStyle modes  }
	doFont						= 1;							{  set font (family) number }
	doFace						= 2;							{ set character style }
	doSize						= 4;							{ set type size }
	doColor						= 8;							{ set color }
	doAll						= 15;							{ set all attributes }
	addSize						= 16;							{ adjust type size }
	doToggle					= 32;							{ toggle mode for TESetStyle }

																{  offsets into TEDispatchRec  }
	EOLHook						= 0;							{ [UniversalProcPtr] TEEOLHook }
	DRAWHook					= 4;							{ [UniversalProcPtr] TEWidthHook }
	WIDTHHook					= 8;							{ [UniversalProcPtr] TEDrawHook }
	HITTESTHook					= 12;							{ [UniversalProcPtr] TEHitTestHook }
	nWIDTHHook					= 24;							{ [UniversalProcPtr] nTEWidthHook }
	TextWidthHook				= 28;							{ [UniversalProcPtr] TETextWidthHook }

																{  selectors for TECustomHook  }
	intEOLHook					= 0;							{ TEIntHook value }
	intDrawHook					= 1;							{ TEIntHook value }
	intWidthHook				= 2;							{ TEIntHook value }
	intHitTestHook				= 3;							{ TEIntHook value }
	intNWidthHook				= 6;							{ TEIntHook value for new version of WidthHook }
	intTextWidthHook			= 7;							{ TEIntHook value for new TextWidthHook }
	intInlineInputTSMTEPreUpdateHook = 8;						{ TEIntHook value for TSMTEPreUpdateProcPtr callback }
	intInlineInputTSMTEPostUpdateHook = 9;						{ TEIntHook value for TSMTEPostUpdateProcPtr callback }

																{  feature or bit definitions for TEFeatureFlag  }
	teFAutoScroll				= 0;							{ 00000001b }
	teFTextBuffering			= 1;							{ 00000010b }
	teFOutlineHilite			= 2;							{ 00000100b }
	teFInlineInput				= 3;							{ 00001000b  }
	teFUseWhiteBackground		= 4;							{ 00010000b  }
	teFUseInlineInput			= 5;							{ 00100000b  }
	teFInlineInputAutoScroll	= 6;							{ 01000000b  }

																{  feature or bit definitions for TEFeatureFlag -- Carbon only                 }
																{  To avoid having to call TEIdle in Carbon apps, automatic idling can be activated    }
																{  via the following feature flag, but you must ensure that the destRect and/or      }
																{  GrafPort's origin be setup properly for drawing in a given TERec when        }
																{  the timer fires.    When this feature flag is set, TEIdle is a noop.           }
																{  Activate this feature flag before calling TEActivate.                  }
	teFIdleWithEventLoopTimer	= 7;							{ 10000000b  }

																{  action for the new "bit (un)set" interface, TEFeatureFlag  }
	teBitClear					= 0;
	teBitSet					= 1;							{ set the selector bit }
	teBitTest					= -1;							{ no change; just return the current setting }

																{ constants for identifying the routine that called FindWord  }
	teWordSelect				= 4;							{ clickExpand to select word }
	teWordDrag					= 8;							{ clickExpand to drag new word }
	teFromFind					= 12;							{ FindLine called it ($0C) }
	teFromRecal					= 16;							{ RecalLines called it ($10)      obsolete  }

																{ constants for identifying TEDoText selectors  }
	teFind						= 0;							{ TEDoText called for searching }
	teHighlight					= 1;							{ TEDoText called for highlighting }
	teDraw						= -1;							{ TEDoText called for drawing text }
	teCaret						= -2;							{ TEDoText called for drawing the caret }



TYPE
	Chars								= PACKED ARRAY [0..32000] OF CHAR;
	CharsPtr							= ^Chars;
	CharsHandle							= ^CharsPtr;
	StyleRunPtr = ^StyleRun;
	StyleRun = RECORD
		startChar:				INTEGER;								{ starting character position }
		styleIndex:				INTEGER;								{ index in style table }
	END;

	STElementPtr = ^STElement;
	STElement = RECORD
		stCount:				INTEGER;								{ number of runs in this style }
		stHeight:				INTEGER;								{ line height }
		stAscent:				INTEGER;								{ font ascent }
		stFont:					INTEGER;								{ font (family) number }
		stFace:					StyleField;								{ StyleField occupies 16-bits, but only first 8-bits are used  }
		stSize:					INTEGER;								{ size in points }
		stColor:				RGBColor;								{ absolute (RGB) color }
	END;

	TEStyleTable						= ARRAY [0..1776] OF STElement;
	STPtr								= ^TEStyleTable;
	STHandle							= ^STPtr;
	LHElementPtr = ^LHElement;
	LHElement = RECORD
		lhHeight:				INTEGER;								{ maximum height in line }
		lhAscent:				INTEGER;								{ maximum ascent in line }
	END;

	LHTable								= ARRAY [0..8000] OF LHElement;
	LHPtr								= ^LHTable;
	LHHandle							= ^LHPtr;
	ScrpSTElementPtr = ^ScrpSTElement;
	ScrpSTElement = RECORD
		scrpStartChar:			LONGINT;								{ starting character position }
		scrpHeight:				INTEGER;
		scrpAscent:				INTEGER;
		scrpFont:				INTEGER;
		scrpFace:				StyleField;								{ StyleField occupies 16-bits, but only first 8-bits are used }
		scrpSize:				INTEGER;
		scrpColor:				RGBColor;
	END;

	{	 ARRAY [0..1600] OF ScrpSTElement 	}
	ScrpSTTable							= ARRAY [0..1600] OF ScrpSTElement;
	StScrpRecPtr = ^StScrpRec;
	StScrpRec = RECORD
		scrpNStyles:			INTEGER;								{ number of styles in scrap }
		scrpStyleTab:			ScrpSTTable;							{ table of styles for scrap }
	END;

	StScrpPtr							= ^StScrpRec;
	StScrpHandle						= ^StScrpPtr;
	NullStRecPtr = ^NullStRec;
	NullStRec = RECORD
		teReserved:				LONGINT;								{ reserved for future expansion }
		nullScrap:				StScrpHandle;							{ handle to scrap style table }
	END;

	NullStPtr							= ^NullStRec;
	NullStHandle						= ^NullStPtr;
	TEStyleRecPtr = ^TEStyleRec;
	TEStyleRec = RECORD
		nRuns:					INTEGER;								{ number of style runs }
		nStyles:				INTEGER;								{ size of style table }
		styleTab:				STHandle;								{ handle to style table }
		lhTab:					LHHandle;								{ handle to line-height table }
		teRefCon:				LONGINT;								{ reserved for application use }
		nullStyle:				NullStHandle;							{ Handle to style set at null selection }
		runs:					ARRAY [0..8000] OF StyleRun;			{ ARRAY [0..8000] OF StyleRun }
	END;

	TEStylePtr							= ^TEStyleRec;
	TEStyleHandle						= ^TEStylePtr;
	TextStylePtr = ^TextStyle;
	TextStyle = RECORD
		tsFont:					INTEGER;								{ font (family) number }
		tsFace:					StyleField;								{ StyleField occupies 16-bits, but only first 8-bits are used }
		tsSize:					INTEGER;								{ size in point }
		tsColor:				RGBColor;								{ absolute (RGB) color }
	END;

	TextStyleHandle						= ^TextStylePtr;
	TEIntHook							= INTEGER;

CONST
	uppHighHookProcInfo = $0000000F;
	uppEOLHookProcInfo = $0000001F;
	uppCaretHookProcInfo = $0000000F;
	uppWidthHookProcInfo = $0000002F;
	uppTextWidthHookProcInfo = $0000002F;
	uppNWidthHookProcInfo = $0000003F;
	uppDrawHookProcInfo = $0000004F;
	uppHitTestHookProcInfo = $0000005F;
	uppTEFindWordProcInfo = $0000006F;
	uppTERecalcProcInfo = $0000009F;
	uppTEDoTextProcInfo = $000000AF;
	uppTEClickLoopProcInfo = $0000F812;
	uppWordBreakProcInfo = $00029812;
	{
	 *  NewHighHookUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewHighHookUPP(userRoutine: HighHookProcPtr): HighHookUPP; { old name was NewHighHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewEOLHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewEOLHookUPP(userRoutine: EOLHookProcPtr): EOLHookUPP; { old name was NewEOLHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCaretHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCaretHookUPP(userRoutine: CaretHookProcPtr): CaretHookUPP; { old name was NewCaretHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewWidthHookUPP(userRoutine: WidthHookProcPtr): WidthHookUPP; { old name was NewWidthHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTextWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTextWidthHookUPP(userRoutine: TextWidthHookProcPtr): TextWidthHookUPP; { old name was NewTextWidthHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewNWidthHookUPP(userRoutine: NWidthHookProcPtr): NWidthHookUPP; { old name was NewNWidthHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDrawHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDrawHookUPP(userRoutine: DrawHookProcPtr): DrawHookUPP; { old name was NewDrawHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHitTestHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHitTestHookUPP(userRoutine: HitTestHookProcPtr): HitTestHookUPP; { old name was NewHitTestHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTEFindWordUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTEFindWordUPP(userRoutine: TEFindWordProcPtr): TEFindWordUPP; { old name was NewTEFindWordProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTERecalcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTERecalcUPP(userRoutine: TERecalcProcPtr): TERecalcUPP; { old name was NewTERecalcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTEDoTextUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTEDoTextUPP(userRoutine: TEDoTextProcPtr): TEDoTextUPP; { old name was NewTEDoTextProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTEClickLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTEClickLoopUPP(userRoutine: TEClickLoopProcPtr): TEClickLoopUPP; { old name was NewTEClickLoopProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  NewWordBreakUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewWordBreakUPP(userRoutine: WordBreakProcPtr): WordBreakUPP; { old name was NewWordBreakProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DisposeHighHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHighHookUPP(userUPP: HighHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeEOLHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEOLHookUPP(userUPP: EOLHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCaretHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCaretHookUPP(userUPP: CaretHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeWidthHookUPP(userUPP: WidthHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTextWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTextWidthHookUPP(userUPP: TextWidthHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNWidthHookUPP(userUPP: NWidthHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDrawHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDrawHookUPP(userUPP: DrawHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHitTestHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHitTestHookUPP(userUPP: HitTestHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTEFindWordUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTEFindWordUPP(userUPP: TEFindWordUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTERecalcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTERecalcUPP(userUPP: TERecalcUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTEDoTextUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTEDoTextUPP(userUPP: TEDoTextUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTEClickLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTEClickLoopUPP(userUPP: TEClickLoopUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposeWordBreakUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeWordBreakUPP(userUPP: WordBreakUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  InvokeHighHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeHighHookUPP({CONST}VAR r: Rect; pTE: TEPtr; userRoutine: HighHookUPP); { old name was CallHighHookProc }
{
 *  InvokeEOLHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeEOLHookUPP(theChar: ByteParameter; pTE: TEPtr; hTE: TEHandle; userRoutine: EOLHookUPP): BOOLEAN; { old name was CallEOLHookProc }
{
 *  InvokeCaretHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeCaretHookUPP({CONST}VAR r: Rect; pTE: TEPtr; userRoutine: CaretHookUPP); { old name was CallCaretHookProc }
{
 *  InvokeWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeWidthHookUPP(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: WidthHookUPP): UInt16; { old name was CallWidthHookProc }
{
 *  InvokeTextWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeTextWidthHookUPP(textLen: UInt16; textOffset: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: TextWidthHookUPP): UInt16; { old name was CallTextWidthHookProc }
{
 *  InvokeNWidthHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeNWidthHookUPP(styleRunLen: UInt16; styleRunOffset: UInt16; slop: INTEGER; direction: INTEGER; textBufferPtr: UNIV Ptr; VAR lineStart: INTEGER; pTE: TEPtr; hTE: TEHandle; userRoutine: NWidthHookUPP): UInt16; { old name was CallNWidthHookProc }
{
 *  InvokeDrawHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDrawHookUPP(textOffset: UInt16; drawLen: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; userRoutine: DrawHookUPP); { old name was CallDrawHookProc }
{
 *  InvokeHitTestHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHitTestHookUPP(styleRunLen: UInt16; styleRunOffset: UInt16; slop: UInt16; textBufferPtr: UNIV Ptr; pTE: TEPtr; hTE: TEHandle; VAR pixelWidth: UInt16; VAR charOffset: UInt16; VAR pixelInChar: BOOLEAN; userRoutine: HitTestHookUPP): BOOLEAN; { old name was CallHitTestHookProc }
{
 *  InvokeTEFindWordUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTEFindWordUPP(currentPos: UInt16; caller: INTEGER; pTE: TEPtr; hTE: TEHandle; VAR wordStart: UInt16; VAR wordEnd: UInt16; userRoutine: TEFindWordUPP); { old name was CallTEFindWordProc }
{
 *  InvokeTERecalcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTERecalcUPP(pTE: TEPtr; changeLength: UInt16; VAR lineStart: UInt16; VAR firstChar: UInt16; VAR lastChar: UInt16; userRoutine: TERecalcUPP); { old name was CallTERecalcProc }
{
 *  InvokeTEDoTextUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTEDoTextUPP(pTE: TEPtr; firstChar: UInt16; lastChar: UInt16; selector: INTEGER; VAR currentGrafPort: GrafPtr; VAR charPosition: INTEGER; userRoutine: TEDoTextUPP); { old name was CallTEDoTextProc }
{
 *  InvokeTEClickLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeTEClickLoopUPP(pTE: TEPtr; userRoutine: TEClickLoopUPP): BOOLEAN; { old name was CallTEClickLoopProc }
{$IFC CALL_NOT_IN_CARBON }
{
 *  InvokeWordBreakUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeWordBreakUPP(text: Ptr; charPos: INTEGER; userRoutine: WordBreakUPP): BOOLEAN; { old name was CallWordBreakProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
																{  feature bit 4 for TEFeatureFlag no longer in use  }
	teFUseTextServices			= 4;							{ 00010000b  }


	{
	 *  TEScrapHandle()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION TEScrapHandle: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0AB4;
	{$ENDC}


{
 *  TEGetScrapLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetScrapLength: LONGINT;

{$IFC CALL_NOT_IN_CARBON }
{
 *  TEInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TEInit;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CC;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  TENew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TENew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D2;
	{$ENDC}

{
 *  TEDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEDispose(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CD;
	{$ENDC}

{
 *  TESetText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetText(text: UNIV Ptr; length: LONGINT; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CF;
	{$ENDC}

{
 *  TEGetText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetText(hTE: TEHandle): CharsHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CB;
	{$ENDC}

{
 *  TEIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEIdle(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DA;
	{$ENDC}

{
 *  TESetSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetSelect(selStart: LONGINT; selEnd: LONGINT; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D1;
	{$ENDC}

{
 *  TEActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEActivate(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D8;
	{$ENDC}

{
 *  TEDeactivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEDeactivate(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D9;
	{$ENDC}

{
 *  TEKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEKey(key: CharParameter; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DC;
	{$ENDC}

{
 *  TECut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TECut(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D6;
	{$ENDC}

{
 *  TECopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TECopy(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D5;
	{$ENDC}

{
 *  TEPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEPaste(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DB;
	{$ENDC}

{
 *  TEDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEDelete(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D7;
	{$ENDC}

{
 *  TEInsert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEInsert(text: UNIV Ptr; length: LONGINT; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DE;
	{$ENDC}

{
 *  TESetAlignment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetAlignment(just: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DF;
	{$ENDC}

{
 *  TEUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEUpdate({CONST}VAR rUpdate: Rect; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D3;
	{$ENDC}

{
 *  TETextBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TETextBox(text: UNIV Ptr; length: LONGINT; {CONST}VAR box: Rect; just: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CE;
	{$ENDC}

{
 *  TEScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEScroll(dh: INTEGER; dv: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DD;
	{$ENDC}

{
 *  TESelView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESelView(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A811;
	{$ENDC}

{
 *  TEPinScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEPinScroll(dh: INTEGER; dv: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A812;
	{$ENDC}

{
 *  TEAutoView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEAutoView(fAuto: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A813;
	{$ENDC}

{
 *  TECalText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TECalText(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D0;
	{$ENDC}

{
 *  TEGetOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetOffset(pt: Point; hTE: TEHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83C;
	{$ENDC}

{
 *  TEGetPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetPoint(offset: INTEGER; hTE: TEHandle): Point;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A83D;
	{$ENDC}

{
 *  TEClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEClick(pt: Point; fExtend: BOOLEAN; h: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9D4;
	{$ENDC}

{
 *  TEStyleNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEStyleNew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83E;
	{$ENDC}

{
 *  TESetStyleHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetStyleHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}

{
 *  TEGetStyleHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetStyleHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}

{
 *  TEGetStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEGetStyle(offset: INTEGER; VAR theStyle: TextStyle; VAR lineHeight: INTEGER; VAR fontAscent: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A83D;
	{$ENDC}

{
 *  TEStylePaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEStylePaste(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0000, $A83D;
	{$ENDC}

{
 *  TESetStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetStyle(mode: INTEGER; {CONST}VAR newStyle: TextStyle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A83D;
	{$ENDC}

{
 *  TEReplaceStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEReplaceStyle(mode: INTEGER; {CONST}VAR oldStyle: TextStyle; {CONST}VAR newStyle: TextStyle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A83D;
	{$ENDC}

{
 *  TEGetStyleScrapHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetStyleScrapHandle(hTE: TEHandle): StScrpHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}

{
 *  TEStyleInsert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEStyleInsert(text: UNIV Ptr; length: LONGINT; hST: StScrpHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A83D;
	{$ENDC}

{
 *  TEGetHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetHeight(endLine: LONGINT; startLine: LONGINT; hTE: TEHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0009, $A83D;
	{$ENDC}

{
 *  TEContinuousStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEContinuousStyle(VAR mode: INTEGER; VAR aStyle: TextStyle; hTE: TEHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000A, $A83D;
	{$ENDC}

{
 *  TEUseStyleScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TEUseStyleScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}

{
 *  TECustomHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TECustomHook(which: TEIntHook; VAR addr: UniversalProcPtr; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000C, $A83D;
	{$ENDC}

{
 *  TENumStyles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TENumStyles(rangeStart: LONGINT; rangeEnd: LONGINT; hTE: TEHandle): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000D, $A83D;
	{$ENDC}

{
 *  TEFeatureFlag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEFeatureFlag(feature: INTEGER; action: INTEGER; hTE: TEHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000E, $A83D;
	{$ENDC}

{
 *  TEGetHiliteRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DragLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetHiliteRgn(region: RgnHandle; hTE: TEHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000F, $A83D;
	{$ENDC}

{
 *  TESetScrapLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetScrapLength(length: LONGINT);

{
 *  TEFromScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEFromScrap: OSErr;

{
 *  TEToScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEToScrap: OSErr;

{
 *  TESetClickLoop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetClickLoop(clikProc: TEClickLoopUPP; hTE: TEHandle);

{$IFC CALL_NOT_IN_CARBON }
{
 *  TESetWordBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TESetWordBreak(wBrkProc: WordBreakUPP; hTE: TEHandle);








{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  TEGetDoTextHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetDoTextHook: TEDoTextUPP;

{
 *  TESetDoTextHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetDoTextHook(value: TEDoTextUPP);

{
 *  TEGetRecalcHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetRecalcHook: TERecalcUPP;

{
 *  TESetRecalcHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetRecalcHook(value: TERecalcUPP);

{
 *  TEGetFindWordHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetFindWordHook: TEFindWordUPP;

{
 *  TESetFindWordHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetFindWordHook(value: TEFindWordUPP);

{
 *  TEGetScrapHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TEGetScrapHandle: Handle;

{
 *  TESetScrapHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TESetScrapHandle(value: Handle);



{ LMGetWordRedraw and LMSetWordRedraw were previously in LowMem.h  }
{ Deprecated for Carbon on MacOS X                                 }
{ This lomem is no longer used by the implementation of TextEdit   }
{ on MacOS X, so setting it will have no effect.                   }
{
 *  LMGetWordRedraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetWordRedraw: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $0BA5;
	{$ENDC}

{
 *  LMSetWordRedraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetWordRedraw(value: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $11DF, $0BA5;
	{$ENDC}



{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  TESetJust()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TESetJust(just: INTEGER; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9DF;
	{$ENDC}

{
 *  TextBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TextBox(text: UNIV Ptr; length: LONGINT; {CONST}VAR box: Rect; just: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9CE;
	{$ENDC}

{
 *  TEStylNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TEStylNew({CONST}VAR destRect: Rect; {CONST}VAR viewRect: Rect): TEHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83E;
	{$ENDC}

{
 *  SetStylHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetStylHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}

{
 *  SetStyleHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetStyleHandle(theHandle: TEStyleHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A83D;
	{$ENDC}

{
 *  GetStylHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetStylHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}

{
 *  GetStyleHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetStyleHandle(hTE: TEHandle): TEStyleHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A83D;
	{$ENDC}

{
 *  TEStylPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TEStylPaste(hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0000, $A83D;
	{$ENDC}

{
 *  GetStylScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetStylScrap(hTE: TEHandle): StScrpHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}

{
 *  GetStyleScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetStyleScrap(hTE: TEHandle): StScrpHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A83D;
	{$ENDC}

{
 *  SetStylScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetStylScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}

{
 *  SetStyleScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetStyleScrap(rangeStart: LONGINT; rangeEnd: LONGINT; newStyles: StScrpHandle; fRedraw: BOOLEAN; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000B, $A83D;
	{$ENDC}

{
 *  TEStylInsert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TEStylInsert(text: UNIV Ptr; length: LONGINT; hST: StScrpHandle; hTE: TEHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A83D;
	{$ENDC}

{
 *  TESetScrapLen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TESetScrapLen(length: LONGINT);

{
 *  TEGetScrapLen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TEGetScrapLen: LONGINT;

{
 *  SetClikLoop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetClikLoop(clikProc: TEClickLoopUPP; hTE: TEHandle);

{
 *  SetWordBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetWordBreak(wBrkProc: WordBreakUPP; hTE: TEHandle);

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextEditIncludes}

{$ENDC} {__TEXTEDIT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
