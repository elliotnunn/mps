/*
 	File:		CMConversions.h
 
 	Contains:	ColorSync base <-> derived color space conversion Component interface
 
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

#ifndef __CMCONVERSIONS__
#define __CMCONVERSIONS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif
/*	#include <MixedMode.h>										*/

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
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
	CMConversionInterfaceVersion = 1
};

/* Component function selectors */
enum {
	kCMXYZToLab					= 0,
	kCMLabToXYZ					= 1,
	kCMXYZToLuv					= 2,
	kCMLuvToXYZ					= 3,
	kCMXYZToYxy					= 4,
	kCMYxyToXYZ					= 5,
	kCMRGBToHLS					= 6,
	kCMHLSToRGB					= 7,
	kCMRGBToHSV					= 8,
	kCMHSVToRGB					= 9,
	kCMRGBToGRAY				= 10,
	kCMXYZToFixedXYZ			= 11,
	kCMFixedXYZToXYZ			= 12
};

extern pascal ComponentResult CMXYZToLab(ComponentInstance ci, const CMColor *src, const CMXYZColor *white, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 16, 0, 0x7000, 0xA82A);
extern pascal ComponentResult CMLabToXYZ(ComponentInstance ci, const CMColor *src, const CMXYZColor *white, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 16, 1, 0x7000, 0xA82A);
extern pascal ComponentResult CMXYZToLuv(ComponentInstance ci, const CMColor *src, const CMXYZColor *white, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 16, 2, 0x7000, 0xA82A);
extern pascal ComponentResult CMLuvToXYZ(ComponentInstance ci, const CMColor *src, const CMXYZColor *white, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 16, 3, 0x7000, 0xA82A);
extern pascal ComponentResult CMXYZToYxy(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 4, 0x7000, 0xA82A);
extern pascal ComponentResult CMYxyToXYZ(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 5, 0x7000, 0xA82A);
extern pascal ComponentResult CMRGBToHLS(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 6, 0x7000, 0xA82A);
extern pascal ComponentResult CMHLSToRGB(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 7, 0x7000, 0xA82A);
extern pascal ComponentResult CMRGBToHSV(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 8, 0x7000, 0xA82A);
extern pascal ComponentResult CMHSVToRGB(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 9, 0x7000, 0xA82A);
extern pascal ComponentResult CMRGBToGray(ComponentInstance ci, const CMColor *src, CMColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 10, 0x7000, 0xA82A);
extern pascal ComponentResult CMXYZToFixedXYZ(ComponentInstance ci, const CMXYZColor *src, CMFixedXYZColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 11, 0x7000, 0xA82A);
extern pascal ComponentResult CMFixedXYZToXYZ(ComponentInstance ci, const CMFixedXYZColor *src, CMXYZColor *dst, unsigned long count)
 FIVEWORDINLINE(0x2F3C, 12, 12, 0x7000, 0xA82A);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CMCONVERSIONS__ */
