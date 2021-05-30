/*
 	File:		Scrap.h
 
 	Contains:	Scrap Manager Interfaces.
 
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

#ifndef __SCRAP__
#define __SCRAP__


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

struct ScrapStuff {
	long							scrapSize;
	Handle							scrapHandle;
	short							scrapCount;
	short							scrapState;
	StringPtr						scrapName;
};
typedef struct ScrapStuff ScrapStuff;

typedef ScrapStuff *PScrapStuff, *ScrapStuffPtr;

extern pascal ScrapStuffPtr InfoScrap(void)
 ONEWORDINLINE(0xA9F9);
extern pascal long UnloadScrap(void)
 ONEWORDINLINE(0xA9FA);
extern pascal long LoadScrap(void)
 ONEWORDINLINE(0xA9FB);
extern pascal long GetScrap(Handle hDest, ResType theType, long *offset)
 ONEWORDINLINE(0xA9FD);
extern pascal long ZeroScrap(void)
 ONEWORDINLINE(0xA9FC);
extern pascal long PutScrap(long length, ResType theType, void *source)
 ONEWORDINLINE(0xA9FE);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SCRAP__ */
