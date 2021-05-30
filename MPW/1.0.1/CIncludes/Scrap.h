/*
	Scrap.h -- Scrap Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __SCRAP__
#define __SCRAP__
#ifndef __TYPES__
#include <Types.h>
#endif

typedef struct ScrapStuff {
	long scrapSize;
	Handle scrapHandle;
	short scrapCount;
	short scrapState;
	StringPtr scrapName;
} ScrapStuff,*PScrapStuff;

pascal PScrapStuff InfoScrap()
	extern 0xA9F9;
pascal long UnloadScrap()
	extern 0xA9FA;
pascal long LoadScrap()
	extern 0xA9FB;
pascal long GetScrap(hDest,theType,offset)
	Handle hDest;
	ResType theType;
	long *offset;
	extern 0xA9FD;
pascal long ZeroScrap()
	extern 0xA9FC;
pascal long PutScrap(length,theType,source)
	long length;
	ResType theType;
	Ptr source;
	extern 0xA9FE;
#endif
