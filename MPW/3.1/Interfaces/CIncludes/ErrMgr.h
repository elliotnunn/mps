/************************************************************

Created: Thursday, September 7, 1989 at 9:13 PM
	ErrMgr.h
	C Interface to the Macintosh Libraries


	<<< Error File Manager Routines Interface File >>>
	
	Copyright Apple Computer, Inc.	1987-1989
	All rights reserved
	
	This file contains:
	
	InitErrMgr(toolname, sysename, Nbrs)  - ErrMgr initialization
	CloseErrMgr()						  - Close ErrMgr message files
	GetSysErrText(Nbr, Msg) 			  - Get a system error message for a number
	GetToolErrText(Nbr, Insert, Msg)	  - Get a tool error message for a number
	AddErrInsert(insert, msgString) 	  - Add an insert to a message
	addInserts(msgString, insert,...)	  - Add a number of inserts to a message
	

************************************************************/


#ifndef __ERRMGR__
#define __ERRMGR__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif
void InitErrMgr(char *toolErrFilename,char *sysErrFilename,Boolean showToolErrNbrs);
void CloseErrMgr(void); 
char *GetSysErrText(short msgNbr,char *errMsg); 
char *GetToolErrText(short msgNbr,char *errInsert,char *errMsg);
void AddErrInsert(unsigned char *insert,unsigned char *msgString);
unsigned char *addInserts(unsigned char *msgString,unsigned char *insert,
	... );
#ifdef __cplusplus
}
#endif

#endif
