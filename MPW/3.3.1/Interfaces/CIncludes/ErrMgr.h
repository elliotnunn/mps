/*
	File:		ErrMgr.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.
*/

#ifndef __ERRMGR__
#define __ERRMGR__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern void InitErrMgr(char *toolErrFilename, char *sysErrFilename, Boolean showToolErrNbrs);

extern Boolean pascalStrings;

extern void CloseErrMgr(void);

extern char *GetSysErrText(short msgNbr, char *errMsg);

extern char *GetToolErrText(short msgNbr, char *errInsert, char *errMsg);

extern void AddErrInsert(unsigned char *insert, unsigned char *msgString);

extern unsigned char *addInserts(unsigned char *msgString, unsigned char *insert, ...);

#ifdef __cplusplus
}
#endif

#endif
