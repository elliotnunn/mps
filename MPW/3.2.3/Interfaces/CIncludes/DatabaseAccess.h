
/************************************************************

Created: Tuesday, September 10, 1991 at 12:57 PM
 DatabaseAccess.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1989-1991
  All rights reserved

************************************************************/


#ifndef __DATABASEACCESS__
#define __DATABASEACCESS__

#ifndef __RESOURCES__
#include <Resources.h>
#endif


enum {


/* error and status codes */
 rcDBNull = -800,
 rcDBValue = -801,
 rcDBError = -802,
 rcDBBadType = -803,
 rcDBBreak = -804,
 rcDBExec = -805,
 rcDBBadSessID = -806,
 rcDBBadSessNum = -807,			/* bad session number for DBGetConnInfo */
 rcDBBadDDEV = -808,			/* bad ddev specified on DBInit */
 rcDBAsyncNotSupp = -809,		/* ddev does not support async calls */
 rcDBBadAsyncPB = -810,			/* tried to kill a bad pb */
 rcDBNoHandler = -811,			/* no app handler for specified data type */
 rcDBWrongVersion = -812,		/* incompatible versions */
 rcDBPackNotInited = -813,		/* attempt to call other routine before InitDBPack */

/* messages for status functions for DBStartQuery */
 kDBUpdateWind = 0,
 kDBAboutToInit = 1,
 kDBInitComplete = 2,
 kDBSendComplete = 3,
 kDBExecComplete = 4,
 kDBStartQueryComplete = 5
};
enum {

/* messages for status functions for DBGetQueryResults */
 kDBGetItemComplete = 6,
 kDBGetQueryResultsComplete = 7,

/* data type codes */

#define typeNone 'none'
#define typeDate 'date'
#define typeTime 'time'
#define typeTimeStamp 'tims'
#define typeDecimal 'deci'
#define typeMoney 'mone'
#define typeVChar 'vcha'
#define typeVBin 'vbin'
#define typeLChar 'lcha'
#define typeLBin 'lbin'
#define typeDiscard 'disc'

/* "dummy" types for DBResultsToText */
#define typeUnknown 'unkn'
#define typeColBreak 'colb'
#define typeRowBreak 'rowb'

/* pass this in to DBGetItem for any data type */
#define typeAnyType (DBType)0

/* infinite timeout value for DBGetItem */

 kDBWaitForever = -1,

/*  flags for DBGetItem  */
 kDBLastColFlag = 0x0001,
 kDBNullFlag = 0x0004
};

typedef OSType DBType;

/* structure for asynchronous parameter block */
struct DBAsyncParamBlockRec {
 ProcPtr completionProc;		/* pointer to completion routine */
 OSErr result;					/* result of call */
 long userRef;					/* for application's use */
 long ddevRef;					/* for ddev's use */
 long reserved;					/* for internal use */
};

typedef struct DBAsyncParamBlockRec DBAsyncParamBlockRec;
typedef DBAsyncParamBlockRec *DBAsyncParmBlkPtr;

/* structure for resource list in QueryRecord */
struct ResListElem {
 ResType theType;				/* resource type */
 short id;						/* resource id */
};

typedef struct ResListElem ResListElem;
typedef ResListElem *ResListPtr, **ResListHandle;

/* structure for query list in QueryRecord */
typedef Handle **QueryListHandle;

struct QueryRecord {
 short version;					/* version */
 short id;						/* id of 'qrsc' this came from */
 Handle queryProc;				/* handle to query def proc */
 Str63 ddevName;				/* ddev name */
 Str255 host;					/* host name */
 Str255 user;					/* user name */
 Str255 password;				/* password */
 Str255 connStr;				/* connection string */
 short currQuery;				/* index of current query */
 short numQueries;				/* number of queries in list */
 QueryListHandle queryList;		/* handle to array of handles to text */
 short numRes;					/* number of resources in list */
 ResListHandle resList;			/* handle to array of resource list elements */
 Handle dataHandle;				/* for use by query def proc */
 long refCon;					/* for use by application */
};

typedef struct QueryRecord QueryRecord;
typedef QueryRecord *QueryPtr, **QueryHandle;

/* structure of column types array in ResultsRecord */
typedef Handle ColTypesHandle;

/* structure for column info in ResultsRecord */
struct DBColInfoRecord {
 short len;
 short places;
 short flags;
};

typedef struct DBColInfoRecord DBColInfoRecord;

typedef Handle ColInfoHandle;

/* structure of results returned by DBGetResults */
struct ResultsRecord {
 short numRows;					/* number of rows in result */
 short numCols;					/* number of columns per row */
 ColTypesHandle colTypes;		/* data type array */
 Handle colData;				/* actual results */
 ColInfoHandle colInfo;			/* DBColInfoRecord array */
};

typedef struct ResultsRecord ResultsRecord;


#ifdef __cplusplus
extern "C" {
#endif
pascal OSErr InitDBPack(void)
 = {0x3F3C,0x0004,0x303C,0x0100,0xA82F}; 
pascal OSErr DBInit(long *sessID,ConstStr63Param ddevName,ConstStr255Param host,
 ConstStr255Param user,ConstStr255Param passwd,ConstStr255Param connStr,
 DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0E02,0xA82F}; 
pascal OSErr DBEnd(long sessID,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0403,0xA82F}; 
pascal OSErr DBGetConnInfo(long sessID,short sessNum,long *returnedID,long *version,
 Str63 ddevName,Str255 host,Str255 user,Str255 network,Str255 connStr,long *start,
 OSErr *state,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x1704,0xA82F}; 
pascal OSErr DBGetSessionNum(long sessID,short *sessNum,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0605,0xA82F}; 
pascal OSErr DBSend(long sessID,char *text,short len,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0706,0xA82F}; 
pascal OSErr DBSendItem(long sessID,DBType dataType,short len,short places,
 short flags,void *buffer,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0B07,0xA82F}; 
pascal OSErr DBExec(long sessID,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0408,0xA82F}; 
pascal OSErr DBState(long sessID,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0409,0xA82F}; 
pascal OSErr DBGetErr(long sessID,long *err1,long *err2,Str255 item1,Str255 item2,
 Str255 errorMsg,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0E0A,0xA82F}; 
pascal OSErr DBBreak(long sessID,Boolean abort,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x050B,0xA82F}; 
pascal OSErr DBGetItem(long sessID,long timeout,DBType *dataType,short *len,
 short *places,short *flags,void *buffer,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x100C,0xA82F}; 
pascal OSErr DBUnGetItem(long sessID,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x040D,0xA82F}; 
pascal OSErr DBKill(DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x020E,0xA82F}; 
pascal OSErr DBGetNewQuery(short queryID,QueryHandle *query)
 = {0x303C,0x030F,0xA82F}; 
pascal OSErr DBDisposeQuery(QueryHandle query)
 = {0x303C,0x0210,0xA82F}; 
pascal OSErr DBStartQuery(long *sessID,QueryHandle query,ProcPtr statusProc,
 DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0811,0xA82F}; 
pascal OSErr DBGetQueryResults(long sessID,ResultsRecord *results,long timeout,
 ProcPtr statusProc,DBAsyncParmBlkPtr asyncPB)
 = {0x303C,0x0A12,0xA82F}; 
pascal OSErr DBResultsToText(ResultsRecord *results,Handle *theText)
 = {0x303C,0x0413,0xA82F}; 
pascal OSErr DBInstallResultHandler(DBType dataType,ProcPtr theHandler,
 Boolean isSysHandler)
 = {0x303C,0x0514,0xA82F}; 
pascal OSErr DBRemoveResultHandler(DBType dataType)
 = {0x303C,0x0215,0xA82F}; 
pascal OSErr DBGetResultHandler(DBType dataType,ProcPtr *theHandler,Boolean getSysHandler)
 = {0x303C,0x0516,0xA82F}; 
#ifdef __cplusplus
}
#endif

#endif
