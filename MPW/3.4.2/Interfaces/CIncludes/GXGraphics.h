/*
 	File:		GXGraphics.h
 
 	Contains:	QuickDraw GX graphic routine interfaces.
 
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

#ifndef __GXGRAPHICS__
#define __GXGRAPHICS__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __GXERRORS__
#include <GXErrors.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <GXTypes.h>										*/
/*		#include <GXMath.h>										*/
/*			#include <FixMath.h>								*/

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif

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
 
#define graphicsRoutinesIncludes
/* old header = graphics routines */
 
extern gxGraphicsClient GXNewGraphicsClient(void *memoryStart, long memoryLength, gxClientAttribute attributes)
 THREEWORDINLINE(0x303C, 0x59, 0xA832);
extern gxGraphicsClient GXGetGraphicsClient(void)
 THREEWORDINLINE(0x303C, 0x5a, 0xA832);
extern void GXSetGraphicsClient(gxGraphicsClient client)
 THREEWORDINLINE(0x303C, 0x5b, 0xA832);
extern void GXDisposeGraphicsClient(gxGraphicsClient client)
 THREEWORDINLINE(0x303C, 0x5c, 0xA832);
/*returns the count */
extern long GXGetGraphicsClients(long index, long count, gxGraphicsClient clients[])
 THREEWORDINLINE(0x303C, 0x5e, 0xA832);
extern void GXEnterGraphics(void)
 THREEWORDINLINE(0x303C, 0x5f, 0xA832);
extern void GXExitGraphics(void)
 THREEWORDINLINE(0x303C, 0x60, 0xA832);
extern gxGraphicsError GXGetGraphicsError(gxGraphicsError *stickyError)
 THREEWORDINLINE(0x303C, 0x61, 0xA832);
extern gxGraphicsNotice GXGetGraphicsNotice(gxGraphicsNotice *stickyNotice)
 THREEWORDINLINE(0x303C, 0x62, 0xA832);
extern gxGraphicsWarning GXGetGraphicsWarning(gxGraphicsWarning *stickyWarning)
 THREEWORDINLINE(0x303C, 0x63, 0xA832);
extern void GXPostGraphicsError(gxGraphicsError error)
 THREEWORDINLINE(0x303C, 0x64, 0xA832);
extern void GXPostGraphicsWarning(gxGraphicsWarning warning)
 THREEWORDINLINE(0x303C, 0x66, 0xA832);
extern gxUserErrorFunction GXGetUserGraphicsError(long *reference)
 THREEWORDINLINE(0x303C, 0x67, 0xA832);
extern gxUserNoticeFunction GXGetUserGraphicsNotice(long *reference)
 THREEWORDINLINE(0x303C, 0x68, 0xA832);
extern gxUserWarningFunction GXGetUserGraphicsWarning(long *reference)
 THREEWORDINLINE(0x303C, 0x69, 0xA832);
extern void GXSetUserGraphicsError(gxUserErrorFunction userFunction, long reference)
 THREEWORDINLINE(0x303C, 0x6a, 0xA832);
extern void GXSetUserGraphicsNotice(gxUserNoticeFunction userFunction, long reference)
 THREEWORDINLINE(0x303C, 0x6b, 0xA832);
extern void GXSetUserGraphicsWarning(gxUserWarningFunction userFunction, long reference)
 THREEWORDINLINE(0x303C, 0x6c, 0xA832);
extern void GXIgnoreGraphicsWarning(gxGraphicsWarning warning)
 THREEWORDINLINE(0x303C, 0x6f, 0xA832);
extern void GXPopGraphicsWarning(void)
 THREEWORDINLINE(0x303C, 0x70, 0xA832);
extern gxShape GXNewShapeVector(gxShapeType aType, const Fixed vector[])
 THREEWORDINLINE(0x303C, 0x71, 0xA832);
extern void GXSetShapeVector(gxShape target, const Fixed vector[])
 THREEWORDINLINE(0x303C, 0x72, 0xA832);
extern gxShape GXNewBitmap(const gxBitmap *data, const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x73, 0xA832);
extern gxShape GXNewCurve(const gxCurve *data)
 THREEWORDINLINE(0x303C, 0x74, 0xA832);
extern gxShape GXNewGlyphs(long charCount, const unsigned char text[], const gxPoint positions[], const long advance[], const gxPoint tangents[], const short styleRuns[], const gxStyle glyphStyles[])
 THREEWORDINLINE(0x303C, 0x75, 0xA832);
extern gxShape GXNewLine(const gxLine *data)
 THREEWORDINLINE(0x303C, 0x76, 0xA832);
extern gxShape GXNewPaths(const gxPaths *data)
 THREEWORDINLINE(0x303C, 0x77, 0xA832);
extern gxShape GXNewPicture(long count, const gxShape shapes[], const gxStyle styles[], const gxInk inks[], const gxTransform transforms[])
 THREEWORDINLINE(0x303C, 0x78, 0xA832);
extern gxShape GXNewPoint(const gxPoint *data)
 THREEWORDINLINE(0x303C, 0x79, 0xA832);
extern gxShape GXNewPolygons(const gxPolygons *data)
 THREEWORDINLINE(0x303C, 0x7a, 0xA832);
extern gxShape GXNewRectangle(const gxRectangle *data)
 THREEWORDINLINE(0x303C, 0x7b, 0xA832);
extern gxShape GXNewText(long charCount, const unsigned char text[], const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x7c, 0xA832);
extern gxBitmap *GXGetBitmap(gxShape source, gxBitmap *data, gxPoint *position)
 THREEWORDINLINE(0x303C, 0x7d, 0xA832);
extern gxCurve *GXGetCurve(gxShape source, gxCurve *data)
 THREEWORDINLINE(0x303C, 0x7e, 0xA832);
/* returns byte length of glyphs */
extern long GXGetGlyphs(gxShape source, long *charCount, unsigned char text[], gxPoint positions[], long advance[], gxPoint tangents[], long *runCount, short styleRuns[], gxStyle glyphStyles[])
 THREEWORDINLINE(0x303C, 0x7f, 0xA832);
extern gxLine *GXGetLine(gxShape source, gxLine *data)
 THREEWORDINLINE(0x303C, 0x80, 0xA832);
/* returns byte length */
extern long GXGetPaths(gxShape source, gxPaths *data)
 THREEWORDINLINE(0x303C, 0x81, 0xA832);
/* returns count */
extern long GXGetPicture(gxShape source, gxShape shapes[], gxStyle styles[], gxInk inks[], gxTransform transforms[])
 THREEWORDINLINE(0x303C, 0x82, 0xA832);
extern gxPoint *GXGetPoint(gxShape source, gxPoint *data)
 THREEWORDINLINE(0x303C, 0x83, 0xA832);
/* returns byte length */
extern long GXGetPolygons(gxShape source, gxPolygons *data)
 THREEWORDINLINE(0x303C, 0x84, 0xA832);
extern gxRectangle *GXGetRectangle(gxShape source, gxRectangle *data)
 THREEWORDINLINE(0x303C, 0x85, 0xA832);
/* returns byte length */
extern long GXGetText(gxShape source, long *charCount, unsigned char text[], gxPoint *position)
 THREEWORDINLINE(0x303C, 0x86, 0xA832);
extern void GXSetBitmap(gxShape target, const gxBitmap *data, const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x87, 0xA832);
extern void GXSetCurve(gxShape target, const gxCurve *data)
 THREEWORDINLINE(0x303C, 0x88, 0xA832);
extern void GXSetGlyphs(gxShape target, long charCount, const unsigned char text[], const gxPoint positions[], const long advance[], const gxPoint tangents[], const short styleRuns[], const gxStyle glyphStyles[])
 THREEWORDINLINE(0x303C, 0x89, 0xA832);
extern void GXSetLine(gxShape target, const gxLine *data)
 THREEWORDINLINE(0x303C, 0x8a, 0xA832);
extern void GXSetPaths(gxShape target, const gxPaths *data)
 THREEWORDINLINE(0x303C, 0x8b, 0xA832);
extern void GXSetPicture(gxShape target, long count, const gxShape shapes[], const gxStyle styles[], const gxInk inks[], const gxTransform transforms[])
 THREEWORDINLINE(0x303C, 0x8c, 0xA832);
extern void GXSetPoint(gxShape target, const gxPoint *data)
 THREEWORDINLINE(0x303C, 0x8d, 0xA832);
extern void GXSetPolygons(gxShape target, const gxPolygons *data)
 THREEWORDINLINE(0x303C, 0x8e, 0xA832);
extern void GXSetRectangle(gxShape target, const gxRectangle *data)
 THREEWORDINLINE(0x303C, 0x8f, 0xA832);
extern void GXSetText(gxShape target, long charCount, const unsigned char text[], const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x90, 0xA832);
extern void GXDrawBitmap(const gxBitmap *data, const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x91, 0xA832);
extern void GXDrawCurve(const gxCurve *data)
 THREEWORDINLINE(0x303C, 0x92, 0xA832);
extern void GXDrawGlyphs(long charCount, const unsigned char text[], const gxPoint positions[], const long advance[], const gxPoint tangents[], const short styleRuns[], const gxStyle glyphStyles[])
 THREEWORDINLINE(0x303C, 0x93, 0xA832);
extern void GXDrawLine(const gxLine *data)
 THREEWORDINLINE(0x303C, 0x94, 0xA832);
extern void GXDrawPaths(const gxPaths *data, gxShapeFill fill)
 THREEWORDINLINE(0x303C, 0x95, 0xA832);
extern void GXDrawPicture(long count, const gxShape shapes[], const gxStyle styles[], const gxInk inks[], const gxTransform transforms[])
 THREEWORDINLINE(0x303C, 0x96, 0xA832);
extern void GXDrawPoint(const gxPoint *data)
 THREEWORDINLINE(0x303C, 0x97, 0xA832);
extern void GXDrawPolygons(const gxPolygons *data, gxShapeFill fill)
 THREEWORDINLINE(0x303C, 0x98, 0xA832);
extern void GXDrawRectangle(const gxRectangle *data, gxShapeFill fill)
 THREEWORDINLINE(0x303C, 0x99, 0xA832);
extern void GXDrawText(long charCount, const unsigned char text[], const gxPoint *position)
 THREEWORDINLINE(0x303C, 0x9a, 0xA832);
extern gxColorProfile GXNewColorProfile(long size, void *colorProfileData)
 THREEWORDINLINE(0x303C, 0x9b, 0xA832);
extern gxColorSet GXNewColorSet(gxColorSpace space, long count, const gxSetColor colors[])
 THREEWORDINLINE(0x303C, 0x9c, 0xA832);
extern gxInk GXNewInk(void)
 THREEWORDINLINE(0x303C, 0x9d, 0xA832);
extern gxShape GXNewShape(gxShapeType aType)
 THREEWORDINLINE(0x303C, 0x9e, 0xA832);
extern gxStyle GXNewStyle(void)
 THREEWORDINLINE(0x303C, 0x9f, 0xA832);
extern gxTag GXNewTag(long tagType, long length, const void *data)
 THREEWORDINLINE(0x303C, 0xa0, 0xA832);
extern gxTransform GXNewTransform(void)
 THREEWORDINLINE(0x303C, 0xa1, 0xA832);
extern gxViewDevice GXNewViewDevice(gxViewGroup group, gxShape bitmapShape)
 THREEWORDINLINE(0x303C, 0xa2, 0xA832);
extern gxViewGroup GXNewViewGroup(void)
 THREEWORDINLINE(0x303C, 0xa3, 0xA832);
extern gxViewPort GXNewViewPort(gxViewGroup group)
 THREEWORDINLINE(0x303C, 0xa4, 0xA832);
extern void GXDisposeColorProfile(gxColorProfile target)
 THREEWORDINLINE(0x303C, 0xa5, 0xA832);
extern void GXDisposeColorSet(gxColorSet target)
 THREEWORDINLINE(0x303C, 0xa6, 0xA832);
extern void GXDisposeInk(gxInk target)
 THREEWORDINLINE(0x303C, 0xa7, 0xA832);
extern void GXDisposeShape(gxShape target)
 THREEWORDINLINE(0x303C, 0xa8, 0xA832);
extern void GXDisposeStyle(gxStyle target)
 THREEWORDINLINE(0x303C, 0xa9, 0xA832);
extern void GXDisposeTag(gxTag target)
 THREEWORDINLINE(0x303C, 0xaa, 0xA832);
extern void GXDisposeTransform(gxTransform target)
 THREEWORDINLINE(0x303C, 0xab, 0xA832);
extern void GXDisposeViewDevice(gxViewDevice target)
 THREEWORDINLINE(0x303C, 0xac, 0xA832);
extern void GXDisposeViewGroup(gxViewGroup target)
 THREEWORDINLINE(0x303C, 0xad, 0xA832);
extern void GXDisposeViewPort(gxViewPort target)
 THREEWORDINLINE(0x303C, 0xae, 0xA832);
extern gxColorProfile GXCloneColorProfile(gxColorProfile source)
 THREEWORDINLINE(0x303C, 0xaf, 0xA832);
extern gxColorSet GXCloneColorSet(gxColorSet source)
 THREEWORDINLINE(0x303C, 0xb0, 0xA832);
extern gxInk GXCloneInk(gxInk source)
 THREEWORDINLINE(0x303C, 0xb1, 0xA832);
extern gxShape GXCloneShape(gxShape source)
 THREEWORDINLINE(0x303C, 0xb2, 0xA832);
extern gxStyle GXCloneStyle(gxStyle source)
 THREEWORDINLINE(0x303C, 0xb3, 0xA832);
extern gxTag GXCloneTag(gxTag source)
 THREEWORDINLINE(0x303C, 0xb4, 0xA832);
extern gxTransform GXCloneTransform(gxTransform source)
 THREEWORDINLINE(0x303C, 0xb5, 0xA832);
extern gxColorProfile GXCopyToColorProfile(gxColorProfile target, gxColorProfile source)
 THREEWORDINLINE(0x303C, 0xb6, 0xA832);
extern gxColorSet GXCopyToColorSet(gxColorSet target, gxColorSet source)
 THREEWORDINLINE(0x303C, 0xb7, 0xA832);
extern gxInk GXCopyToInk(gxInk target, gxInk source)
 THREEWORDINLINE(0x303C, 0xb8, 0xA832);
extern gxShape GXCopyToShape(gxShape target, gxShape source)
 THREEWORDINLINE(0x303C, 0xb9, 0xA832);
extern gxStyle GXCopyToStyle(gxStyle target, gxStyle source)
 THREEWORDINLINE(0x303C, 0xba, 0xA832);
extern gxTag GXCopyToTag(gxTag target, gxTag source)
 THREEWORDINLINE(0x303C, 0xbb, 0xA832);
extern gxTransform GXCopyToTransform(gxTransform target, gxTransform source)
 THREEWORDINLINE(0x303C, 0xbc, 0xA832);
extern gxViewDevice GXCopyToViewDevice(gxViewDevice target, gxViewDevice source)
 THREEWORDINLINE(0x303C, 0xbd, 0xA832);
extern gxViewPort GXCopyToViewPort(gxViewPort target, gxViewPort source)
 THREEWORDINLINE(0x303C, 0xbe, 0xA832);
extern Boolean GXEqualColorProfile(gxColorProfile one, gxColorProfile two)
 THREEWORDINLINE(0x303C, 0xbf, 0xA832);
extern Boolean GXEqualColorSet(gxColorSet one, gxColorSet two)
 THREEWORDINLINE(0x303C, 0xc0, 0xA832);
extern Boolean GXEqualInk(gxInk one, gxInk two)
 THREEWORDINLINE(0x303C, 0xc1, 0xA832);
extern Boolean GXEqualShape(gxShape one, gxShape two)
 THREEWORDINLINE(0x303C, 0xc2, 0xA832);
extern Boolean GXEqualStyle(gxStyle one, gxStyle two)
 THREEWORDINLINE(0x303C, 0xc3, 0xA832);
extern Boolean GXEqualTag(gxTag one, gxTag two)
 THREEWORDINLINE(0x303C, 0xc4, 0xA832);
extern Boolean GXEqualTransform(gxTransform one, gxTransform two)
 THREEWORDINLINE(0x303C, 0xc5, 0xA832);
extern Boolean GXEqualViewDevice(gxViewDevice one, gxViewDevice two)
 THREEWORDINLINE(0x303C, 0xc6, 0xA832);
extern Boolean GXEqualViewPort(gxViewPort one, gxViewPort two)
 THREEWORDINLINE(0x303C, 0xc7, 0xA832);
extern void GXResetInk(gxInk target)
 THREEWORDINLINE(0x303C, 0xc8, 0xA832);
extern void GXResetShape(gxShape target)
 THREEWORDINLINE(0x303C, 0xc9, 0xA832);
extern void GXResetStyle(gxStyle target)
 THREEWORDINLINE(0x303C, 0xca, 0xA832);
extern void GXResetTransform(gxTransform target)
 THREEWORDINLINE(0x303C, 0xcb, 0xA832);
extern void GXLoadColorProfile(gxColorProfile target)
 THREEWORDINLINE(0x303C, 0xcc, 0xA832);
extern void GXLoadColorSet(gxColorSet target)
 THREEWORDINLINE(0x303C, 0xcd, 0xA832);
extern void GXLoadInk(gxInk target)
 THREEWORDINLINE(0x303C, 0xce, 0xA832);
extern void GXLoadShape(gxShape target)
 THREEWORDINLINE(0x303C, 0xcf, 0xA832);
extern void GXLoadStyle(gxStyle target)
 THREEWORDINLINE(0x303C, 0xd0, 0xA832);
extern void GXLoadTag(gxTag target)
 THREEWORDINLINE(0x303C, 0xd1, 0xA832);
extern void GXLoadTransform(gxTransform target)
 THREEWORDINLINE(0x303C, 0xd2, 0xA832);
extern void GXUnloadColorProfile(gxColorProfile target)
 THREEWORDINLINE(0x303C, 0xd3, 0xA832);
extern void GXUnloadColorSet(gxColorSet target)
 THREEWORDINLINE(0x303C, 0xd4, 0xA832);
extern void GXUnloadInk(gxInk target)
 THREEWORDINLINE(0x303C, 0xd5, 0xA832);
extern void GXUnloadShape(gxShape target)
 THREEWORDINLINE(0x303C, 0xd6, 0xA832);
extern void GXUnloadStyle(gxStyle target)
 THREEWORDINLINE(0x303C, 0xd7, 0xA832);
extern void GXUnloadTag(gxTag target)
 THREEWORDINLINE(0x303C, 0xd8, 0xA832);
extern void GXUnloadTransform(gxTransform target)
 THREEWORDINLINE(0x303C, 0xd9, 0xA832);
extern void GXCacheShape(gxShape source)
 THREEWORDINLINE(0x303C, 0xda, 0xA832);
extern gxShape GXCopyDeepToShape(gxShape target, gxShape source)
 THREEWORDINLINE(0x303C, 0xdb, 0xA832);
extern void GXDrawShape(gxShape source)
 THREEWORDINLINE(0x303C, 0xdc, 0xA832);
extern void GXDisposeShapeCache(gxShape target)
 THREEWORDINLINE(0x303C, 0xdd, 0xA832);
extern gxColorProfile GXGetDefaultColorProfile(void)
 THREEWORDINLINE(0x303C, 0xde, 0xA832);
extern gxShape GXGetDefaultShape(gxShapeType aType)
 THREEWORDINLINE(0x303C, 0xdf, 0xA832);
extern gxColorSet GXGetDefaultColorSet(long pixelDepth)
 THREEWORDINLINE(0x303C, 0xe0, 0xA832);
extern void GXSetDefaultShape(gxShape target)
 THREEWORDINLINE(0x303C, 0xe1, 0xA832);
extern void GXSetDefaultColorSet(gxColorSet target, long pixelDepth)
 THREEWORDINLINE(0x303C, 0xe2, 0xA832);
extern long GXGetTag(gxTag source, long *tagType, void *data)
 THREEWORDINLINE(0x303C, 0xe3, 0xA832);
extern void GXSetTag(gxTag target, long tagType, long length, const void *data)
 THREEWORDINLINE(0x303C, 0xe4, 0xA832);
extern gxRectangle *GXGetShapeBounds(gxShape source, long index, gxRectangle *bounds)
 THREEWORDINLINE(0x303C, 0xe5, 0xA832);
extern gxShapeFill GXGetShapeFill(gxShape source)
 THREEWORDINLINE(0x303C, 0xe6, 0xA832);
extern gxInk GXGetShapeInk(gxShape source)
 THREEWORDINLINE(0x303C, 0xe7, 0xA832);
extern long GXGetShapePixel(gxShape source, long x, long y, gxColor *data, long *index)
 THREEWORDINLINE(0x303C, 0xe8, 0xA832);
extern gxStyle GXGetShapeStyle(gxShape source)
 THREEWORDINLINE(0x303C, 0xe9, 0xA832);
extern gxTransform GXGetShapeTransform(gxShape source)
 THREEWORDINLINE(0x303C, 0xea, 0xA832);
extern gxShapeType GXGetShapeType(gxShape source)
 THREEWORDINLINE(0x303C, 0xeb, 0xA832);
extern gxRectangle *GXGetShapeTypographicBounds(gxShape source, gxRectangle *bounds)
 THREEWORDINLINE(0x303C, 0xec, 0xA832);
extern gxShape GXGetBitmapParts(gxShape source, const gxLongRectangle *bounds)
 THREEWORDINLINE(0x303C, 0xed, 0xA832);
extern void GXGetStyleFontMetrics(gxStyle sourceStyle, gxPoint *before, gxPoint *after, gxPoint *caretAngle, gxPoint *caretOffset)
 THREEWORDINLINE(0x303C, 0xee, 0xA832);
extern void GXGetShapeFontMetrics(gxShape source, gxPoint *before, gxPoint *after, gxPoint *caretAngle, gxPoint *caretOffset)
 THREEWORDINLINE(0x303C, 0xef, 0xA832);
extern void GXSetShapeBounds(gxShape target, const gxRectangle *newBounds)
 THREEWORDINLINE(0x303C, 0xf0, 0xA832);
extern void GXSetShapeFill(gxShape target, gxShapeFill newFill)
 THREEWORDINLINE(0x303C, 0xf1, 0xA832);
extern void GXSetShapeInk(gxShape target, gxInk newInk)
 THREEWORDINLINE(0x303C, 0xf2, 0xA832);
extern void GXSetShapePixel(gxShape target, long x, long y, const gxColor *newColor, long newIndex)
 THREEWORDINLINE(0x303C, 0xf3, 0xA832);
extern void GXSetShapeStyle(gxShape target, gxStyle newStyle)
 THREEWORDINLINE(0x303C, 0xf4, 0xA832);
extern void GXSetShapeTransform(gxShape target, gxTransform newTransform)
 THREEWORDINLINE(0x303C, 0xf5, 0xA832);
extern void GXSetShapeType(gxShape target, gxShapeType newType)
 THREEWORDINLINE(0x303C, 0xf6, 0xA832);
extern void GXSetBitmapParts(gxShape target, const gxLongRectangle *bounds, gxShape bitmapShape)
 THREEWORDINLINE(0x303C, 0xf7, 0xA832);
extern void GXSetShapeGeometry(gxShape target, gxShape geometry)
 THREEWORDINLINE(0x303C, 0xf8, 0xA832);
extern Fixed GXGetShapeCurveError(gxShape source)
 THREEWORDINLINE(0x303C, 0xf9, 0xA832);
extern gxDashRecord *GXGetShapeDash(gxShape source, gxDashRecord *dash)
 THREEWORDINLINE(0x303C, 0xfa, 0xA832);
extern gxCapRecord *GXGetShapeCap(gxShape source, gxCapRecord *cap)
 THREEWORDINLINE(0x303C, 0xfb, 0xA832);
/* returns the number of layers */
extern long GXGetShapeFace(gxShape source, gxTextFace *face)
 THREEWORDINLINE(0x303C, 0xfc, 0xA832);
extern gxFont GXGetShapeFont(gxShape source)
 THREEWORDINLINE(0x303C, 0xfd, 0xA832);
extern gxJoinRecord *GXGetShapeJoin(gxShape source, gxJoinRecord *join)
 THREEWORDINLINE(0x303C, 0xfe, 0xA832);
extern Fract GXGetShapeJustification(gxShape source)
 THREEWORDINLINE(0x303C, 0xff, 0xA832);
extern gxPatternRecord *GXGetShapePattern(gxShape source, gxPatternRecord *pattern)
 THREEWORDINLINE(0x303C, 0x100, 0xA832);
extern Fixed GXGetShapePen(gxShape source)
 THREEWORDINLINE(0x303C, 0x101, 0xA832);
extern gxFontPlatform GXGetShapeEncoding(gxShape source, gxFontScript *script, gxFontLanguage *language)
 THREEWORDINLINE(0x303C, 0x102, 0xA832);
extern Fixed GXGetShapeTextSize(gxShape source)
 THREEWORDINLINE(0x303C, 0x103, 0xA832);
extern long GXGetShapeFontVariations(gxShape source, gxFontVariation variations[])
 THREEWORDINLINE(0x303C, 0x104, 0xA832);
extern long GXGetShapeFontVariationSuite(gxShape source, gxFontVariation variations[])
 THREEWORDINLINE(0x303C, 0x105, 0xA832);
extern Fixed GXGetStyleCurveError(gxStyle source)
 THREEWORDINLINE(0x303C, 0x106, 0xA832);
extern gxDashRecord *GXGetStyleDash(gxStyle source, gxDashRecord *dash)
 THREEWORDINLINE(0x303C, 0x107, 0xA832);
extern gxCapRecord *GXGetStyleCap(gxStyle source, gxCapRecord *cap)
 THREEWORDINLINE(0x303C, 0x108, 0xA832);
/* returns the number of layers */
extern long GXGetStyleFace(gxStyle source, gxTextFace *face)
 THREEWORDINLINE(0x303C, 0x109, 0xA832);
extern gxFont GXGetStyleFont(gxStyle source)
 THREEWORDINLINE(0x303C, 0x10a, 0xA832);
extern gxJoinRecord *GXGetStyleJoin(gxStyle source, gxJoinRecord *join)
 THREEWORDINLINE(0x303C, 0x10b, 0xA832);
extern Fract GXGetStyleJustification(gxStyle source)
 THREEWORDINLINE(0x303C, 0x10c, 0xA832);
extern gxPatternRecord *GXGetStylePattern(gxStyle source, gxPatternRecord *pattern)
 THREEWORDINLINE(0x303C, 0x10d, 0xA832);
extern Fixed GXGetStylePen(gxStyle source)
 THREEWORDINLINE(0x303C, 0x10e, 0xA832);
extern gxFontPlatform GXGetStyleEncoding(gxStyle source, gxFontScript *script, gxFontLanguage *language)
 THREEWORDINLINE(0x303C, 0x10f, 0xA832);
extern Fixed GXGetStyleTextSize(gxStyle source)
 THREEWORDINLINE(0x303C, 0x110, 0xA832);
extern long GXGetStyleFontVariations(gxStyle source, gxFontVariation variations[])
 THREEWORDINLINE(0x303C, 0x111, 0xA832);
extern long GXGetStyleFontVariationSuite(gxStyle source, gxFontVariation variations[])
 THREEWORDINLINE(0x303C, 0x112, 0xA832);
extern void GXSetShapeCurveError(gxShape target, Fixed error)
 THREEWORDINLINE(0x303C, 0x113, 0xA832);
extern void GXSetShapeDash(gxShape target, const gxDashRecord *dash)
 THREEWORDINLINE(0x303C, 0x114, 0xA832);
extern void GXSetShapeCap(gxShape target, const gxCapRecord *cap)
 THREEWORDINLINE(0x303C, 0x115, 0xA832);
extern void GXSetShapeFace(gxShape target, const gxTextFace *face)
 THREEWORDINLINE(0x303C, 0x116, 0xA832);
extern void GXSetShapeFont(gxShape target, gxFont aFont)
 THREEWORDINLINE(0x303C, 0x117, 0xA832);
extern void GXSetShapeJoin(gxShape target, const gxJoinRecord *join)
 THREEWORDINLINE(0x303C, 0x118, 0xA832);
extern void GXSetShapeJustification(gxShape target, Fract justify)
 THREEWORDINLINE(0x303C, 0x119, 0xA832);
extern void GXSetShapePattern(gxShape target, const gxPatternRecord *pattern)
 THREEWORDINLINE(0x303C, 0x11a, 0xA832);
extern void GXSetShapePen(gxShape target, Fixed pen)
 THREEWORDINLINE(0x303C, 0x11b, 0xA832);
extern void GXSetShapeEncoding(gxShape target, gxFontPlatform platform, gxFontScript script, gxFontLanguage language)
 THREEWORDINLINE(0x303C, 0x11c, 0xA832);
extern void GXSetShapeTextSize(gxShape target, Fixed size)
 THREEWORDINLINE(0x303C, 0x11d, 0xA832);
extern void GXSetShapeFontVariations(gxShape target, long count, const gxFontVariation variations[])
 THREEWORDINLINE(0x303C, 0x11e, 0xA832);
extern void GXSetStyleCurveError(gxStyle target, Fixed error)
 THREEWORDINLINE(0x303C, 0x11f, 0xA832);
extern void GXSetStyleDash(gxStyle target, const gxDashRecord *dash)
 THREEWORDINLINE(0x303C, 0x120, 0xA832);
extern void GXSetStyleCap(gxStyle target, const gxCapRecord *cap)
 THREEWORDINLINE(0x303C, 0x121, 0xA832);
extern void GXSetStyleFace(gxStyle target, const gxTextFace *face)
 THREEWORDINLINE(0x303C, 0x122, 0xA832);
extern void GXSetStyleFont(gxStyle target, gxFont aFont)
 THREEWORDINLINE(0x303C, 0x123, 0xA832);
extern void GXSetStyleJoin(gxStyle target, const gxJoinRecord *join)
 THREEWORDINLINE(0x303C, 0x124, 0xA832);
extern void GXSetStyleJustification(gxStyle target, Fract justify)
 THREEWORDINLINE(0x303C, 0x125, 0xA832);
extern void GXSetStylePattern(gxStyle target, const gxPatternRecord *pattern)
 THREEWORDINLINE(0x303C, 0x126, 0xA832);
extern void GXSetStylePen(gxStyle target, Fixed pen)
 THREEWORDINLINE(0x303C, 0x127, 0xA832);
extern void GXSetStyleEncoding(gxStyle target, gxFontPlatform platform, gxFontScript script, gxFontLanguage language)
 THREEWORDINLINE(0x303C, 0x128, 0xA832);
extern void GXSetStyleTextSize(gxStyle target, Fixed size)
 THREEWORDINLINE(0x303C, 0x129, 0xA832);
extern void GXSetStyleFontVariations(gxStyle target, long count, const gxFontVariation variations[])
 THREEWORDINLINE(0x303C, 0x12a, 0xA832);
extern gxColor *GXGetShapeColor(gxShape source, gxColor *data)
 THREEWORDINLINE(0x303C, 0x12b, 0xA832);
extern gxTransferMode *GXGetShapeTransfer(gxShape source, gxTransferMode *data)
 THREEWORDINLINE(0x303C, 0x12c, 0xA832);
extern gxColor *GXGetInkColor(gxInk source, gxColor *data)
 THREEWORDINLINE(0x303C, 0x12d, 0xA832);
extern gxTransferMode *GXGetInkTransfer(gxInk source, gxTransferMode *data)
 THREEWORDINLINE(0x303C, 0x12e, 0xA832);
extern void GXSetShapeColor(gxShape target, const gxColor *data)
 THREEWORDINLINE(0x303C, 0x12f, 0xA832);
extern void GXSetShapeTransfer(gxShape target, const gxTransferMode *data)
 THREEWORDINLINE(0x303C, 0x130, 0xA832);
extern void GXSetInkColor(gxInk target, const gxColor *data)
 THREEWORDINLINE(0x303C, 0x131, 0xA832);
extern void GXSetInkTransfer(gxInk target, const gxTransferMode *data)
 THREEWORDINLINE(0x303C, 0x132, 0xA832);
extern gxShape GXGetShapeClip(gxShape source)
 THREEWORDINLINE(0x303C, 0x133, 0xA832);
extern gxShapeType GXGetShapeClipType(gxShape source)
 THREEWORDINLINE(0x303C, 0x276, 0xA832);
extern gxMapping *GXGetShapeMapping(gxShape source, gxMapping *map)
 THREEWORDINLINE(0x303C, 0x134, 0xA832);
extern gxShapePart GXGetShapeHitTest(gxShape source, Fixed *tolerance)
 THREEWORDINLINE(0x303C, 0x135, 0xA832);
extern long GXGetShapeViewPorts(gxShape source, gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x136, 0xA832);
extern gxShape GXGetTransformClip(gxTransform source)
 THREEWORDINLINE(0x303C, 0x137, 0xA832);
extern gxShapeType GXGetTransformClipType(gxTransform source)
 THREEWORDINLINE(0x303C, 0x277, 0xA832);
extern gxMapping *GXGetTransformMapping(gxTransform source, gxMapping *map)
 THREEWORDINLINE(0x303C, 0x138, 0xA832);
extern gxShapePart GXGetTransformHitTest(gxTransform source, Fixed *tolerance)
 THREEWORDINLINE(0x303C, 0x139, 0xA832);
extern long GXGetTransformViewPorts(gxTransform source, gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x13a, 0xA832);
extern void GXSetShapeClip(gxShape target, gxShape clip)
 THREEWORDINLINE(0x303C, 0x13b, 0xA832);
extern void GXSetShapeMapping(gxShape target, const gxMapping *map)
 THREEWORDINLINE(0x303C, 0x13c, 0xA832);
extern void GXSetShapeHitTest(gxShape target, gxShapePart mask, Fixed tolerance)
 THREEWORDINLINE(0x303C, 0x13d, 0xA832);
extern void GXSetShapeViewPorts(gxShape target, long count, const gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x13e, 0xA832);
extern void GXSetTransformClip(gxTransform target, gxShape clip)
 THREEWORDINLINE(0x303C, 0x13f, 0xA832);
extern void GXSetTransformMapping(gxTransform target, const gxMapping *map)
 THREEWORDINLINE(0x303C, 0x140, 0xA832);
extern void GXSetTransformHitTest(gxTransform target, gxShapePart mask, Fixed tolerance)
 THREEWORDINLINE(0x303C, 0x141, 0xA832);
extern void GXSetTransformViewPorts(gxTransform target, long count, const gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x142, 0xA832);
extern long GXGetColorSet(gxColorSet source, gxColorSpace *space, gxSetColor colors[])
 THREEWORDINLINE(0x303C, 0x143, 0xA832);
extern long GXGetColorProfile(gxColorProfile source, void *colorProfileData)
 THREEWORDINLINE(0x303C, 0x144, 0xA832);
extern void GXSetColorSet(gxColorSet target, gxColorSpace space, long count, const gxSetColor colors[])
 THREEWORDINLINE(0x303C, 0x145, 0xA832);
extern void GXSetColorProfile(gxColorProfile target, long size, void *colorProfileData)
 THREEWORDINLINE(0x303C, 0x146, 0xA832);
extern gxShape GXGetViewDeviceBitmap(gxViewDevice source)
 THREEWORDINLINE(0x303C, 0x147, 0xA832);
extern gxShape GXGetViewDeviceClip(gxViewDevice source)
 THREEWORDINLINE(0x303C, 0x148, 0xA832);
extern gxMapping *GXGetViewDeviceMapping(gxViewDevice source, gxMapping *map)
 THREEWORDINLINE(0x303C, 0x149, 0xA832);
extern gxViewGroup GXGetViewDeviceViewGroup(gxViewDevice source)
 THREEWORDINLINE(0x303C, 0x14a, 0xA832);
extern void GXSetViewDeviceBitmap(gxViewDevice target, gxShape bitmapShape)
 THREEWORDINLINE(0x303C, 0x14b, 0xA832);
extern void GXSetViewDeviceClip(gxViewDevice target, gxShape clip)
 THREEWORDINLINE(0x303C, 0x14c, 0xA832);
extern void GXSetViewDeviceMapping(gxViewDevice target, const gxMapping *map)
 THREEWORDINLINE(0x303C, 0x14d, 0xA832);
extern void GXSetViewDeviceViewGroup(gxViewDevice target, gxViewGroup group)
 THREEWORDINLINE(0x303C, 0x14e, 0xA832);
extern long GXGetViewPortChildren(gxViewPort source, gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x14f, 0xA832);
extern gxShape GXGetViewPortClip(gxViewPort source)
 THREEWORDINLINE(0x303C, 0x150, 0xA832);
extern long GXGetViewPortDither(gxViewPort source)
 THREEWORDINLINE(0x303C, 0x151, 0xA832);
extern Boolean GXGetViewPortHalftone(gxViewPort source, gxHalftone *data)
 THREEWORDINLINE(0x303C, 0x152, 0xA832);
extern gxMapping *GXGetViewPortMapping(gxViewPort source, gxMapping *map)
 THREEWORDINLINE(0x303C, 0x153, 0xA832);
extern gxViewPort GXGetViewPortParent(gxViewPort source)
 THREEWORDINLINE(0x303C, 0x154, 0xA832);
extern gxViewGroup GXGetViewPortViewGroup(gxViewPort source)
 THREEWORDINLINE(0x303C, 0x155, 0xA832);
extern long GXGetViewPortHalftoneMatrix(gxViewPort source, gxViewDevice sourceDevice, gxHalftoneMatrix *theMatrix)
 THREEWORDINLINE(0x303C, 0x273, 0xA832);
extern void GXSetViewPortChildren(gxViewPort target, long count, const gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x156, 0xA832);
extern void GXSetViewPortClip(gxViewPort target, gxShape clip)
 THREEWORDINLINE(0x303C, 0x157, 0xA832);
extern void GXSetViewPortDither(gxViewPort target, long level)
 THREEWORDINLINE(0x303C, 0x158, 0xA832);
extern void GXSetViewPortHalftone(gxViewPort target, const gxHalftone *data)
 THREEWORDINLINE(0x303C, 0x159, 0xA832);
extern void GXSetViewPortMapping(gxViewPort target, const gxMapping *map)
 THREEWORDINLINE(0x303C, 0x15a, 0xA832);
extern void GXSetViewPortParent(gxViewPort target, gxViewPort parent)
 THREEWORDINLINE(0x303C, 0x15b, 0xA832);
extern void GXSetViewPortViewGroup(gxViewPort target, gxViewGroup group)
 THREEWORDINLINE(0x303C, 0x15c, 0xA832);
extern long GXGetColorProfileTags(gxColorProfile source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x15d, 0xA832);
extern long GXGetColorSetTags(gxColorSet source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x15e, 0xA832);
extern long GXGetInkTags(gxInk source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x15f, 0xA832);
extern long GXGetShapeTags(gxShape source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x160, 0xA832);
extern long GXGetStyleTags(gxStyle source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x161, 0xA832);
extern long GXGetTransformTags(gxTransform source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x162, 0xA832);
extern long GXGetViewDeviceTags(gxViewDevice source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x163, 0xA832);
extern long GXGetViewPortTags(gxViewPort source, long tagType, long index, long count, gxTag items[])
 THREEWORDINLINE(0x303C, 0x164, 0xA832);
extern void GXSetColorProfileTags(gxColorProfile target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x165, 0xA832);
extern void GXSetColorSetTags(gxColorSet target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x166, 0xA832);
extern void GXSetInkTags(gxInk target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x167, 0xA832);
extern void GXSetShapeTags(gxShape target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x168, 0xA832);
extern void GXSetStyleTags(gxStyle target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x169, 0xA832);
extern void GXSetTransformTags(gxTransform target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x16a, 0xA832);
extern void GXSetViewDeviceTags(gxViewDevice target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x16b, 0xA832);
extern void GXSetViewPortTags(gxViewPort target, long tagType, long index, long oldCount, long newCount, const gxTag items[])
 THREEWORDINLINE(0x303C, 0x16c, 0xA832);
extern gxInkAttribute GXGetInkAttributes(gxInk source)
 THREEWORDINLINE(0x303C, 0x16d, 0xA832);
extern gxShapeAttribute GXGetShapeAttributes(gxShape source)
 THREEWORDINLINE(0x303C, 0x16e, 0xA832);
extern gxInkAttribute GXGetShapeInkAttributes(gxShape source)
 THREEWORDINLINE(0x303C, 0x16f, 0xA832);
extern gxStyleAttribute GXGetShapeStyleAttributes(gxShape source)
 THREEWORDINLINE(0x303C, 0x170, 0xA832);
extern gxStyleAttribute GXGetStyleAttributes(gxStyle source)
 THREEWORDINLINE(0x303C, 0x171, 0xA832);
extern gxTextAttribute GXGetShapeTextAttributes(gxShape source)
 THREEWORDINLINE(0x303C, 0x172, 0xA832);
extern gxTextAttribute GXGetStyleTextAttributes(gxStyle source)
 THREEWORDINLINE(0x303C, 0x173, 0xA832);
extern gxDeviceAttribute GXGetViewDeviceAttributes(gxViewDevice source)
 THREEWORDINLINE(0x303C, 0x174, 0xA832);
extern gxPortAttribute GXGetViewPortAttributes(gxViewPort source)
 THREEWORDINLINE(0x303C, 0x175, 0xA832);
extern void GXSetInkAttributes(gxInk target, gxInkAttribute attributes)
 THREEWORDINLINE(0x303C, 0x176, 0xA832);
extern void GXSetShapeAttributes(gxShape target, gxShapeAttribute attributes)
 THREEWORDINLINE(0x303C, 0x177, 0xA832);
extern void GXSetShapeInkAttributes(gxShape target, gxInkAttribute attributes)
 THREEWORDINLINE(0x303C, 0x178, 0xA832);
extern void GXSetShapeStyleAttributes(gxShape target, gxStyleAttribute attributes)
 THREEWORDINLINE(0x303C, 0x179, 0xA832);
extern void GXSetStyleAttributes(gxStyle target, gxStyleAttribute attributes)
 THREEWORDINLINE(0x303C, 0x17a, 0xA832);
extern void GXSetShapeTextAttributes(gxShape target, gxTextAttribute attributes)
 THREEWORDINLINE(0x303C, 0x17b, 0xA832);
extern void GXSetStyleTextAttributes(gxStyle target, gxTextAttribute attributes)
 THREEWORDINLINE(0x303C, 0x17c, 0xA832);
extern void GXSetViewDeviceAttributes(gxViewDevice target, gxDeviceAttribute attributes)
 THREEWORDINLINE(0x303C, 0x17d, 0xA832);
extern void GXSetViewPortAttributes(gxViewPort target, gxPortAttribute attributes)
 THREEWORDINLINE(0x303C, 0x17e, 0xA832);
extern long GXGetColorProfileOwners(gxColorProfile source)
 THREEWORDINLINE(0x303C, 0x17f, 0xA832);
extern long GXGetColorSetOwners(gxColorSet source)
 THREEWORDINLINE(0x303C, 0x180, 0xA832);
extern long GXGetInkOwners(gxInk source)
 THREEWORDINLINE(0x303C, 0x181, 0xA832);
extern long GXGetShapeOwners(gxShape source)
 THREEWORDINLINE(0x303C, 0x182, 0xA832);
extern long GXGetStyleOwners(gxStyle source)
 THREEWORDINLINE(0x303C, 0x183, 0xA832);
extern long GXGetTagOwners(gxTag source)
 THREEWORDINLINE(0x303C, 0x184, 0xA832);
extern long GXGetTransformOwners(gxTransform source)
 THREEWORDINLINE(0x303C, 0x185, 0xA832);
extern void GXLockShape(gxShape target)
 THREEWORDINLINE(0x303C, 0x186, 0xA832);
extern void GXLockTag(gxTag target)
 THREEWORDINLINE(0x303C, 0x187, 0xA832);
extern void GXUnlockShape(gxShape target)
 THREEWORDINLINE(0x303C, 0x188, 0xA832);
extern void GXUnlockTag(gxTag target)
 THREEWORDINLINE(0x303C, 0x189, 0xA832);
extern void *GXGetShapeStructure(gxShape source, long *length)
 THREEWORDINLINE(0x303C, 0x18a, 0xA832);
extern void *GXGetTagStructure(gxTag source, long *length)
 THREEWORDINLINE(0x303C, 0x18b, 0xA832);
extern Fixed GXGetColorDistance(const gxColor *target, const gxColor *source)
 THREEWORDINLINE(0x303C, 0x18c, 0xA832);
extern gxPoint *GXShapeLengthToPoint(gxShape target, long index, Fixed length, gxPoint *location, gxPoint *tangent)
 THREEWORDINLINE(0x303C, 0x18d, 0xA832);
extern wide *GXGetShapeArea(gxShape source, long index, wide *area)
 THREEWORDINLINE(0x303C, 0x18e, 0xA832);
extern long GXGetShapeCacheSize(gxShape source)
 THREEWORDINLINE(0x303C, 0x18f, 0xA832);
extern gxPoint *GXGetShapeCenter(gxShape source, long index, gxPoint *center)
 THREEWORDINLINE(0x303C, 0x190, 0xA832);
extern gxContourDirection GXGetShapeDirection(gxShape source, long contour)
 THREEWORDINLINE(0x303C, 0x191, 0xA832);
extern long GXGetShapeIndex(gxShape source, long contour, long vector)
 THREEWORDINLINE(0x303C, 0x192, 0xA832);
extern wide *GXGetShapeLength(gxShape source, long index, wide *length)
 THREEWORDINLINE(0x303C, 0x193, 0xA832);
extern long GXGetShapeSize(gxShape source)
 THREEWORDINLINE(0x303C, 0x194, 0xA832);
extern long GXCountShapeContours(gxShape source)
 THREEWORDINLINE(0x303C, 0x195, 0xA832);
extern long GXCountShapePoints(gxShape source, long contour)
 THREEWORDINLINE(0x303C, 0x196, 0xA832);
/* returns the number of positions */
extern long GXGetShapeDashPositions(gxShape source, gxMapping dashMappings[])
 THREEWORDINLINE(0x303C, 0x197, 0xA832);
extern long GXGetShapeDeviceArea(gxShape source, gxViewPort port, gxViewDevice device)
 THREEWORDINLINE(0x303C, 0x198, 0xA832);
extern Boolean GXGetShapeDeviceBounds(gxShape source, gxViewPort port, gxViewDevice device, gxRectangle *bounds)
 THREEWORDINLINE(0x303C, 0x199, 0xA832);
extern gxColorSet GXGetShapeDeviceColors(gxShape source, gxViewPort port, gxViewDevice device, long *width)
 THREEWORDINLINE(0x303C, 0x19a, 0xA832);
extern Boolean GXGetShapeGlobalBounds(gxShape source, gxViewPort port, gxViewGroup group, gxRectangle *bounds)
 THREEWORDINLINE(0x303C, 0x19b, 0xA832);
extern long GXGetShapeGlobalViewDevices(gxShape source, gxViewPort port, gxViewDevice list[])
 THREEWORDINLINE(0x303C, 0x19c, 0xA832);
extern long GXGetShapeGlobalViewPorts(gxShape source, gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x19d, 0xA832);
extern gxRectangle *GXGetShapeLocalBounds(gxShape source, gxRectangle *bounds)
 THREEWORDINLINE(0x303C, 0x19e, 0xA832);
/* returns the number of positions */
extern long GXGetShapePatternPositions(gxShape source, gxPoint positions[])
 THREEWORDINLINE(0x303C, 0x19f, 0xA832);
extern void GXGetShapeLocalFontMetrics(gxShape sourceShape, gxPoint *before, gxPoint *after, gxPoint *caretAngle, gxPoint *caretOffset)
 THREEWORDINLINE(0x303C, 0x1a0, 0xA832);
extern void GXGetShapeDeviceFontMetrics(gxShape sourceShape, gxViewPort port, gxViewDevice device, gxPoint *before, gxPoint *after, gxPoint *caretAngle, gxPoint *caretOffset)
 THREEWORDINLINE(0x303C, 0x1a1, 0xA832);
extern long GXGetViewGroupViewDevices(gxViewGroup source, gxViewDevice list[])
 THREEWORDINLINE(0x303C, 0x1a2, 0xA832);
extern long GXGetViewGroupViewPorts(gxViewGroup source, gxViewPort list[])
 THREEWORDINLINE(0x303C, 0x1a3, 0xA832);
extern gxMapping *GXGetViewPortGlobalMapping(gxViewPort source, gxMapping *map)
 THREEWORDINLINE(0x303C, 0x1a4, 0xA832);
extern long GXGetViewPortViewDevices(gxViewPort source, gxViewDevice list[])
 THREEWORDINLINE(0x303C, 0x1a5, 0xA832);
extern gxShape GXHitTestPicture(gxShape target, const gxPoint *test, gxHitTestInfo *result, long level, long depth)
 THREEWORDINLINE(0x303C, 0x1a6, 0xA832);
extern Boolean GXIntersectRectangle(gxRectangle *target, const gxRectangle *source, const gxRectangle *operand)
 THREEWORDINLINE(0x303C, 0x1a7, 0xA832);
extern gxRectangle *GXUnionRectangle(gxRectangle *target, const gxRectangle *source, const gxRectangle *operand)
 THREEWORDINLINE(0x303C, 0x1a8, 0xA832);
extern Boolean GXTouchesRectanglePoint(const gxRectangle *target, const gxPoint *test)
 THREEWORDINLINE(0x303C, 0x1a9, 0xA832);
extern Boolean GXTouchesShape(gxShape target, gxShape test)
 THREEWORDINLINE(0x303C, 0x1aa, 0xA832);
extern Boolean GXTouchesBoundsShape(const gxRectangle *target, gxShape test)
 THREEWORDINLINE(0x303C, 0x1ab, 0xA832);
extern Boolean GXContainsRectangle(const gxRectangle *container, const gxRectangle *test)
 THREEWORDINLINE(0x303C, 0x1ac, 0xA832);
extern Boolean GXContainsShape(gxShape container, gxShape test)
 THREEWORDINLINE(0x303C, 0x1ad, 0xA832);
extern Boolean GXContainsBoundsShape(const gxRectangle *container, gxShape test, long index)
 THREEWORDINLINE(0x303C, 0x1ae, 0xA832);
extern gxColor *GXConvertColor(gxColor *target, gxColorSpace space, gxColorSet aSet, gxColorProfile profile)
 THREEWORDINLINE(0x303C, 0x1af, 0xA832);
extern gxColor *GXCombineColor(gxColor *target, gxInk operand)
 THREEWORDINLINE(0x303C, 0x1b0, 0xA832);
extern Boolean GXCheckColor(const gxColor *source, gxColorSpace space, gxColorSet aSet, gxColorProfile profile)
 THREEWORDINLINE(0x303C, 0x1b1, 0xA832);
extern gxShape GXCheckBitmapColor(gxShape source, const gxLongRectangle *area, gxColorSpace space, gxColorSet aSet, gxColorProfile profile)
 THREEWORDINLINE(0x303C, 0x1b2, 0xA832);
extern Fixed GXGetHalftoneDeviceAngle(gxViewDevice source, const gxHalftone *data)
 THREEWORDINLINE(0x303C, 0x1b3, 0xA832);
extern long GXGetColorSetParts(gxColorSet source, long index, long count, gxColorSpace *space, gxSetColor data[])
 THREEWORDINLINE(0x303C, 0x1b4, 0xA832);
/* returns the glyph count */
extern long GXGetGlyphParts(gxShape source, long index, long charCount, long *byteLength, unsigned char text[], gxPoint positions[], long advanceBits[], gxPoint tangents[], long *runCount, short styleRuns[], gxStyle styles[])
 THREEWORDINLINE(0x303C, 0x1b5, 0xA832);
extern long GXGetPathParts(gxShape source, long index, long count, gxPaths *data)
 THREEWORDINLINE(0x303C, 0x1b6, 0xA832);
extern long GXGetPictureParts(gxShape source, long index, long count, gxShape shapes[], gxStyle styles[], gxInk inks[], gxTransform transforms[])
 THREEWORDINLINE(0x303C, 0x1b7, 0xA832);
extern long GXGetPolygonParts(gxShape source, long index, long count, gxPolygons *data)
 THREEWORDINLINE(0x303C, 0x1b8, 0xA832);
extern gxShape GXGetShapeParts(gxShape source, long index, long count, gxShape destination)
 THREEWORDINLINE(0x303C, 0x1b9, 0xA832);
extern long GXGetTextParts(gxShape source, long index, long charCount, unsigned char text[])
 THREEWORDINLINE(0x303C, 0x1ba, 0xA832);
extern void GXSetColorSetParts(gxColorSet target, long index, long oldCount, long newCount, const gxSetColor data[])
 THREEWORDINLINE(0x303C, 0x1bb, 0xA832);
extern void GXSetGlyphParts(gxShape source, long index, long oldCharCount, long newCharCount, const unsigned char text[], const gxPoint positions[], const long advanceBits[], const gxPoint tangents[], const short styleRuns[], const gxStyle styles[])
 THREEWORDINLINE(0x303C, 0x1bc, 0xA832);
extern void GXSetPathParts(gxShape target, long index, long count, const gxPaths *data, gxEditShapeFlag flags)
 THREEWORDINLINE(0x303C, 0x1bd, 0xA832);
extern void GXSetPictureParts(gxShape target, long index, long oldCount, long newCount, const gxShape shapes[], const gxStyle styles[], const gxInk inks[], const gxTransform transforms[])
 THREEWORDINLINE(0x303C, 0x1be, 0xA832);
extern void GXSetPolygonParts(gxShape target, long index, long count, const gxPolygons *data, gxEditShapeFlag flags)
 THREEWORDINLINE(0x303C, 0x1bf, 0xA832);
extern void GXSetShapeParts(gxShape target, long index, long count, gxShape insert, gxEditShapeFlag flags)
 THREEWORDINLINE(0x303C, 0x1c0, 0xA832);
extern void GXSetTextParts(gxShape target, long index, long oldCharCount, long newCharCount, const unsigned char text[])
 THREEWORDINLINE(0x303C, 0x1c1, 0xA832);
extern long GXGetShapePoints(gxShape source, long index, long count, gxPoint data[])
 THREEWORDINLINE(0x303C, 0x1c2, 0xA832);
extern void GXSetShapePoints(gxShape target, long index, long count, const gxPoint data[])
 THREEWORDINLINE(0x303C, 0x1c3, 0xA832);
extern long GXGetGlyphPositions(gxShape source, long index, long charCount, long advance[], gxPoint positions[])
 THREEWORDINLINE(0x303C, 0x1c4, 0xA832);
extern long GXGetGlyphTangents(gxShape source, long index, long charCount, gxPoint tangents[])
 THREEWORDINLINE(0x303C, 0x1c5, 0xA832);
extern void GXSetGlyphPositions(gxShape target, long index, long charCount, const long advance[], const gxPoint positions[])
 THREEWORDINLINE(0x303C, 0x1c6, 0xA832);
extern void GXSetGlyphTangents(gxShape target, long index, long charCount, const gxPoint tangents[])
 THREEWORDINLINE(0x303C, 0x1c7, 0xA832);
extern long GXGetGlyphMetrics(gxShape source, gxPoint glyphOrigins[], gxRectangle boundingBoxes[], gxPoint sideBearings[])
 THREEWORDINLINE(0x303C, 0x1c8, 0xA832);
extern void GXDifferenceShape(gxShape target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1c9, 0xA832);
extern void GXExcludeShape(gxShape target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1ca, 0xA832);
extern void GXIntersectShape(gxShape target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1cb, 0xA832);
extern void GXMapShape(gxShape target, const gxMapping *map)
 THREEWORDINLINE(0x303C, 0x1cc, 0xA832);
extern void GXMoveShape(gxShape target, Fixed deltaX, Fixed deltaY)
 THREEWORDINLINE(0x303C, 0x1cd, 0xA832);
extern void GXMoveShapeTo(gxShape target, Fixed x, Fixed y)
 THREEWORDINLINE(0x303C, 0x1ce, 0xA832);
extern void GXReverseDifferenceShape(gxShape target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1cf, 0xA832);
extern void GXRotateShape(gxShape target, Fixed degrees, Fixed xOffset, Fixed yOffset)
 THREEWORDINLINE(0x303C, 0x1d0, 0xA832);
extern void GXScaleShape(gxShape target, Fixed hScale, Fixed vScale, Fixed xOffset, Fixed yOffset)
 THREEWORDINLINE(0x303C, 0x1d1, 0xA832);
extern void GXSkewShape(gxShape target, Fixed xSkew, Fixed ySkew, Fixed xOffset, Fixed yOffset)
 THREEWORDINLINE(0x303C, 0x1d2, 0xA832);
extern void GXUnionShape(gxShape target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1d3, 0xA832);
extern void GXDifferenceTransform(gxTransform target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1d4, 0xA832);
extern void GXExcludeTransform(gxTransform target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1d5, 0xA832);
extern void GXIntersectTransform(gxTransform target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1d6, 0xA832);
extern void GXMapTransform(gxTransform target, const gxMapping *map)
 THREEWORDINLINE(0x303C, 0x1d7, 0xA832);
extern void GXMoveTransform(gxTransform target, Fixed deltaX, Fixed deltaY)
 THREEWORDINLINE(0x303C, 0x1d8, 0xA832);
extern void GXMoveTransformTo(gxTransform target, Fixed x, Fixed y)
 THREEWORDINLINE(0x303C, 0x1d9, 0xA832);
extern void GXReverseDifferenceTransform(gxTransform target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1da, 0xA832);
extern void GXRotateTransform(gxTransform target, Fixed degrees, Fixed xOffset, Fixed yOffset)
 THREEWORDINLINE(0x303C, 0x1db, 0xA832);
extern void GXScaleTransform(gxTransform target, Fixed hScale, Fixed vScale, Fixed xOffset, Fixed yOffset)
 THREEWORDINLINE(0x303C, 0x1dc, 0xA832);
extern void GXSkewTransform(gxTransform target, Fixed xSkew, Fixed ySkew, Fixed xOffset, Fixed yOffset)
 THREEWORDINLINE(0x303C, 0x1dd, 0xA832);
extern void GXUnionTransform(gxTransform target, gxShape operand)
 THREEWORDINLINE(0x303C, 0x1de, 0xA832);
extern void GXBreakShape(gxShape target, long index)
 THREEWORDINLINE(0x303C, 0x1df, 0xA832);
extern void GXChangedShape(gxShape target)
 THREEWORDINLINE(0x303C, 0x1e0, 0xA832);
extern gxShapePart GXHitTestShape(gxShape target, const gxPoint *test, gxHitTestInfo *result)
 THREEWORDINLINE(0x303C, 0x1e1, 0xA832);
extern gxShape GXHitTestDevice(gxShape target, gxViewPort port, gxViewDevice device, const gxPoint *test, const gxPoint *tolerance)
 THREEWORDINLINE(0x303C, 0x1e2, 0xA832);
extern void GXInsetShape(gxShape target, Fixed inset)
 THREEWORDINLINE(0x303C, 0x1e3, 0xA832);
extern void GXInvertShape(gxShape target)
 THREEWORDINLINE(0x303C, 0x1e4, 0xA832);
extern void GXPrimitiveShape(gxShape target)
 THREEWORDINLINE(0x303C, 0x1e5, 0xA832);
extern void GXReduceShape(gxShape target, long contour)
 THREEWORDINLINE(0x303C, 0x1e6, 0xA832);
extern void GXReverseShape(gxShape target, long contour)
 THREEWORDINLINE(0x303C, 0x1e7, 0xA832);
extern void GXSimplifyShape(gxShape target)
 THREEWORDINLINE(0x303C, 0x1e8, 0xA832);
extern void GXLockColorProfile(gxColorProfile source)
 THREEWORDINLINE(0x303C, 0x1e9, 0xA832);
extern void GXUnlockColorProfile(gxColorProfile source)
 THREEWORDINLINE(0x303C, 0x1ea, 0xA832);
extern void *GXGetColorProfileStructure(gxColorProfile source, long *length)
 THREEWORDINLINE(0x303C, 0x1eb, 0xA832);
extern void GXFlattenShape(gxShape source, gxFlattenFlag flags, gxSpoolBlock *block)
 THREEWORDINLINE(0x303C, 0x1ec, 0xA832);
extern gxShape GXUnflattenShape(gxSpoolBlock *block, long count, const gxViewPort portList[])
 THREEWORDINLINE(0x303C, 0x1ed, 0xA832);
extern void GXPostGraphicsNotice(gxGraphicsNotice notice)
 THREEWORDINLINE(0x303C, 0x65, 0xA832);
extern void GXIgnoreGraphicsNotice(gxGraphicsNotice notice)
 THREEWORDINLINE(0x303C, 0x6d, 0xA832);
extern void GXPopGraphicsNotice(void)
 THREEWORDINLINE(0x303C, 0x6e, 0xA832);
 
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

#endif /* __GXGRAPHICS__ */
