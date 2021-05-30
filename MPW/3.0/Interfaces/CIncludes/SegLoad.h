/************************************************************

Created: Tuesday, October 4, 1988 at 9:14 PM
    SegLoad.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __SEGLOAD__
#define __SEGLOAD__

#ifndef __TYPES__
#include <Types.h>
#endif

#define appOpen 0   /*Open the Document (s)*/
#define appPrint 1  /*Print the Document (s)*/

struct AppFile {
    short vRefNum;
    OSType fType;
    short versNum;  /*versNum in high byte*/
    Str255 fName;
};

#ifndef __cplusplus
typedef struct AppFile AppFile;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal void UnloadSeg(void * routineAddr)
    = 0xA9F1; 
pascal void ExitToShell(void)
    = 0xA9F4; 
pascal void GetAppParms(Str255 apName,short *apRefNum,Handle *apParam)
    = 0xA9F5; 
pascal void CountAppFiles(short *message,short *count); 
pascal void GetAppFiles(short index,AppFile *theFile); 
pascal void ClrAppFiles(short index); 
void getappparms(char *apName,short *apRefNum,Handle *apParam); 
#ifdef __safe_link
}
#endif

#endif
