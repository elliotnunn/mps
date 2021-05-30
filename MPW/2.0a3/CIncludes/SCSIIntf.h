/*
SCSIIntf.h -- New SCSI Interface 
	
	version 2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1986-1987
	All rights reserved.

	modifications:
		4feb87	KLH	removed SCSIDisconnect, SCSIReselect, SCSIReselAtn.
*/

#ifndef __SCSI__
#define __SCSI__
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
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



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


pascal OSErr SCSISelAtn(targetID)
	short targetID;
	extern;
pascal OSErr SCSIMsgIn(message)
	short *message;
	extern;
pascal OSErr SCSIMsgOut(message)
	short message;
	extern;


#endif
#endif

