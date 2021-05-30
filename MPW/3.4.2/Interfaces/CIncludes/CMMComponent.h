/*
 	File:		CMMComponent.h
 
 	Contains:	ColorSync CMM Components
 
 	Version:	Technology:	ColorSync 2.0
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __CMMCOMPONENT__
#define __CMMCOMPONENT__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
#endif
/*	#include <Files.h>											*/
/*		#include <OSUtils.h>									*/
/*			#include <Memory.h>									*/
/*		#include <Finder.h>										*/
/*	#include <Printing.h>										*/
/*		#include <Errors.h>										*/
/*		#include <Dialogs.h>									*/
/*			#include <Menus.h>									*/
/*			#include <Controls.h>								*/
/*			#include <Windows.h>								*/
/*				#include <Events.h>								*/
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


enum {
	CMMInterfaceVersion			= 1
};

/* Component function selectors */
/* Required */
enum {
	kCMMInit					= 0,
	kNCMMInit					= 6,
	kCMMMatchColors				= 1,
	kCMMCheckColors				= 2
};

/* Optional */
enum {
	kCMMValidateProfile			= 8,
	kCMMFlattenProfile			= 14,
	kCMMUnflattenProfile		= 15,
	kCMMMatchBitmap				= 9,
	kCMMCheckBitmap				= 10,
	kCMMMatchPixMap				= 3,
	kCMMCheckPixMap				= 4,
	kCMMConcatenateProfiles		= 5,
	kCMMConcatInit				= 7,
	kCMMNewLinkProfile			= 16,
	kCMMGetPS2ColorSpace		= 11,
	kCMMGetPS2ColorRenderingIntent = 12,
	kCMMGetPS2ColorRendering	= 13,
	kCMMGetPS2ColorRenderingVMSize = 17
};

extern pascal CMError NCMInit(ComponentInstance CMSession, CMProfileRef srcProfile, CMProfileRef dstProfile)
 FIVEWORDINLINE(0x2F3C, 8, 6, 0x7000, 0xA82A);
extern pascal CMError CMInit(ComponentInstance CMSession, CMProfileHandle srcProfile, CMProfileHandle dstProfile)
 FIVEWORDINLINE(0x2F3C, 8, 0, 0x7000, 0xA82A);
extern pascal CMError CMMatchColors(ComponentInstance CMSession, CMColor *myColors, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 8, 1, 0x7000, 0xA82A);
extern pascal CMError CMCheckColors(ComponentInstance CMSession, CMColor *myColors, unsigned long count, long *result)
 FIVEWORDINLINE(0x2F3C, 12, 2, 0x7000, 0xA82A);
/* Optional functions */
extern pascal CMError CMMValidateProfile(ComponentInstance CMSession, CMProfileRef prof, Boolean *valid)
 FIVEWORDINLINE(0x2F3C, 8, 8, 0x7000, 0xA82A);
extern pascal CMError CMMFlattenProfile(ComponentInstance CMSession, CMProfileRef prof, unsigned long flags, CMFlattenUPP proc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 16, 14, 0x7000, 0xA82A);
extern pascal CMError CMMUnflattenProfile(ComponentInstance CMSession, FSSpec *resultFileSpec, CMFlattenUPP proc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 12, 15, 0x7000, 0xA82A);
extern pascal CMError CMMatchBitmap(ComponentInstance CMSession, const CMBitmap *bitmap, CMBitmapCallBackUPP progressProc, void *refCon, CMBitmap *matchedBitmap)
 FIVEWORDINLINE(0x2F3C, 16, 9, 0x7000, 0xA82A);
extern pascal CMError CMCheckBitmap(ComponentInstance CMSession, const CMBitmap *bitmap, CMBitmapCallBackUPP progressProc, void *refCon, CMBitmap *resultBitmap)
 FIVEWORDINLINE(0x2F3C, 16, 10, 0x7000, 0xA82A);
extern pascal CMError CMMatchPixMap(ComponentInstance CMSession, PixMap *myPixMap, CMBitmapCallBackUPP progressProc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 12, 3, 0x7000, 0xA82A);
extern pascal CMError CMCheckPixMap(ComponentInstance CMSession, const PixMap *myPixMap, CMBitmapCallBackUPP progressProc, BitMap *myBitMap, void *refCon)
 FIVEWORDINLINE(0x2F3C, 16, 4, 0x7000, 0xA82A);
extern pascal CMError CMConcatInit(ComponentInstance CMSession, CMConcatProfileSet *profileSet)
 FIVEWORDINLINE(0x2F3C, 4, 7, 0x7000, 0xA82A);
extern pascal CMError CMNewLinkProfile(ComponentInstance CMSession, CMProfileRef *prof, const CMProfileLocation *targetLocation, CMConcatProfileSet *profileSet)
 FIVEWORDINLINE(0x2F3C, 12, 16, 0x7000, 0xA82A);
extern pascal CMError CMMGetPS2ColorSpace(ComponentInstance CMSession, CMProfileRef srcProf, unsigned long flags, CMFlattenUPP proc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 16, 11, 0x7000, 0xA82A);
extern pascal CMError CMMGetPS2ColorRenderingIntent(ComponentInstance CMSession, CMProfileRef srcProf, unsigned long flags, CMFlattenUPP proc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 16, 12, 0x7000, 0xA82A);
extern pascal CMError CMMGetPS2ColorRendering(ComponentInstance CMSession, CMProfileRef srcProf, CMProfileRef dstProf, unsigned long flags, CMFlattenUPP proc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 20, 13, 0x7000, 0xA82A);
extern pascal CMError CMMGetPS2ColorRenderingVMSize(ComponentInstance CMSession, CMProfileRef srcProf, CMProfileRef dstProf, unsigned long *vmSize)
 FIVEWORDINLINE(0x2F3C, 12, 17, 0x7000, 0xA82A);
extern pascal CMError CMConcatenateProfiles(ComponentInstance CMSession, CMProfileHandle thru, CMProfileHandle dst, CMProfileHandle *newDst)
 FIVEWORDINLINE(0x2F3C, 12, 5, 0x7000, 0xA82A);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CMMCOMPONENT__ */
