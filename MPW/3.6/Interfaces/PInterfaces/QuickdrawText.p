{
     File:       QuickdrawText.p
 
     Contains:   Quickdraw Text Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1983-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickdrawText;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$SETC __QUICKDRAWTEXT__ := 1}

{$I+}
{$SETC QuickdrawTextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __INTLRESOURCES__}
{$I IntlResources.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ new CGrafPort bottleneck ("newProc2") function, used in Unicode Text drawing }
{
 *  StandardGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickDrawText 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StandardGlyphs(dataStream: UNIV Ptr; size: ByteCount): OSStatus; C;



CONST
																{  CharToPixel directions  }
	leftCaret					= 0;							{ Place caret for left block }
	rightCaret					= -1;							{ Place caret for right block }
	kHilite						= 1;							{ Direction is SysDirection }

	smLeftCaret					= 0;							{ Place caret for left block - obsolete  }
	smRightCaret				= -1;							{ Place caret for right block - obsolete  }
	smHilite					= 1;							{ Direction is TESysJust - obsolete  }

																{ Constants for styleRunPosition argument in PortionLine, DrawJustified, MeasureJustified, CharToPixel, and PixelToChar. }
	onlyStyleRun				= 0;							{  This is the only style run on the line  }
	leftStyleRun				= 1;							{  This is leftmost of multiple style runs on the line  }
	rightStyleRun				= 2;							{  This is rightmost of multiple style runs on the line  }
	middleStyleRun				= 3;							{  There are multiple style runs on the line and this is neither the leftmost nor the rightmost.  }
	smOnlyStyleRun				= 0;							{  obsolete  }
	smLeftStyleRun				= 1;							{  obsolete  }
	smRightStyleRun				= 2;							{  obsolete  }
	smMiddleStyleRun			= 3;							{  obsolete  }

	{	 type for styleRunPosition parameter in PixelToChar etc. 	}

TYPE
	JustStyleCode						= INTEGER;
	{	 Type for truncWhere parameter in TruncString, TruncText 	}
	TruncCode							= INTEGER;

CONST
																{  Constants for truncWhere argument in TruncString and TruncText  }
	truncEnd					= 0;							{  Truncate at end  }
	truncMiddle					= $4000;						{  Truncate in middle  }
	smTruncEnd					= 0;							{  Truncate at end - obsolete  }
	smTruncMiddle				= $4000;						{  Truncate in middle - obsolete  }

																{  Constants for TruncString and TruncText results  }
	notTruncated				= 0;							{  No truncation was necessary  }
	truncated					= 1;							{  Truncation performed  }
	truncErr					= -1;							{  General error  }
	smNotTruncated				= 0;							{  No truncation was necessary - obsolete  }
	smTruncated					= 1;							{  Truncation performed   - obsolete  }
	smTruncErr					= -1;							{  General error - obsolete  }


TYPE
	StyledLineBreakCode					= SInt8;

CONST
	smBreakWord					= 0;
	smBreakChar					= 1;
	smBreakOverflow				= 2;

	{	QuickTime3.0	}
																{  Constants for txFlags (which used to be the pad field after txFace)  }
	tfAntiAlias					= $01;
	tfUnicode					= $02;



TYPE
	FontInfoPtr = ^FontInfo;
	FontInfo = RECORD
		ascent:					INTEGER;
		descent:				INTEGER;
		widMax:					INTEGER;
		leading:				INTEGER;
	END;

	FormatOrder							= ARRAY [0..0] OF INTEGER;
	FormatOrderPtr						= ^FormatOrder;
	{	 FormatStatus was moved to TextUtils.i 	}
	{	 OffsetTable moved to IntlResources.i 	}

{$IFC TYPED_FUNCTION_POINTERS}
	StyleRunDirectionProcPtr = FUNCTION(styleRunIndex: INTEGER; dirParam: UNIV Ptr): BOOLEAN;
{$ELSEC}
	StyleRunDirectionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	StyleRunDirectionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	StyleRunDirectionUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppStyleRunDirectionProcInfo = $00000390;
	{
	 *  NewStyleRunDirectionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewStyleRunDirectionUPP(userRoutine: StyleRunDirectionProcPtr): StyleRunDirectionUPP; { old name was NewStyleRunDirectionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeStyleRunDirectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeStyleRunDirectionUPP(userUPP: StyleRunDirectionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeStyleRunDirectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeStyleRunDirectionUPP(styleRunIndex: INTEGER; dirParam: UNIV Ptr; userRoutine: StyleRunDirectionUPP): BOOLEAN; { old name was CallStyleRunDirectionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  Pixel2Char()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Pixel2Char(textBuf: Ptr; textLen: INTEGER; slop: INTEGER; pixelWidth: INTEGER; VAR leadingEdge: BOOLEAN): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820E, $0014, $A8B5;
	{$ENDC}

{
 *  Char2Pixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Char2Pixel(textBuf: Ptr; textLen: INTEGER; slop: INTEGER; offset: INTEGER; direction: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $0016, $A8B5;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  PixelToChar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PixelToChar(textBuf: Ptr; textLength: LONGINT; slop: Fixed; pixelWidth: Fixed; VAR leadingEdge: BOOLEAN; VAR widthRemaining: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8222, $002E, $A8B5;
	{$ENDC}

{
 *  CharToPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CharToPixel(textBuf: Ptr; textLength: LONGINT; slop: Fixed; offset: LONGINT; direction: INTEGER; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $821C, $0030, $A8B5;
	{$ENDC}

{
 *  DrawJustified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawJustified(textPtr: Ptr; textLength: LONGINT; slop: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8016, $0032, $A8B5;
	{$ENDC}

{
 *  MeasureJustified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MeasureJustified(textPtr: Ptr; textLength: LONGINT; slop: Fixed; charLocs: Ptr; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $801A, $0034, $A8B5;
	{$ENDC}

{
 *  PortionLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PortionLine(textPtr: Ptr; textLen: LONGINT; styleRunPosition: JustStyleCode; numer: Point; denom: Point): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8412, $0036, $A8B5;
	{$ENDC}

{
 *  HiliteText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HiliteText(textPtr: Ptr; textLength: INTEGER; firstOffset: INTEGER; secondOffset: INTEGER; VAR offsets: OffsetTable);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $800E, $001C, $A8B5;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DrawJust()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DrawJust(textPtr: Ptr; textLength: INTEGER; slop: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8008, $001E, $A8B5;
	{$ENDC}

{
 *  MeasureJust()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MeasureJust(textPtr: Ptr; textLength: INTEGER; slop: INTEGER; charLocs: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $800C, $0020, $A8B5;
	{$ENDC}

{
 *  PortionText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PortionText(textPtr: Ptr; textLength: LONGINT): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8408, $0024, $A8B5;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  VisibleLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION VisibleLength(textPtr: Ptr; textLength: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8408, $0028, $A8B5;
	{$ENDC}

{
 *  GetFormatOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetFormatOrder(ordering: FormatOrderPtr; firstFormat: INTEGER; lastFormat: INTEGER; lineRight: BOOLEAN; rlDirProc: StyleRunDirectionUPP; dirParam: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8012, $FFFC, $A8B5;
	{$ENDC}

{
 *  TextFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TextFont(font: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A887;
	{$ENDC}

{
 *  TextFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TextFace(face: StyleParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A888;
	{$ENDC}

{
 *  TextMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TextMode(mode: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A889;
	{$ENDC}

{
 *  TextSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TextSize(size: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88A;
	{$ENDC}

{
 *  SpaceExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SpaceExtra(extra: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88E;
	{$ENDC}

{
 *  DrawChar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawChar(ch: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A883;
	{$ENDC}

{
 *  DrawString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawString(s: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A884;
	{$ENDC}

{
 *  [Mac]DrawText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawText(textBuf: UNIV Ptr; firstByte: INTEGER; byteCount: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A885;
	{$ENDC}

{
 *  CharWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CharWidth(ch: CharParameter): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88D;
	{$ENDC}

{
 *  StringWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StringWidth(s: Str255): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88C;
	{$ENDC}

{
 *  TextWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TextWidth(textBuf: UNIV Ptr; firstByte: INTEGER; byteCount: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A886;
	{$ENDC}

{
 *  MeasureText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MeasureText(count: INTEGER; textAddr: UNIV Ptr; charLocs: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A837;
	{$ENDC}

{
 *  GetFontInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetFontInfo(VAR info: FontInfo);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A88B;
	{$ENDC}

{
 *  CharExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CharExtra(extra: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA23;
	{$ENDC}

{
 *  StdText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdText(count: INTEGER; textAddr: UNIV Ptr; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A882;
	{$ENDC}

{
 *  StdTxMeas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StdTxMeas(byteCount: INTEGER; textAddr: UNIV Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8ED;
	{$ENDC}

{
 *  StyledLineBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StyledLineBreak(textPtr: Ptr; textLen: LONGINT; textStart: LONGINT; textEnd: LONGINT; flags: LONGINT; VAR textWidth: Fixed; VAR textOffset: LONGINT): StyledLineBreakCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $821C, $FFFE, $A8B5;
	{$ENDC}

{
 *  TruncString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TruncString(width: INTEGER; VAR theString: Str255; truncWhere: TruncCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8208, $FFE0, $A8B5;
	{$ENDC}

{
 *  TruncText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TruncText(width: INTEGER; textPtr: Ptr; VAR length: INTEGER; truncWhere: TruncCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $FFDE, $A8B5;
	{$ENDC}


{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  NPixel2Char()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NPixel2Char(textBuf: Ptr; textLength: LONGINT; slop: Fixed; pixelWidth: Fixed; VAR leadingEdge: BOOLEAN; VAR widthRemaining: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8222, $002E, $A8B5;
	{$ENDC}

{
 *  NChar2Pixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NChar2Pixel(textBuf: Ptr; textLength: LONGINT; slop: Fixed; offset: LONGINT; direction: INTEGER; styleRunPosition: JustStyleCode; numer: Point; denom: Point): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $821C, $0030, $A8B5;
	{$ENDC}

{
 *  NDrawJust()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NDrawJust(textPtr: Ptr; textLength: LONGINT; slop: Fixed; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8016, $0032, $A8B5;
	{$ENDC}

{
 *  NMeasureJust()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NMeasureJust(textPtr: Ptr; textLength: LONGINT; slop: Fixed; charLocs: Ptr; styleRunPosition: JustStyleCode; numer: Point; denom: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $801A, $0034, $A8B5;
	{$ENDC}

{
 *  NPortionText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NPortionText(textPtr: Ptr; textLen: LONGINT; styleRunPosition: JustStyleCode; numer: Point; denom: Point): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8412, $0036, $A8B5;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickdrawTextIncludes}

{$ENDC} {__QUICKDRAWTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
