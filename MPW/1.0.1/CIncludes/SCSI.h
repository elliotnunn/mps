/*
	SCSI.h -- SCSI

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __SCSI__
#define __SCSI__
#ifndef __TYPES__
#include <Types.h>
#endif

#define scInc 1
#define scNoInc 2
#define scAdd 3
#define scMove 4
#define scLoop 5
#define scNop 6
#define scStop 7
#define scComp 8

typedef struct SCSIInstr {
	unsigned short scOpcode;
	unsigned long scParam1;
	unsigned long scParam2;
} SCSIInstr;

pascal OSErr SCSIReset()
	extern;
pascal OSErr SCSIGet()
	extern;
pascal OSErr SCSISelect(targetID)
	short targetID;
	extern;
pascal OSErr SCSICmd(buffer,count)
	Ptr buffer;
	short count;
	extern;
pascal OSErr SCSIRead(tibPtr)
	Ptr tibPtr;
	extern;
pascal OSErr SCSIRBlind(tibPtr)
	Ptr tibPtr;
	extern;
pascal OSErr SCSIWrite(tibPtr)
	Ptr tibPtr;
	extern;
pascal OSErr SCSIWBlind(tibPtr)
	Ptr tibPtr;
	extern;
pascal OSErr SCSIComplete(stat,message,wait)
	short *stat,*message;
	unsigned int wait;
	extern;
pascal short SCSIStat()
	extern;
#endif
