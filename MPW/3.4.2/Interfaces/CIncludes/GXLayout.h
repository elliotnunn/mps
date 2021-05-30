/*
 	File:		GXLayout.h
 
 	Contains:	QuickDraw GX layout routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __GXLAYOUT__
#define __GXLAYOUT__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif
/*	#include <Types.h>											*/
/*	#include <MixedMode.h>										*/
/*	#include <GXMath.h>											*/
/*		#include <FixMath.h>									*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if defined(__MWERKS__) && GENERATING68K
	#pragma push
	#pragma pointers_in_D0
#endif
 
#define layoutRoutinesIncludes
/* old header = layout routines */
 
extern gxShape GXNewLayout(long textRunCount, const short textRunLengths[], const void *text[], long styleRunCount, const short styleRunLengths[], const gxStyle styles[], long levelRunCount, const short levelRunLengths[], const short levels[], const gxLayoutOptions *layoutOptions, const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x0, 0xA832);
extern long GXGetLayout(gxShape layout, void *text, long *styleRunCount, short styleRunLengths[], gxStyle styles[], long *levelRunCount, short levelRunLengths[], short levels[], gxLayoutOptions *layoutOptions, gxPoint *position)
 THREEWORDINLINE(0x303C, 0x1, 0xA832);
extern void GXSetLayout(gxShape layout, long textRunCount, const short textRunLengths[], const void *text[], long styleRunCount, const short styleRunLengths[], const gxStyle styles[], long levelRunCount, const short levelRunLengths[], const short levels[], const gxLayoutOptions *layoutOptions, const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x2, 0xA832);
extern void GXDrawLayout(long textRunCount, const short textRunLengths[], const void *text[], long styleRunCount, const short styleRunLengths[], const gxStyle styles[], long levelRunCount, const short levelRunLengths[], const short levels[], const gxLayoutOptions *layoutOptions, const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x3, 0xA832);
extern void GXSetLayoutParts(gxShape layout, gxByteOffset oldStartOffset, gxByteOffset oldEndOffset, long newTextRunCount, const short newTextRunLengths[], const void *newText[], long newStyleRunCount, const short newStyleRunLengths[], const gxStyle newStyles[], long newLevelRunCount, const short newLevelRunLengths[], const short newLevels[])
 THREEWORDINLINE(0x303C, 0x4, 0xA832);
extern void GXSetLayoutShapeParts(gxShape layout, gxByteOffset startOffset, gxByteOffset endOffset, gxShape insert)
 THREEWORDINLINE(0x303C, 0x5, 0xA832);
extern long GXGetLayoutParts(gxShape layout, gxByteOffset startOffset, gxByteOffset endOffset, void *text, long *styleRunCount, short styleRunLengths[], gxStyle styles[], long *levelRunCount, short levelRunLengths[], short levels[])
 THREEWORDINLINE(0x303C, 0x6, 0xA832);
extern gxShape GXGetLayoutShapeParts(gxShape layout, gxByteOffset startOffset, gxByteOffset endOffset, gxShape dest)
 THREEWORDINLINE(0x303C, 0x7, 0xA832);
extern long GXGetLayoutGlyphs(gxShape layout, gxGlyphcode *glyphs, gxPoint positions[], long advance[], gxPoint tangents[], long *runCount, short styleRuns[], gxStyle glyphStyles[])
 THREEWORDINLINE(0x303C, 0x8, 0xA832);
extern gxByteOffset GXHitTestLayout(gxShape layout, const gxPoint *hitDown, gxHighlightType highlightType, gxLayoutHitInfo *hitInfo, gxShape hitTrackingArea)
 THREEWORDINLINE(0x303C, 0x9, 0xA832);
extern gxShape GXGetLayoutHighlight(gxShape layout, gxByteOffset startOffset, gxByteOffset endOffset, gxHighlightType highlightType, gxShape highlight)
 THREEWORDINLINE(0x303C, 0xa, 0xA832);
extern gxShape GXGetLayoutVisualHighlight(gxShape layout, gxByteOffset startOffset, long startLeadingEdge, gxByteOffset endOffset, long endLeadingEdge, gxHighlightType highlightType, gxShape highlight)
 THREEWORDINLINE(0x303C, 0xb, 0xA832);
extern gxShape GXGetLayoutCaret(gxShape layout, gxByteOffset offset, gxHighlightType highlightType, gxCaretType caretType, gxShape caret)
 THREEWORDINLINE(0x303C, 0xc, 0xA832);
extern gxByteOffset GXGetLayoutBreakOffset(gxShape layout, gxByteOffset startOffset, Fixed lineWidth, long hyphenationCount, const gxByteOffset hyphenationPoints[], Boolean *startIsStaked, gxByteOffset *priorStake, gxByteOffset *nextStake)
 THREEWORDINLINE(0x303C, 0xd, 0xA832);
extern Fixed GXGetLayoutRangeWidth(gxShape layout, gxByteOffset startOffset, gxByteOffset endOffset, gxShape supplementaryText)
 THREEWORDINLINE(0x303C, 0xe, 0xA832);
extern gxShape GXNewLayoutFromRange(gxShape layout, gxByteOffset startOffset, gxByteOffset endOffset, const gxLayoutOptions *layoutOptions, gxShape supplementaryText)
 THREEWORDINLINE(0x303C, 0xf, 0xA832);
extern gxShape GXGetCaretAngleArea(gxShape layout, const gxPoint *hitPoint, gxHighlightType highlightType, gxShape caretArea, short *returnedRise, short *returnedRun)
 THREEWORDINLINE(0x303C, 0x10, 0xA832);
extern void GXGetStyleBaselineDeltas(gxStyle baseStyle, gxBaselineType baseType, gxBaselineDeltas returnedDeltas)
 THREEWORDINLINE(0x303C, 0x11, 0xA832);
extern gxByteOffset GXGetRightVisualOffset(gxShape layout, gxByteOffset currentOffset)
 THREEWORDINLINE(0x303C, 0x12, 0xA832);
extern gxByteOffset GXGetLeftVisualOffset(gxShape layout, gxByteOffset currentOffset)
 THREEWORDINLINE(0x303C, 0x13, 0xA832);
extern void GXGetCompoundCharacterLimits(gxShape layout, gxByteOffset trial, gxByteOffset *minOffset, gxByteOffset *maxOffset, Boolean *onBoundary)
 THREEWORDINLINE(0x303C, 0x14, 0xA832);
extern void GXGetOffsetGlyphs(gxShape layout, gxByteOffset trial, long leadingEdge, gxLayoutOffsetState *offsetState, unsigned short *firstGlyph, unsigned short *secondGlyph)
 THREEWORDINLINE(0x303C, 0x15, 0xA832);
extern void GXGetGlyphOffset(gxShape layout, long trial, long onLeftTop, gxByteOffset *offset, Boolean *leadingEdge, Boolean *wasRealCharacter)
 THREEWORDINLINE(0x303C, 0x16, 0xA832);
extern void GXGetLayoutSpan(gxShape layout, Fixed *lineAscent, Fixed *lineDescent)
 THREEWORDINLINE(0x303C, 0x17, 0xA832);
extern void GXSetLayoutSpan(gxShape layout, Fixed lineAscent, Fixed lineDescent)
 THREEWORDINLINE(0x303C, 0x18, 0xA832);
extern Fixed GXGetLayoutJustificationGap(gxShape layout)
 THREEWORDINLINE(0x303C, 0x279, 0xA832);
extern void GXGetLayoutJustificationFactors(gxShape layout, Fixed constrainedFactors[], Fixed unconstrainedFactors[])
 THREEWORDINLINE(0x303C, 0x27A, 0xA832);
extern void GXSetStyleRunControls(gxStyle target, const gxRunControls *runControls)
 THREEWORDINLINE(0x303C, 0x19, 0xA832);
extern void GXSetStyleRunPriorityJustOverride(gxStyle target, const gxPriorityJustificationOverride *priorityJustificationOverride)
 THREEWORDINLINE(0x303C, 0x1a, 0xA832);
extern void GXSetStyleRunGlyphJustOverrides(gxStyle target, long count, const gxGlyphJustificationOverride glyphJustificationOverrides[])
 THREEWORDINLINE(0x303C, 0x1b, 0xA832);
extern void GXSetStyleRunGlyphSubstitutions(gxStyle target, long count, const gxGlyphSubstitution glyphSubstitutions[])
 THREEWORDINLINE(0x303C, 0x1c, 0xA832);
extern void GXSetStyleRunFeatures(gxStyle target, long count, const gxRunFeature runFeatures[])
 THREEWORDINLINE(0x303C, 0x1d, 0xA832);
extern void GXSetStyleRunKerningAdjustments(gxStyle target, long count, const gxKerningAdjustment kerningAdjustments[])
 THREEWORDINLINE(0x303C, 0x1e, 0xA832);
extern void GXSetShapeRunControls(gxShape target, const gxRunControls *runControls)
 THREEWORDINLINE(0x303C, 0x1f, 0xA832);
extern void GXSetShapeRunPriorityJustOverride(gxShape target, const gxPriorityJustificationOverride *priorityJustificationOverride)
 THREEWORDINLINE(0x303C, 0x20, 0xA832);
extern void GXSetShapeRunGlyphJustOverrides(gxShape target, long count, const gxGlyphJustificationOverride glyphJustificationOverrides[])
 THREEWORDINLINE(0x303C, 0x21, 0xA832);
extern void GXSetShapeRunGlyphSubstitutions(gxShape target, long count, const gxGlyphSubstitution glyphSubstitutions[])
 THREEWORDINLINE(0x303C, 0x22, 0xA832);
extern void GXSetShapeRunFeatures(gxShape target, long count, const gxRunFeature runFeatures[])
 THREEWORDINLINE(0x303C, 0x23, 0xA832);
extern void GXSetShapeRunKerningAdjustments(gxShape target, long count, const gxKerningAdjustment kerningAdjustments[])
 THREEWORDINLINE(0x303C, 0x24, 0xA832);
extern long GXGetStyleRunControls(gxStyle source, gxRunControls *runControls)
 THREEWORDINLINE(0x303C, 0x25, 0xA832);
extern long GXGetStyleRunPriorityJustOverride(gxStyle source, gxPriorityJustificationOverride *priorityJustificationOverride)
 THREEWORDINLINE(0x303C, 0x26, 0xA832);
extern long GXGetStyleRunGlyphJustOverrides(gxStyle source, gxGlyphJustificationOverride glyphJustificationOverrides[])
 THREEWORDINLINE(0x303C, 0x27, 0xA832);
extern long GXGetStyleRunGlyphSubstitutions(gxStyle source, gxGlyphSubstitution glyphSubstitutions[])
 THREEWORDINLINE(0x303C, 0x28, 0xA832);
extern long GXGetStyleRunFeatures(gxStyle source, gxRunFeature runFeatures[])
 THREEWORDINLINE(0x303C, 0x29, 0xA832);
extern long GXGetStyleRunKerningAdjustments(gxStyle source, gxKerningAdjustment kerningAdjustments[])
 THREEWORDINLINE(0x303C, 0x2a, 0xA832);
extern long GXGetShapeRunControls(gxShape source, gxRunControls *runControls)
 THREEWORDINLINE(0x303C, 0x2b, 0xA832);
extern long GXGetShapeRunPriorityJustOverride(gxShape source, gxPriorityJustificationOverride *priorityJustificationOverride)
 THREEWORDINLINE(0x303C, 0x2c, 0xA832);
extern long GXGetShapeRunGlyphJustOverrides(gxShape source, gxGlyphJustificationOverride glyphJustificationOverrides[])
 THREEWORDINLINE(0x303C, 0x2d, 0xA832);
extern long GXGetShapeRunGlyphSubstitutions(gxShape source, gxGlyphSubstitution glyphSubstitutions[])
 THREEWORDINLINE(0x303C, 0x2e, 0xA832);
extern long GXGetShapeRunFeatures(gxShape source, gxRunFeature runFeatures[])
 THREEWORDINLINE(0x303C, 0x2f, 0xA832);
extern long GXGetShapeRunKerningAdjustments(gxShape source, gxKerningAdjustment kerningAdjustments[])
 THREEWORDINLINE(0x303C, 0x30, 0xA832);
 
#if defined(__MWERKS__) && GENERATING68K
	#pragma pop
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __GXLAYOUT__ */
