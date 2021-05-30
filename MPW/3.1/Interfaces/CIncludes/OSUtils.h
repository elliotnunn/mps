/************************************************************

Created: Tuesday, September 19, 1989 at 11:22 AM
	OSUtils.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved
	
	Dont use:
	-SetUpA5
	-RestoreA5
	Instead:
	SetUpA5 --> myA5 = SetCurrentA5();
	RestoreA5 --> oldA5 = SetA5(myA5);

************************************************************/


#ifndef __OSUTILS__
#define __OSUTILS__

#ifndef __TYPES__
#include <Types.h>
#endif

#define useFree 0
#define useATalk 1
#define useAsync 2
#define useExtClk 3 		/*Externally clocked*/
#define useMIDI 4
#define curSysEnvVers 2 	/*Updated to equal latest SysEnvirons version*/
#define macXLMachine 0
#define macMachine 1
#define envMac -1			/*Environs Equates*/
#define envXL -2
#define envMachUnknown 0
#define env512KE 1
#define envMacPlus 2
#define envSE 3
#define envMacII 4
#define envMacIIx 5
#define envMacIIcx 6
#define envSE30 7
#define envPortable 8
#define envMacIIci 9
#define envCPUUnknown 0 	/*CPU types*/
#define env68000 1
#define env68010 2
#define env68020 3
#define env68030 4
#define envUnknownKbd 0 	/*Keyboard types*/
#define envMacKbd 1
#define envMacAndPad 2
#define envMacPlusKbd 3
#define envAExtendKbd 4
#define envStandADBKbd 5
#define envPortADBKbd 6
#define envPortISOADBKbd 7
#define envStdISOADBKbd 8
#define envExtISOADBKbd 9
#define false32b 0			/*24 bit addressing error*/
#define true32b 1			/*32 bit addressing error*/

/* result types for RelString Call */

#define sortsBefore -1		/*first string < second string*/
#define sortsEqual 0		/*first string = second string*/
#define sortsAfter 1		/*first string > second string*/

enum {dummyType,vType,ioQType,drvQType,evType,fsQType };
typedef unsigned short QTypes;

enum {OSTrap,ToolTrap};
typedef unsigned char TrapType;

struct SysParmType {
	char valid;
	char aTalkA;
	char aTalkB;
	char config;
	short portA;
	short portB;
	long alarm;
	short font;
	short kbdPrint;
	short volClik;
	short misc;
};

typedef struct SysParmType SysParmType;
typedef SysParmType *SysPPtr;

struct QElem {
	struct QElem *qLink;
	short qType;
	short qData[1];
};

typedef struct QElem QElem;
typedef QElem *QElemPtr;

struct QHdr {
	short qFlags;
	QElemPtr qHead;
	QElemPtr qTail;
};

typedef struct QHdr QHdr;
typedef QHdr *QHdrPtr;

struct DateTimeRec {
	short year;
	short month;
	short day;
	short hour;
	short minute;
	short second;
	short dayOfWeek;
};

typedef struct DateTimeRec DateTimeRec;
struct SysEnvRec {
	short environsVersion;
	short machineType;
	short systemVersion;
	short processor;
	Boolean hasFPU;
	Boolean hasColorQD;
	short keyBoardType;
	short atDrvrVersNum;
	short sysVRefNum;
};

typedef struct SysEnvRec SysEnvRec;
#ifdef __cplusplus
extern "C" {
#endif
pascal SysPPtr GetSysPPtr(void);
pascal void SysBeep(short duration)
	= 0xA9C8;
pascal long KeyTrans(Ptr transData,short keycode,long *state)
	= 0xA9C3;
pascal OSErr DTInstall(QElemPtr dtTaskPtr); 
pascal char GetMMUMode(void);
pascal void SwapMMUMode(char *mode);
pascal OSErr SysEnvirons(short versionRequested,SysEnvRec *theWorld);
pascal OSErr ReadDateTime(unsigned long *time); 
pascal void GetDateTime(unsigned long *secs);
pascal OSErr SetDateTime(unsigned long time);
pascal void SetTime(const DateTimeRec *d);
pascal void GetTime(DateTimeRec *d);
pascal void Date2Secs(const DateTimeRec *d,unsigned long *s);
pascal void Secs2Date(unsigned long s,DateTimeRec *d);
pascal void Delay(long numTicks,long *finalTicks);
pascal long GetTrapAddress(short trapNum);
pascal void SetTrapAddress(long trapAddr,short trapNum);
pascal long NGetTrapAddress(short trapNum,TrapType tTyp);
pascal void NSetTrapAddress(long trapAddr,short trapNum,TrapType tTyp); 
pascal OSErr WriteParam(void);
pascal Boolean EqualString(const Str255 str1,const Str255 str2,Boolean caseSens,
	Boolean diacSens);
Boolean equalstring(char *str1,char *str2,Boolean caseSens,Boolean diacSens);
pascal void UprString(Str255 theString,Boolean diacSens);
void uprstring(char *theString,Boolean diacSens);
pascal void Enqueue(QElemPtr qElement,QHdrPtr qHeader); 
pascal OSErr Dequeue(QElemPtr qElement,QHdrPtr qHeader);
pascal long SetCurrentA5(void)
	= {0x2E8D,0x2A78,0x0904};
pascal long SetA5(long newA5)
	= {0x2F4D,0x0004,0x2A5F};
pascal void Environs(short *rom,short *machine);
pascal void Restart(void);
pascal short RelString(const Str255 str1,const Str255 str2,Boolean caseSens,
	Boolean diacSens);
short relstring(char *str1,char *str2,Boolean caseSens,Boolean diacSens);
pascal OSErr HandToHand(Handle *theHndl);
pascal OSErr PtrToXHand(Ptr srcPtr,Handle dstHndl,long size);
pascal OSErr PtrToHand(Ptr srcPtr,Handle *dstHndl,long size);
pascal OSErr HandAndHand(Handle hand1,Handle hand2);
pascal OSErr PtrAndHand(Ptr ptr1,Handle hand2,long size);
pascal OSErr InitUtil(void)
	= {0xA03F,0x3E80};
pascal Boolean SwapInstructionCache(Boolean cacheEnable);
pascal void FlushInstructionCache(void);
pascal Boolean SwapDataCache(Boolean cacheEnable);
pascal void FlushDataCache(void);
#ifdef __cplusplus
}
#endif

#endif
