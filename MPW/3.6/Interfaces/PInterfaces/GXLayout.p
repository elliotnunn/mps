{
     File:       GXLayout.p
 
     Contains:   QuickDraw GX layout routine interfaces.
 
     Version:    Technology: Quickdraw GX 1.1
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

{$IFC CALL_NOT_IN_CARBON }
{
 *  GXNewLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewLayout(textRunCount: LONGINT; {CONST}VAR textRunLengths: INTEGER; {CONST}VAR text: UNIV Ptr; styleRunCount: LONGINT; {CONST}VAR styleRunLengths: INTEGER; {CONST}VAR styles: gxStyle; levelRunCount: LONGINT; {CONST}VAR levelRunLengths: INTEGER; {CONST}VAR levels: INTEGER; {CONST}VAR layoutOptions: gxLayoutOptions; {CONST}VAR position: gxPoint): gxShape; C;
{
 *  GXGetLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayout(layout: gxShape; text: UNIV Ptr; VAR styleRunCount: LONGINT; VAR styleRunLengths: INTEGER; VAR styles: gxStyle; VAR levelRunCount: LONGINT; VAR levelRunLengths: INTEGER; VAR levels: INTEGER; VAR layoutOptions: gxLayoutOptions; VAR position: gxPoint): LONGINT; C;
{
 *  GXSetLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetLayout(layout: gxShape; textRunCount: LONGINT; {CONST}VAR textRunLengths: INTEGER; {CONST}VAR text: UNIV Ptr; styleRunCount: LONGINT; {CONST}VAR styleRunLengths: INTEGER; {CONST}VAR styles: gxStyle; levelRunCount: LONGINT; {CONST}VAR levelRunLengths: INTEGER; {CONST}VAR levels: INTEGER; {CONST}VAR layoutOptions: gxLayoutOptions; {CONST}VAR position: gxPoint); C;
{
 *  GXDrawLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawLayout(textRunCount: LONGINT; {CONST}VAR textRunLengths: INTEGER; {CONST}VAR text: UNIV Ptr; styleRunCount: LONGINT; {CONST}VAR styleRunLengths: INTEGER; {CONST}VAR styles: gxStyle; levelRunCount: LONGINT; {CONST}VAR levelRunLengths: INTEGER; {CONST}VAR levels: INTEGER; {CONST}VAR layoutOptions: gxLayoutOptions; {CONST}VAR position: gxPoint); C;
{
 *  GXSetLayoutParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetLayoutParts(layout: gxShape; oldStartOffset: gxByteOffset; oldEndOffset: gxByteOffset; newTextRunCount: LONGINT; {CONST}VAR newTextRunLengths: INTEGER; {CONST}VAR newText: UNIV Ptr; newStyleRunCount: LONGINT; {CONST}VAR newStyleRunLengths: INTEGER; {CONST}VAR newStyles: gxStyle; newLevelRunCount: LONGINT; {CONST}VAR newLevelRunLengths: INTEGER; {CONST}VAR newLevels: INTEGER); C;
{
 *  GXSetLayoutShapeParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetLayoutShapeParts(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; insert: gxShape); C;
{
 *  GXGetLayoutParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutParts(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; text: UNIV Ptr; VAR styleRunCount: LONGINT; VAR styleRunLengths: INTEGER; VAR styles: gxStyle; VAR levelRunCount: LONGINT; VAR levelRunLengths: INTEGER; VAR levels: INTEGER): LONGINT; C;
{
 *  GXGetLayoutShapeParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutShapeParts(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; dest: gxShape): gxShape; C;
{
 *  GXGetLayoutGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutGlyphs(layout: gxShape; VAR glyphs: gxGlyphcode; VAR positions: gxPoint; VAR advance: LONGINT; VAR tangents: gxPoint; VAR runCount: LONGINT; VAR styleRuns: INTEGER; VAR glyphStyles: gxStyle): LONGINT; C;
{
 *  GXHitTestLayout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXHitTestLayout(layout: gxShape; {CONST}VAR hitDown: gxPoint; highlightType: gxHighlightType; VAR hitInfo: gxLayoutHitInfo; hitTrackingArea: gxShape): gxByteOffset; C;
{
 *  GXGetLayoutHighlight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutHighlight(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; highlightType: gxHighlightType; highlight: gxShape): gxShape; C;
{
 *  GXGetLayoutVisualHighlight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutVisualHighlight(layout: gxShape; startOffset: gxByteOffset; startLeadingEdge: LONGINT; endOffset: gxByteOffset; endLeadingEdge: LONGINT; highlightType: gxHighlightType; highlight: gxShape): gxShape; C;
{
 *  GXGetLayoutCaret()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutCaret(layout: gxShape; offset: gxByteOffset; highlightType: gxHighlightType; caretType: gxCaretType; caret: gxShape): gxShape; C;
{
 *  GXGetLayoutBreakOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutBreakOffset(layout: gxShape; startOffset: gxByteOffset; lineWidth: Fixed; hyphenationCount: LONGINT; {CONST}VAR hyphenationPoints: gxByteOffset; VAR startIsStaked: BOOLEAN; VAR priorStake: gxByteOffset; VAR nextStake: gxByteOffset): gxByteOffset; C;
{
 *  GXGetLayoutRangeWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutRangeWidth(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; supplementaryText: gxShape): Fixed; C;
{
 *  GXNewLayoutFromRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewLayoutFromRange(layout: gxShape; startOffset: gxByteOffset; endOffset: gxByteOffset; {CONST}VAR layoutOptions: gxLayoutOptions; supplementaryText: gxShape): gxShape; C;
{
 *  GXGetCaretAngleArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetCaretAngleArea(layout: gxShape; {CONST}VAR hitPoint: gxPoint; highlightType: gxHighlightType; caretArea: gxShape; VAR returnedRise: INTEGER; VAR returnedRun: INTEGER): gxShape; C;
{
 *  GXGetStyleBaselineDeltas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetStyleBaselineDeltas(baseStyle: gxStyle; baseType: gxBaselineType; VAR returnedDeltas: gxBaselineDeltas); C;
{
 *  GXGetRightVisualOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetRightVisualOffset(layout: gxShape; currentOffset: gxByteOffset): gxByteOffset; C;
{
 *  GXGetLeftVisualOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLeftVisualOffset(layout: gxShape; currentOffset: gxByteOffset): gxByteOffset; C;
{
 *  GXGetCompoundCharacterLimits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetCompoundCharacterLimits(layout: gxShape; trial: gxByteOffset; VAR minOffset: gxByteOffset; VAR maxOffset: gxByteOffset; VAR onBoundary: BOOLEAN); C;
{
 *  GXGetOffsetGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetOffsetGlyphs(layout: gxShape; trial: gxByteOffset; leadingEdge: LONGINT; VAR offsetState: gxLayoutOffsetState; VAR firstGlyph: UInt16; VAR secondGlyph: UInt16); C;
{
 *  GXGetGlyphOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetGlyphOffset(layout: gxShape; trial: LONGINT; onLeftTop: LONGINT; VAR offset: gxByteOffset; VAR leadingEdge: BOOLEAN; VAR wasRealCharacter: BOOLEAN); C;
{
 *  GXGetLayoutSpan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetLayoutSpan(layout: gxShape; VAR lineAscent: Fixed; VAR lineDescent: Fixed); C;
{
 *  GXSetLayoutSpan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetLayoutSpan(layout: gxShape; lineAscent: Fixed; lineDescent: Fixed); C;
{
 *  GXGetLayoutJustificationGap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLayoutJustificationGap(layout: gxShape): Fixed; C;
{
 *  GXGetLayoutJustificationFactors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetLayoutJustificationFactors(layout: gxShape; VAR constrainedFactors: Fixed; VAR unconstrainedFactors: Fixed); C;
{
 *  GXSetStyleRunControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleRunControls(target: gxStyle; {CONST}VAR runControls: gxRunControls); C;
{
 *  GXSetStyleRunPriorityJustOverride()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleRunPriorityJustOverride(target: gxStyle; {CONST}VAR priorityJustificationOverride: gxPriorityJustificationOverride); C;
{
 *  GXSetStyleRunGlyphJustOverrides()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleRunGlyphJustOverrides(target: gxStyle; count: LONGINT; {CONST}VAR glyphJustificationOverrides: gxGlyphJustificationOverride); C;
{
 *  GXSetStyleRunGlyphSubstitutions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleRunGlyphSubstitutions(target: gxStyle; count: LONGINT; {CONST}VAR glyphSubstitutions: gxGlyphSubstitution); C;
{
 *  GXSetStyleRunFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleRunFeatures(target: gxStyle; count: LONGINT; {CONST}VAR runFeatures: gxRunFeature); C;
{
 *  GXSetStyleRunKerningAdjustments()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleRunKerningAdjustments(target: gxStyle; count: LONGINT; {CONST}VAR kerningAdjustments: gxKerningAdjustment); C;
{
 *  GXSetShapeRunControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeRunControls(target: gxShape; {CONST}VAR runControls: gxRunControls); C;
{
 *  GXSetShapeRunPriorityJustOverride()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeRunPriorityJustOverride(target: gxShape; {CONST}VAR priorityJustificationOverride: gxPriorityJustificationOverride); C;
{
 *  GXSetShapeRunGlyphJustOverrides()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeRunGlyphJustOverrides(target: gxShape; count: LONGINT; {CONST}VAR glyphJustificationOverrides: gxGlyphJustificationOverride); C;
{
 *  GXSetShapeRunGlyphSubstitutions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeRunGlyphSubstitutions(target: gxShape; count: LONGINT; {CONST}VAR glyphSubstitutions: gxGlyphSubstitution); C;
{
 *  GXSetShapeRunFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeRunFeatures(target: gxShape; count: LONGINT; {CONST}VAR runFeatures: gxRunFeature); C;
{
 *  GXSetShapeRunKerningAdjustments()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeRunKerningAdjustments(target: gxShape; count: LONGINT; {CONST}VAR kerningAdjustments: gxKerningAdjustment); C;
{
 *  GXGetStyleRunControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleRunControls(source: gxStyle; VAR runControls: gxRunControls): LONGINT; C;
{
 *  GXGetStyleRunPriorityJustOverride()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleRunPriorityJustOverride(source: gxStyle; VAR priorityJustificationOverride: gxPriorityJustificationOverride): LONGINT; C;
{
 *  GXGetStyleRunGlyphJustOverrides()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleRunGlyphJustOverrides(source: gxStyle; VAR glyphJustificationOverrides: gxGlyphJustificationOverride): LONGINT; C;
{
 *  GXGetStyleRunGlyphSubstitutions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleRunGlyphSubstitutions(source: gxStyle; VAR glyphSubstitutions: gxGlyphSubstitution): LONGINT; C;
{
 *  GXGetStyleRunFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleRunFeatures(source: gxStyle; VAR runFeatures: gxRunFeature): LONGINT; C;
{
 *  GXGetStyleRunKerningAdjustments()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleRunKerningAdjustments(source: gxStyle; VAR kerningAdjustments: gxKerningAdjustment): LONGINT; C;
{
 *  GXGetShapeRunControls()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeRunControls(source: gxShape; VAR runControls: gxRunControls): LONGINT; C;
{
 *  GXGetShapeRunPriorityJustOverride()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeRunPriorityJustOverride(source: gxShape; VAR priorityJustificationOverride: gxPriorityJustificationOverride): LONGINT; C;
{
 *  GXGetShapeRunGlyphJustOverrides()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeRunGlyphJustOverrides(source: gxShape; VAR glyphJustificationOverrides: gxGlyphJustificationOverride): LONGINT; C;
{
 *  GXGetShapeRunGlyphSubstitutions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeRunGlyphSubstitutions(source: gxShape; VAR glyphSubstitutions: gxGlyphSubstitution): LONGINT; C;
{
 *  GXGetShapeRunFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeRunFeatures(source: gxShape; VAR runFeatures: gxRunFeature): LONGINT; C;
{
 *  GXGetShapeRunKerningAdjustments()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeRunKerningAdjustments(source: gxShape; VAR kerningAdjustments: gxKerningAdjustment): LONGINT; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXLayoutIncludes}

{$ENDC} {__GXLAYOUT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
