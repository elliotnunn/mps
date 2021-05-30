/*
 	File:		GXEnvironment.h
 
 	Contains:	QuickDraw GX environment constants and interfaces
 
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

#ifndef __GXENVIRONMENT__
#define __GXENVIRONMENT__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif
/*	#include <Types.h>											*/

#ifndef __WINDOWS__
#include <Windows.h>
#endif
/*	#include <Memory.h>											*/
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Events.h>											*/
/*		#include <OSUtils.h>									*/
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif
/*	#include <GXMath.h>											*/
/*		#include <FixMath.h>									*/

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
#endif
/*	#include <Files.h>											*/
/*		#include <Finder.h>										*/
/*	#include <Printing.h>										*/
/*		#include <Errors.h>										*/
/*		#include <Dialogs.h>									*/
/*			#include <TextEdit.h>								*/
/*	#include <CMICCProfile.h>									*/

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
 
#define graphicsMacintoshIncludes
/* old header = graphics macintosh */
 

enum {
	defaultPollingHandlerFlags	= 0x00,
	okToSwitchDuringPollFlag	= 0x00,
	dontSwitchDuringPollFlag	= 0x01
};

typedef long gxPollingHandlerFlags;

typedef void (*gxPollingHandlerProcPtr)(long reference, gxPollingHandlerFlags flags);

#if GENERATINGCFM
typedef UniversalProcPtr gxPollingHandlerUPP;
#else
typedef gxPollingHandlerProcPtr gxPollingHandlerUPP;
#endif

enum {
	uppgxPollingHandlerProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxPollingHandlerFlags)))
};

#if GENERATINGCFM
#define NewgxPollingHandlerProc(userRoutine)		\
		(gxPollingHandlerUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxPollingHandlerProcInfo, GetCurrentArchitecture())
#else
#define NewgxPollingHandlerProc(userRoutine)		\
		((gxPollingHandlerUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallgxPollingHandlerProc(userRoutine, reference, flags)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxPollingHandlerProcInfo, (reference), (flags))
#else
#define CallgxPollingHandlerProc(userRoutine, reference, flags)		\
		(*(userRoutine))((reference), (flags))
#endif

extern gxPollingHandlerUPP GXGetGraphicsPollingHandler(long *reference)
 THREEWORDINLINE(0x303C, 0x245, 0xA832);
extern void GXSetGraphicsPollingHandler(gxPollingHandlerUPP handler, long reference)
 THREEWORDINLINE(0x303C, 0x246, 0xA832);
#define graphicsToolboxIncludes
/* old header = graphics toolbox */
 
/* QD to QD GX Translator typedefs */

enum gxTranslationOptions {
	gxDefaultOptionsTranslation	= 0x0000,
	gxOptimizedTranslation		= 0x0001,
	gxReplaceLineWidthTranslation = 0x0002,
	gxSimpleScalingTranslation	= 0x0004,
	gxSimpleGeometryTranslation	= 0x0008,						/* implies simple scaling */
	gxSimpleLinesTranslation	= 0x000C,						/* implies simple geometry & scaling */
	gxLayoutTextTranslation		= 0x0010,						/* turn on gxLine layout (normally off) */
	gxRasterTargetTranslation	= 0x0020,
	gxPostScriptTargetTranslation = 0x0040,
	gxVectorTargetTranslation	= 0x0080
};

typedef long gxTranslationOption;


enum gxTranslationStatistics {
	gxContainsFormsBegin		= 0x0001,
	gxContainsFormsEnd			= 0x0002,
	gxContainsPostScript		= 0x0004,
	gxContainsEmptyPostScript	= 0x0008
};

typedef long gxTranslationStatistic;


enum {
	gxQuickDrawPictTag			= 'pict'
};

struct gxQuickDrawPict {
/* translator inputs */
	gxTranslationOption				options;
	Rect							srcRect;
	Point							styleStretch;
/* size of quickdraw picture data */
	unsigned long					dataLength;
/* file alias */
	struct gxBitmapDataSourceAlias	alias;
};
typedef struct gxQuickDrawPict gxQuickDrawPict;

/* WindowRecord utilities */
extern gxViewPort GXNewWindowViewPort(WindowPtr qdWindow)
 THREEWORDINLINE(0x303C, 0x236, 0xA832);
extern gxViewPort GXGetWindowViewPort(WindowPtr qdWindow)
 THREEWORDINLINE(0x303C, 0x237, 0xA832);
extern WindowPtr GXGetViewPortWindow(gxViewPort portOrder)
 THREEWORDINLINE(0x303C, 0x238, 0xA832);
/* GDevice utilities */
extern GDHandle GXGetViewDeviceGDevice(gxViewDevice theDevice)
 THREEWORDINLINE(0x303C, 0x239, 0xA832);
extern gxViewDevice GXGetGDeviceViewDevice(GDHandle qdGDevice)
 THREEWORDINLINE(0x303C, 0x23a, 0xA832);
/* gxPoint utilities */
extern void GXConvertQDPoint(const Point *shortPt, gxViewPort portOrder, gxPoint *fixedPt)
 THREEWORDINLINE(0x303C, 0x23b, 0xA832);
/* printing utilities typedef */
typedef OSErr (*gxShapeSpoolProcPtr)(gxShape toSpool, long refCon);
typedef void (*gxUserViewPortFilterProcPtr)(gxShape toFilter, gxViewPort portOrder, long refCon);
typedef long (*gxConvertQDFontProcPtr)(gxStyle dst, long txFont, long txFace);

#if GENERATINGCFM
typedef UniversalProcPtr gxShapeSpoolUPP;
typedef UniversalProcPtr gxUserViewPortFilterUPP;
typedef UniversalProcPtr gxConvertQDFontUPP;
#else
typedef gxShapeSpoolProcPtr gxShapeSpoolUPP;
typedef gxUserViewPortFilterProcPtr gxUserViewPortFilterUPP;
typedef gxConvertQDFontProcPtr gxConvertQDFontUPP;
#endif

enum {
	uppgxShapeSpoolProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxShape)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppgxUserViewPortFilterProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxShape)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxViewPort)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppgxConvertQDFontProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxStyle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewgxShapeSpoolProc(userRoutine)		\
		(gxShapeSpoolUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxShapeSpoolProcInfo, GetCurrentArchitecture())
#define NewgxUserViewPortFilterProc(userRoutine)		\
		(gxUserViewPortFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxUserViewPortFilterProcInfo, GetCurrentArchitecture())
#define NewgxConvertQDFontProc(userRoutine)		\
		(gxConvertQDFontUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxConvertQDFontProcInfo, GetCurrentArchitecture())
#else
#define NewgxShapeSpoolProc(userRoutine)		\
		((gxShapeSpoolUPP) (userRoutine))
#define NewgxUserViewPortFilterProc(userRoutine)		\
		((gxUserViewPortFilterUPP) (userRoutine))
#define NewgxConvertQDFontProc(userRoutine)		\
		((gxConvertQDFontUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallgxShapeSpoolProc(userRoutine, toSpool, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxShapeSpoolProcInfo, (toSpool), (refCon))
#define CallgxUserViewPortFilterProc(userRoutine, toFilter, portOrder, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxUserViewPortFilterProcInfo, (toFilter), (portOrder), (refCon))
#define CallgxConvertQDFontProc(userRoutine, dst, txFont, txFace)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxConvertQDFontProcInfo, (dst), (txFont), (txFace))
#else
#define CallgxShapeSpoolProc(userRoutine, toSpool, refCon)		\
		(*(userRoutine))((toSpool), (refCon))
#define CallgxUserViewPortFilterProc(userRoutine, toFilter, portOrder, refCon)		\
		(*(userRoutine))((toFilter), (portOrder), (refCon))
#define CallgxConvertQDFontProc(userRoutine, dst, txFont, txFace)		\
		(*(userRoutine))((dst), (txFont), (txFace))
#endif

typedef gxShapeSpoolProcPtr gxShapeSpoolFunction;

typedef gxUserViewPortFilterProcPtr gxUserViewPortFilter;

typedef gxConvertQDFontProcPtr gxConvertQDFontFunction;

/* mouse utilities */
/* return mouse location in fixed-gxPoint global space */
extern void GXGetGlobalMouse(gxPoint *globalPt)
 THREEWORDINLINE(0x303C, 0x23c, 0xA832);
/* return fixed-gxPoint local mouse (gxViewPort == 0 --> default) */
extern void GXGetViewPortMouse(gxViewPort portOrder, gxPoint *localPt)
 THREEWORDINLINE(0x303C, 0x23d, 0xA832);
/* printing utilities */
extern gxUserViewPortFilter GXGetViewPortFilter(gxViewPort portOrder, long *refCon)
 THREEWORDINLINE(0x303C, 0x25e, 0xA832);
extern void GXSetViewPortFilter(gxViewPort portOrder, gxUserViewPortFilter filter, long refCon)
 THREEWORDINLINE(0x303C, 0x23e, 0xA832);
/* QD to QD GX Translator functions */
extern void GXInstallQDTranslator(GrafPtr port, gxTranslationOption options, const Rect *srcRect, const Rect *dstRect, Point styleStrech, gxShapeSpoolUPP userFunction, void *reference)
 THREEWORDINLINE(0x303C, 0x23f, 0xA832);
extern gxTranslationStatistic GXRemoveQDTranslator(GrafPtr port, gxTranslationStatistic *statistic)
 THREEWORDINLINE(0x303C, 0x240, 0xA832);
extern gxShape GXConvertPICTToShape(PicHandle pict, gxTranslationOption options, const Rect *srcRect, const Rect *dstRect, Point styleStretch, gxShape destination, gxTranslationStatistic *stats)
 THREEWORDINLINE(0x303C, 0x241, 0xA832);
/* Find the best GX style given a QD font and face. Called by the QD->GX translator */
extern long GXConvertQDFont(gxStyle theStyle, long txFont, long txFace)
 THREEWORDINLINE(0x303C, 0x242, 0xA832);
extern gxConvertQDFontUPP GXGetConvertQDFont(void)
 THREEWORDINLINE(0x303C, 0x243, 0xA832);
extern void GXSetConvertQDFont(gxConvertQDFontUPP userFunction)
 THREEWORDINLINE(0x303C, 0x244, 0xA832);
/* ColorSync 2.0 interface related routines */
extern void GXSetColorProfileReference(gxColorProfile profile, CMProfileRef reference)
 THREEWORDINLINE(0x303C, 0x282, 0xA832);
extern CMProfileRef GXGetColorProfileReference(gxColorProfile profile)
 THREEWORDINLINE(0x303C, 0x283, 0xA832);
 
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

#endif /* __GXENVIRONMENT__ */
