/*
********************************************************************************
**
** Name: GoggleSprocket.h
**
** Description:
**
**	Header file for the application-level interface to GoggleSprocket.
**
********************************************************************************
*/
#ifndef __GOGGLESPROCKET__
#define __GOGGLESPROCKET__

#include <Types.h>
#include <Events.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
********************************************************************************
** constants & data types
********************************************************************************
*/
typedef Boolean (*GSpEventProcPtr)( EventRecord *inEvent );

/*
********************************************************************************
** prototypes for application level calls
********************************************************************************
*/
/* general */
OSStatus GSpStartup( UInt32 inReserved );
OSStatus GSpShutdown( UInt32 inReserved );

/* configuration */
OSStatus GSpConfigure( GSpEventProcPtr inEventProc, Point *inUpperLeft );

#ifdef __cplusplus
}
#endif

#endif /* __GOGGLESPROCKET__ */