/*
 	File:		Packages.h
 
 	Contains:	Package Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __PACKAGES__
#define __PACKAGES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

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
	listMgr						= 0,							/* list manager */
	dskInit						= 2,							/* Disk Initializaton */
	stdFile						= 3,							/* Standard File */
	flPoint						= 4,							/* Floating-Point Arithmetic */
	trFunc						= 5,							/* Transcendental Functions */
	intUtil						= 6,							/* International Utilities */
	bdConv						= 7,							/* Binary/Decimal Conversion */
	editionMgr					= 11							/* Edition Manager */
};

extern pascal void InitPack(short packID)
 ONEWORDINLINE(0xA9E5);
extern pascal void InitAllPacks(void)
 ONEWORDINLINE(0xA9E6);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PACKAGES__ */
