{
 	File:		GXLayout.p
 
 	Contains:	QuickDraw GX layout routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXLayout;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXLAYOUT__}
{$SETC __GXLAYOUT__ := 1}

{$I+}
{$SETC GXLayoutIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


FUNCTION GXNewLayout(textRunCount: LONGINT; {CONST}VAR textRunLengths: INTEGER; {CONST}VAR text: UNIV Ptr; styleRunCount: LONGINT; {CONST}VAR styleRunLengths: INTEGER; {CONST}VAR styles: gxStyle; levelRunCount: LONGINT; {CONST}VAR levelRunLengths: INTEGER; {CONST}VAR levels: INTEGER; {CONST}VAR layoutOptions: gxLayoutOptions; {CONST}VAR position: gxPoint): gxShape; C;
FUNCTION GXGetLayout(layout: gxShape; text: UNIV Ptr; VAR styleRunCount: LONGINT; VAR styleRunLengths: INTEGER; VAR styles: gxStyle; VAR levelRunCount: LONGINT; VAR levelRunLengths: INTEGER; VAR levels: INTEGER; VAR layoutOptions: gxLayoutOptions; VAR position: gxPoint): LONGINT; C;
PROCEDURE GXSetLayout(layout: gxShape; textRunCount: LONGINT; {CONST}VAR textRunLengths: INTEGER; {CONST}VAR text: UNIV Ptr; styleRunCount: LONGINT; {CONST}VAR styleRunLengths: INTEGER; {CONST}VAR styles: gxStyle; levelRunCount: LONGINT; {CONST}VAR levelRunLengths: INTEGER; {CONST}VAR levels: INTEGER; {CONST}VAR layoutOptions: gxLayoutOptions; {CONST}VAR position: gxPoint); C;
PROCEDURE GXDrawLayout(textRunCount: LONGINT; {CONST}VAR textRunLengths: INTEGER; {CONST}VAR text: UNIV Ptr; styleRunCount: LONGINT; {CONST}VAR styleRunLengths: INTEGER; {CONST}VAR styles: gxStyle; levelRunCount: LONGINT; {CONST}VAR levelRunLengths: INTEGER; {CONST}VAR levels: INTEGER; {CONST}VAR layoutOptions: gxLayoutOptions; {CONST}VAR position: gxPoint); C;
PROCEDURE GXSetLayoutParts(layout: gxShape; oldStartOffset: gxByteOffset; oldEndOffset: gxByteOffset; newTextRunCount: LONGINT; {CONST}VAR newTextRunLengths: INTEGER; {CONST}VAR newText: UNIV Ptr; newStyleRunCount: LONGINT; {CONST}VAR newStyleRunLengths: INTEGER; {CONST}VAR newStyles: gxStyle; newLevelRunCount: LONGINT; {CONST}VAR newLevelRunLengths: INTEGER; {CONST}VAR newLevels: INTEGER); C;
PROCEDURE GXSetLayoutShapeParts(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; insert: gxShape); C;
FUNCTION GXGetLayoutParts(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; text: UNIV Ptr; VAR styleRunCount: LONGINT; VAR styleRunLengths: INTEGER; VAR styles: gxStyle; VAR levelRunCount: LONGINT; VAR levelRunLengths: INTEGER; VAR levels: INTEGER): LONGINT; C;
FUNCTION GXGetLayoutShapeParts(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; dest: gxShape): gxShape; C;
FUNCTION GXGetLayoutGlyphs(layout: gxShape; VAR glyphs: gxGlyphcode; VAR positions: gxPoint; VAR advance: LONGINT; VAR tangents: gxPoint; VAR runCount: LONGINT; VAR styleRuns: INTEGER; VAR glyphStyles: gxStyle): LONGINT; C;
FUNCTION GXHitTestLayout(layout: gxShape; {CONST}VAR hitDown: gxPoint; highlightType: gxHighlightType; VAR hitInfo: gxLayoutHitInfo; hitTrackingArea: gxShape): gxByteOffset; C;
FUNCTION GXGetLayoutHighlight(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; highlightType: gxHighlightType; highlight: gxShape): gxShape; C;
FUNCTION GXGetLayoutVisualHighlight(layout: gxShape; startOffset: gxByteOffset; startLeadingEdge: LONGINT; endOffset: gxByteOffset; endLeadingEdge: LONGINT; highlightType: gxHighlightType; highlight: gxShape): gxShape; C;
FUNCTION GXGetLayoutCaret(layout: gxShape; offset: gxByteOffset; highlightType: gxHighlightType; caretType: gxCaretType; caret: gxShape): gxShape; C;
FUNCTION GXGetLayoutBreakOffset(layout: gxShape; startOffset: gxByteOffset; lineWidth: Fixed; hyphenationCount: LONGINT; {CONST}VAR hyphenationPoints: gxByteOffset; VAR startIsStaked: BOOLEAN; VAR priorStake: gxByteOffset; VAR nextStake: gxByteOffset): gxByteOffset; C;
FUNCTION GXGetLayoutRangeWidth(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; supplementaryText: gxShape): Fixed; C;
FUNCTION GXNewLayoutFromRange(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; {CONST}VAR layoutOptions: gxLayoutOptions; supplementaryText: gxShape): gxShape; C;
FUNCTION GXGetCaretAngleArea(layout: gxShape; {CONST}VAR hitPoint: gxPoint; highlightType: gxHighlightType; caretArea: gxShape; VAR returnedRise: INTEGER; VAR returnedRun: INTEGER): gxShape; C;
PROCEDURE GXGetStyleBaselineDeltas(baseStyle: gxStyle; baseType: gxBaselineType; VAR returnedDeltas: gxBaselineDeltas); C;
FUNCTION GXGetRightVisualOffset(layout: gxShape; currentOffset: gxByteOffset): gxByteOffset; C;
FUNCTION GXGetLeftVisualOffset(layout: gxShape; currentOffset: gxByteOffset): gxByteOffset; C;
PROCEDURE GXGetCompoundCharacterLimits(layout: gxShape; trial: gxByteOffset; VAR minOffset: gxByteOffset; VAR maxOffset: gxByteOffset; VAR onBoundary: BOOLEAN); C;
PROCEDURE GXGetOffsetGlyphs(layout: gxShape; trial: gxByteOffset; leadingEdge: LONGINT; VAR offsetState: gxLayoutOffsetState; VAR firstGlyph: INTEGER; VAR secondGlyph: INTEGER); C;
PROCEDURE GXGetGlyphOffset(layout: gxShape; trial: LONGINT; onLeftTop: LONGINT; VAR offset: gxByteOffset; VAR leadingEdge: BOOLEAN; VAR wasRealCharacter: BOOLEAN); C;
PROCEDURE GXGetLayoutSpan(layout: gxShape; VAR lineAscent: Fixed; VAR lineDescent: Fixed); C;
PROCEDURE GXSetLayoutSpan(layout: gxShape; lineAscent: Fixed; lineDescent: Fixed); C;
FUNCTION GXGetLayoutJustificationGap(layout: gxShape): Fixed; C;
PROCEDURE GXGetLayoutJustificationFactors(layout: gxShape; VAR constrainedFactors: Fixed; VAR unconstrainedFactors: Fixed); C;
PROCEDURE GXSetStyleRunControls(target: gxStyle; {CONST}VAR runControls: gxRunControls); C;
PROCEDURE GXSetStyleRunPriorityJustOverride(target: gxStyle; {CONST}VAR priorityJustificationOverride: gxPriorityJustificationOverride); C;
PROCEDURE GXSetStyleRunGlyphJustOverrides(target: gxStyle; count: LONGINT; {CONST}VAR glyphJustificationOverrides: gxGlyphJustificationOverride); C;
PROCEDURE GXSetStyleRunGlyphSubstitutions(target: gxStyle; count: LONGINT; {CONST}VAR glyphSubstitutions: gxGlyphSubstitution); C;
PROCEDURE GXSetStyleRunFeatures(target: gxStyle; count: LONGINT; {CONST}VAR runFeatures: gxRunFeature); C;
PROCEDURE GXSetStyleRunKerningAdjustments(target: gxStyle; count: LONGINT; {CONST}VAR kerningAdjustments: gxKerningAdjustment); C;
PROCEDURE GXSetShapeRunControls(target: gxShape; {CONST}VAR runControls: gxRunControls); C;
PROCEDURE GXSetShapeRunPriorityJustOverride(target: gxShape; {CONST}VAR priorityJustificationOverride: gxPriorityJustificationOverride); C;
PROCEDURE GXSetShapeRunGlyphJustOverrides(target: gxShape; count: LONGINT; {CONST}VAR glyphJustificationOverrides: gxGlyphJustificationOverride); C;
PROCEDURE GXSetShapeRunGlyphSubstitutions(target: gxShape; count: LONGINT; {CONST}VAR glyphSubstitutions: gxGlyphSubstitution); C;
PROCEDURE GXSetShapeRunFeatures(target: gxShape; count: LONGINT; {CONST}VAR runFeatures: gxRunFeature); C;
PROCEDURE GXSetShapeRunKerningAdjustments(target: gxShape; count: LONGINT; {CONST}VAR kerningAdjustments: gxKerningAdjustment); C;
FUNCTION GXGetStyleRunControls(source: gxStyle; VAR runControls: gxRunControls): LONGINT; C;
FUNCTION GXGetStyleRunPriorityJustOverride(source: gxStyle; VAR priorityJustificationOverride: gxPriorityJustificationOverride): LONGINT; C;
FUNCTION GXGetStyleRunGlyphJustOverrides(source: gxStyle; VAR glyphJustificationOverrides: gxGlyphJustificationOverride): LONGINT; C;
FUNCTION GXGetStyleRunGlyphSubstitutions(source: gxStyle; VAR glyphSubstitutions: gxGlyphSubstitution): LONGINT; C;
FUNCTION GXGetStyleRunFeatures(source: gxStyle; VAR runFeatures: gxRunFeature): LONGINT; C;
FUNCTION GXGetStyleRunKerningAdjustments(source: gxStyle; VAR kerningAdjustments: gxKerningAdjustment): LONGINT; C;
FUNCTION GXGetShapeRunControls(source: gxShape; VAR runControls: gxRunControls): LONGINT; C;
FUNCTION GXGetShapeRunPriorityJustOverride(source: gxShape; VAR priorityJustificationOverride: gxPriorityJustificationOverride): LONGINT; C;
FUNCTION GXGetShapeRunGlyphJustOverrides(source: gxShape; VAR glyphJustificationOverrides: gxGlyphJustificationOverride): LONGINT; C;
FUNCTION GXGetShapeRunGlyphSubstitutions(source: gxShape; VAR glyphSubstitutions: gxGlyphSubstitution): LONGINT; C;
FUNCTION GXGetShapeRunFeatures(source: gxShape; VAR runFeatures: gxRunFeature): LONGINT; C;
FUNCTION GXGetShapeRunKerningAdjustments(source: gxShape; VAR kerningAdjustments: gxKerningAdjustment): LONGINT; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXLayoutIncludes}

{$ENDC} {__GXLAYOUT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
