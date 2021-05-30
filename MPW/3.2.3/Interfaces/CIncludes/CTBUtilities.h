
/************************************************************

Created: Tuesday, September 10, 1991 at 10:29 AM
 CTBUtilities.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved

************************************************************/


#ifndef __CTBUTILITIES__
#define __CTBUTILITIES__

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __APPLETALK__
#include <AppleTalk.h>
#endif


enum {


/* version of Comm Toolbox Utilities */
 curCTBUVersion = 2,

/*    Error codes/types    */
 ctbuGenericError = -1,
 ctbuNoErr = 0
};

typedef OSErr CTBUErr;

enum {chooseDisaster = -2,chooseFailed,chooseAborted,chooseOKMinor,chooseOKMajor,
 chooseCancel};
typedef unsigned short ChooseReturnCode;

enum {nlOk,nlCancel,nlEject};
typedef unsigned short NuLookupReturnCode;

enum {nameInclude = 1,nameDisable,nameReject};
typedef unsigned short NameFilterReturnCode;

enum {zoneInclude = 1,zoneDisable,zoneReject};
typedef unsigned short ZoneFilterReturnCode;


enum {


/*    Values for hookProc items        */
 hookOK = 1,
 hookCancel = 2,
 hookOutline = 3,
 hookTitle = 4,
 hookItemList = 5,
 hookZoneTitle = 6,
 hookZoneList = 7,
 hookLine = 8,
 hookVersion = 9,
 hookReserved1 = 10,
 hookReserved2 = 11,
 hookReserved3 = 12,
 hookReserved4 = 13,

/*    "virtual" hookProc items    */
 hookNull = 100,
 hookItemRefresh = 101,
 hookZoneRefresh = 102,
 hookEject = 103,
 hookPreflight = 104,
 hookPostflight = 105,
 hookKeyBase = 1000
};


/*    NuLookup structures/constants    */
struct NLTypeEntry {
 Handle hIcon;
 Str32 typeStr;
};

typedef struct NLTypeEntry NLTypeEntry;


typedef NLTypeEntry NLType[4];

struct NBPReply {
 EntityName theEntity;
 AddrBlock theAddr;
};

typedef struct NBPReply NBPReply;


typedef pascal short (*NameFilterProcPtr)(EntityName theEntity);
typedef pascal short (*ZoneFilterProcPtr)(Str32 theZone);

typedef NameFilterProcPtr nameFilterProcPtr;
typedef ZoneFilterProcPtr zoneFilterProcPtr;

#ifdef __cplusplus
extern "C" {
#endif
pascal CTBUErr InitCTBUtilities(void); 
pascal short CTBGetCTBVersion(void); 


pascal short StandardNBP(Point where,ConstStr255Param prompt,short numTypes,
 NLType typeList,NameFilterProcPtr nameFilter,ZoneFilterProcPtr zoneFilter,
 DlgHookProcPtr hookProc,NBPReply *theReply); 

pascal short CustomNBP(Point where,ConstStr255Param prompt,short numTypes,
 NLType typeList,NameFilterProcPtr nameFilter,ZoneFilterProcPtr zoneFilter,
 DlgHookProcPtr hookProc,long userData,short dialogID,ModalFilterProcPtr filterProc,
 NBPReply *theReply); 

/*  Obsolete synonyms for above routines  */
pascal short NuLookup(Point where,ConstStr255Param prompt,short numTypes,
 NLType typeList,NameFilterProcPtr nameFilter,ZoneFilterProcPtr zoneFilter,
 DlgHookProcPtr hookProc,NBPReply *theReply); 

pascal short NuPLookup(Point where,ConstStr255Param prompt,short numTypes,
 NLType typeList,NameFilterProcPtr nameFilter,ZoneFilterProcPtr zoneFilter,
 DlgHookProcPtr hookProc,long userData,short dialogID,ModalFilterProcPtr filterProc,
 NBPReply *theReply); 
#ifdef __cplusplus
}
#endif

#endif
