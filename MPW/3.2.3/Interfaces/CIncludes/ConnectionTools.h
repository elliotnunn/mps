
/************************************************************

Created: Wednesday, September 11, 1991 at 1:47 PM
 ConnectionTools.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved

************************************************************/


#ifndef __CONNECTIONTOOLS__
#define __CONNECTIONTOOLS__

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __CONNECTIONS__
#include <Connections.h>
#endif


enum {


/* messages for DefProc */
 cmInitMsg = 0,
 cmDisposeMsg = 1,
 cmSuspendMsg = 2,
 cmResumeMsg = 3,
 cmMenuMsg = 4,
 cmEventMsg = 5,
 cmActivateMsg = 6,
 cmDeactivateMsg = 7,

 cmIdleMsg = 50,
 cmResetMsg = 51,
 cmAbortMsg = 52,

 cmReadMsg = 100,
 cmWriteMsg = 101,
 cmStatusMsg = 102,
 cmListenMsg = 103,
 cmAcceptMsg = 104,
 cmCloseMsg = 105,
 cmOpenMsg = 106,
 cmBreakMsg = 107,
 cmIOKillMsg = 108
};
enum {
 cmEnvironsMsg = 109,

/* new connection tool messages for ctb 1.1 */
 cmNewIOPBMsg = 110,
 cmDisposeIOPBMsg = 111,
 cmGetErrorStringMsg = 112,
 cmPBReadMsg = 113,
 cmPBWriteMsg = 114,
 cmPBIOKillMsg = 115,

/*    messages for validate DefProc    */
 cmValidateMsg = 0,
 cmDefaultMsg = 1,

/*    messages for Setup DefProc    */
 cmSpreflightMsg = 0,
 cmSsetupMsg = 1,
 cmSitemMsg = 2,
 cmSfilterMsg = 3,
 cmScleanupMsg = 4,

/*    messages for scripting defProc    */
 cmMgetMsg = 0,
 cmMsetMsg = 1,

/*    messages for localization defProc    */
 cmL2English = 0,
 cmL2Intl = 1

/*    private data constants */

#define cdefType 'cdef'		/* main connection definition procedure    */
#define cvalType 'cval'		/* validation definition procedure    */
#define csetType 'cset'		/* connection setup definition procedure    */
#define clocType 'cloc'		/* connection configuration localization defProc    */
#define cscrType 'cscr'		/* connection scripting defProc interfaces    */

#define cbndType 'cbnd'		/* bundle type for connection    */
#define cverType 'vers'
};

struct CMDataBuffer {
 Ptr thePtr;
 long count;
 CMChannel channel;
 CMFlags flags;
};

typedef struct CMDataBuffer CMDataBuffer;
typedef CMDataBuffer *CMDataBufferPtr;

struct CMCompletorRecord {
 Boolean async;
 ProcPtr completionRoutine;
};

typedef struct CMCompletorRecord CMCompletorRecord;
typedef CMCompletorRecord *CMCompletorPtr;

/* Private Data Structure */

struct CMSetupStruct {
 DialogPtr theDialog;
 short count;
 Ptr theConfig;
 short procID;				/* procID of the tool */
};

typedef struct CMSetupStruct CMSetupStruct;
typedef CMSetupStruct *CMSetupPtr;



#endif
