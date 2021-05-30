/************************************************************

Created: Tuesday, October 4, 1988 at 8:42 PM
    Scrap.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __SCRAP__
#define __SCRAP__

#ifndef __TYPES__
#include <Types.h>
#endif

struct ScrapStuff {
    long scrapSize;
    Handle scrapHandle;
    short scrapCount;
    short scrapState;
    StringPtr scrapName;
};

#ifndef __cplusplus
typedef struct ScrapStuff ScrapStuff;
#endif

typedef ScrapStuff *PScrapStuff;

#ifdef __safe_link
extern "C" {
#endif
pascal PScrapStuff InfoScrap(void)
    = 0xA9F9; 
pascal long UnloadScrap(void)
    = 0xA9FA; 
pascal long LoadScrap(void)
    = 0xA9FB; 
pascal long GetScrap(Handle hDest,ResType theType,long *offset)
    = 0xA9FD; 
pascal long ZeroScrap(void)
    = 0xA9FC; 
pascal long PutScrap(long length,ResType theType,Ptr source)
    = 0xA9FE; 
#ifdef __safe_link
}
#endif

#endif
