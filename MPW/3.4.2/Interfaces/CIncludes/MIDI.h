/*
 	File:		MIDI.h
 
 	Contains:	MIDI Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __MIDI__
#define __MIDI__


#ifndef __ERRORS__
#include <Errors.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*
						* * *  N O T E  * * * 

	This file has been updated to include MIDI 2.0 interfaces.  
	
	The MIDI 2.0 interfaces were developed for the classic 68K runtime.
	Since then, Apple has created the PowerPC and CFM 68K runtimes.
	Currently, the extra functions in MIDI 2.0 are not in InterfaceLib
	and thus not callable from PowerPC and CFM 68K runtimes (you'll
	get a linker error).  
*/

enum {
	midiMaxNameLen				= 31,							/*maximum number of characters in port and client names*/
/* Time formats */
	midiFormatMSec				= 0,							/*milliseconds*/
	midiFormatBeats				= 1,							/*beats*/
	midiFormat24fpsBit			= 2,							/*24 frames/sec.*/
	midiFormat25fpsBit			= 3,							/*25 frames/sec.*/
	midiFormat30fpsDBit			= 4,							/*30 frames/sec. drop-frame*/
	midiFormat30fpsBit			= 5,							/*30 frames/sec.*/
	midiFormat24fpsQF			= 6,							/*24 frames/sec. longInt format */
	midiFormat25fpsQF			= 7,							/*25 frames/sec. longInt format */
	midiFormat30fpsDQF			= 8,							/*30 frames/sec. drop-frame longInt format */
	midiFormat30fpsQF			= 9,							/*30 frames/sec. longInt format */
	midiInternalSync			= 0,							/*internal sync*/
	midiExternalSync			= 1,							/*external sync*/
/* Port types*/
	midiPortTypeTime			= 0,							/*time port*/
	midiPortTypeInput			= 1,							/*input port*/
	midiPortTypeOutput			= 2,							/*output port*/
	midiPortTypeTimeInv			= 3,							/*invisible time port*/
	midiPortInvisible			= 0x8000,						/*logical OR this to other types to make invisible ports*/
	midiPortTypeMask			= 0x0007,						/*logical AND with this to convert new port types to old,
									  ie. to strip the property bits*/
/* OffsetTimes  */
	midiGetEverything			= 0x7FFFFFFF,					/*get all packets, regardless of time stamps*/
	midiGetNothing				= 0x80000000L,					/*get no packets, regardless of time stamps*/
	midiGetCurrent				= 0x00000000					/*get current packets only*/
};

/*    MIDI data and messages are passed in MIDIPacket records (see below).
    The first byte of every MIDIPacket contains a set of flags

    bits 0-1    00 = new MIDIPacket, not continued
                     01 = begining of continued MIDIPacket
                     10 = end of continued MIDIPacket
                     11 = continuation
    bits 2-3     reserved

    bits 4-6      000 = packet contains MIDI data

                  001 = packet contains MIDI Manager message

    bit 7         0 = MIDIPacket has valid stamp
                  1 = stamp with current clock
*/
enum {
	midiContMask				= 0x03,
	midiNoCont					= 0x00,
	midiStartCont				= 0x01,
	midiMidCont					= 0x03,
	midiEndCont					= 0x02,
	midiTypeMask				= 0x70,
	midiMsgType					= 0x00,
	midiMgrType					= 0x10,
	midiTimeStampMask			= 0x80,
	midiTimeStampCurrent		= 0x80,
	midiTimeStampValid			= 0x00,
/* MIDIPacket command words (the first word in the data field for midiMgrType messages) */
	midiOverflowErr				= 0x0001,
	midiSCCErr					= 0x0002,
	midiPacketErr				= 0x0003,
/*all command words less than this value are error indicators*/
	midiMaxErr					= 0x00FF,
/* Valid results to be returned by readHooks */
	midiKeepPacket				= 0,
	midiMorePacket				= 1,
	midiNoMorePacket			= 2,
	midiHoldPacket				= 3,
/* Driver calls */
	midiOpenDriver				= 1,
	midiCloseDriver				= 2
};

enum {
	mdvrAbortNotesOff			= 0,							/*abort previous mdvrNotesOff request*/
	mdvrChanNotesOff			= 1,							/*generate channel note off messages*/
	mdvrAllNotesOff				= 2,							/*generate all note off messages*/
	mdvrStopOut					= 0,							/*stop calling MDVROut temporarily*/
	mdvrStartOut				= 1								/*resume calling MDVROut*/
};

struct MIDIPacket {
	UInt8							flags;
	UInt8							len;
	long							tStamp;
	UInt8							data[249];
};
typedef struct MIDIPacket MIDIPacket;

typedef MIDIPacket *MIDIPacketPtr;

typedef pascal short (*MIDIReadHookProcPtr)(MIDIPacketPtr myPacket, long myRefCon);
typedef pascal void (*MIDITimeProcPtr)(long curTime, long myRefCon);
typedef pascal void (*MIDIConnectionProcPtr)(short refnum, long refcon, short portType, OSType clientID, OSType portID, Boolean connect, short direction);
typedef pascal long (*MDVRCommProcPtr)(short refnum, short request, long refCon);
typedef pascal void (*MDVRTimeCodeProcPtr)(short refnum, short newFormat, long refCon);
typedef pascal void (*MDVRReadProcPtr)(char *midiChars, short length, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr MIDIReadHookUPP;
typedef UniversalProcPtr MIDITimeUPP;
typedef UniversalProcPtr MIDIConnectionUPP;
typedef UniversalProcPtr MDVRCommUPP;
typedef UniversalProcPtr MDVRTimeCodeUPP;
typedef UniversalProcPtr MDVRReadUPP;
#else
typedef MIDIReadHookProcPtr MIDIReadHookUPP;
typedef MIDITimeProcPtr MIDITimeUPP;
typedef MIDIConnectionProcPtr MIDIConnectionUPP;
typedef MDVRCommProcPtr MDVRCommUPP;
typedef MDVRTimeCodeProcPtr MDVRTimeCodeUPP;
typedef MDVRReadProcPtr MDVRReadUPP;
#endif

struct MIDIClkInfo {
	short							syncType;					/*synchronization external/internal*/
	long							curTime;					/*current value of port's clock*/
	short							format;						/*time code format*/
};
typedef struct MIDIClkInfo MIDIClkInfo;

struct MIDIIDRec {
	OSType							clientID;
	OSType							portID;
};
typedef struct MIDIIDRec MIDIIDRec;

struct MIDIPortInfo {
	short							portType;					/*type of port*/
	MIDIIDRec						timeBase;					/*MIDIIDRec for time base*/
	short							numConnects;				/*number of connections*/
	MIDIIDRec						cList[1];					/*ARRAY [1..numConnects] of MIDIIDRec*/
};
typedef struct MIDIPortInfo MIDIPortInfo;

typedef MIDIPortInfo *MIDIPortInfoPtr, **MIDIPortInfoHdl, **MIDIPortInfoHandle;

struct MIDIPortParams {
	OSType							portID;						/*ID of port, unique within client*/
	short							portType;					/*Type of port - input, output, time, etc.*/
	short							timeBase;					/*refnum of time base, 0 if none*/
	long							offsetTime;					/*offset for current time stamps*/
	MIDIReadHookUPP					readHook;					/*routine to call when input data is valid*/
	long							refCon;						/*refcon for port (for client use)*/
	MIDIClkInfo						initClock;					/*initial settings for a time base*/
	Str255							name;						/*name of the port, This is a real live string, not a ptr.*/
};
typedef struct MIDIPortParams MIDIPortParams;

typedef MIDIPortParams *MIDIPortParamsPtr;

struct MIDIIDList {
	short							numIDs;
	OSType							list[1];
};
typedef struct MIDIIDList MIDIIDList;

typedef MIDIIDList *MIDIIDListPtr, **MIDIIDListHdl, **MIDIIDListHandle;

/* MDVR Control structs*/
struct MDVRInCtlRec {
	short							timeCodeClock;				/*refnum of time base for time code*/
	short							timeCodeFormat;				/*format of time code output*/
	MDVRReadUPP						readProc;					/*proc to call with intput characters*/
	MDVRCommUPP						commProc;					/*proc to call for handshaking*/
	long							refCon;						/*refCon passed to readProc, commProc*/
};
typedef struct MDVRInCtlRec *MDVRInCtlPtr;

struct MDVROutCtlRec {
	short							timeCodeClock;				/*time base driven by time code*/
	short							timeCodeFormat;				/*format of time code to listen to*/
	MDVRTimeCodeUPP					timeCodeProc;				/*proc called on time code fmt change*/
	MDVRCommUPP						commProc;					/*proc called for handshaking*/
	long							refCon;						/*refCon passed to timeCodeProc*/
	Boolean							timeCodeFilter;				/*filter time code if true*/
	UInt8							padding;					/*unused pad byte*/
	long							midiMsgTicks;				/*value of Ticks when MIDI msg rcvd*/
	long							timeCodeTicks;				/*value of Ticks when time code rcvd*/
};
typedef struct MDVROutCtlRec *MDVROutCtlPtr;

typedef void *MDVRPtr;

extern pascal NumVersion MIDIVersion(void)
 FOURWORDINLINE(0x203C, 0x0000, 4, 0xA800);
extern pascal OSErr MIDISignIn(OSType clientID, long refCon, Handle icon, ConstStr255Param name)
 FOURWORDINLINE(0x203C, 0x0004, 4, 0xA800);
extern pascal void MIDISignOut(OSType clientID)
 FOURWORDINLINE(0x203C, 0x0008, 4, 0xA800);
extern pascal MIDIIDListHandle MIDIGetClients(void)
 FOURWORDINLINE(0x203C, 0x000C, 4, 0xA800);
extern pascal void MIDIGetClientName(OSType clientID, Str255 name)
 FOURWORDINLINE(0x203C, 0x0010, 4, 0xA800);
extern pascal void MIDISetClientName(OSType clientID, ConstStr255Param name)
 FOURWORDINLINE(0x203C, 0x0014, 4, 0xA800);
extern pascal MIDIIDListHandle MIDIGetPorts(OSType clientID)
 FOURWORDINLINE(0x203C, 0x0018, 4, 0xA800);
extern pascal OSErr MIDIAddPort(OSType clientID, short BufSize, short *refnum, MIDIPortParamsPtr init)
 FOURWORDINLINE(0x203C, 0x001C, 4, 0xA800);
extern pascal MIDIPortInfoHandle MIDIGetPortInfo(OSType clientID, OSType portID)
 FOURWORDINLINE(0x203C, 0x0020, 4, 0xA800);
extern pascal OSErr MIDIConnectData(OSType srcClID, OSType srcPortID, OSType dstClID, OSType dstPortID)
 FOURWORDINLINE(0x203C, 0x0024, 4, 0xA800);
extern pascal OSErr MIDIUnConnectData(OSType srcClID, OSType srcPortID, OSType dstClID, OSType dstPortID)
 FOURWORDINLINE(0x203C, 0x0028, 4, 0xA800);
extern pascal OSErr MIDIConnectTime(OSType srcClID, OSType srcPortID, OSType dstClID, OSType dstPortID)
 FOURWORDINLINE(0x203C, 0x002C, 4, 0xA800);
extern pascal OSErr MIDIUnConnectTime(OSType srcClID, OSType srcPortID, OSType dstClID, OSType dstPortID)
 FOURWORDINLINE(0x203C, 0x0030, 4, 0xA800);
extern pascal void MIDIFlush(short refnum)
 FOURWORDINLINE(0x203C, 0x0034, 4, 0xA800);
extern pascal ProcPtr MIDIGetReadHook(short refnum)
 FOURWORDINLINE(0x203C, 0x0038, 4, 0xA800);
extern pascal void MIDISetReadHook(short refnum, ProcPtr hook)
 FOURWORDINLINE(0x203C, 0x003C, 4, 0xA800);
extern pascal void MIDIGetPortName(OSType clientID, OSType portID, Str255 name)
 FOURWORDINLINE(0x203C, 0x0040, 4, 0xA800);
extern pascal void MIDISetPortName(OSType clientID, OSType portID, ConstStr255Param name)
 FOURWORDINLINE(0x203C, 0x0044, 4, 0xA800);
extern pascal void MIDIWakeUp(short refnum, long time, long period, MIDITimeUPP timeProc)
 FOURWORDINLINE(0x203C, 0x0048, 4, 0xA800);
extern pascal void MIDIRemovePort(short refnum)
 FOURWORDINLINE(0x203C, 0x004C, 4, 0xA800);
extern pascal short MIDIGetSync(short refnum)
 FOURWORDINLINE(0x203C, 0x0050, 4, 0xA800);
extern pascal void MIDISetSync(short refnum, short sync)
 FOURWORDINLINE(0x203C, 0x0054, 4, 0xA800);
extern pascal long MIDIGetCurTime(short refnum)
 FOURWORDINLINE(0x203C, 0x0058, 4, 0xA800);
extern pascal void MIDISetCurTime(short refnum, long time)
 FOURWORDINLINE(0x203C, 0x005C, 4, 0xA800);
extern pascal void MIDIStartTime(short refnum)
 FOURWORDINLINE(0x203C, 0x0060, 4, 0xA800);
extern pascal void MIDIStopTime(short refnum)
 FOURWORDINLINE(0x203C, 0x0064, 4, 0xA800);
extern pascal void MIDIPoll(short refnum, long offsetTime)
 FOURWORDINLINE(0x203C, 0x0068, 4, 0xA800);
extern pascal OSErr MIDIWritePacket(short refnum, MIDIPacketPtr packet)
 FOURWORDINLINE(0x203C, 0x006C, 4, 0xA800);
extern pascal Boolean MIDIWorldChanged(OSType clientID)
 FOURWORDINLINE(0x203C, 0x0070, 4, 0xA800);
extern pascal long MIDIGetOffsetTime(short refnum)
 FOURWORDINLINE(0x203C, 0x0074, 4, 0xA800);
extern pascal void MIDISetOffsetTime(short refnum, long offsetTime)
 FOURWORDINLINE(0x203C, 0x0078, 4, 0xA800);
extern pascal long MIDIConvertTime(short srcFormat, short dstFormat, long time)
 FOURWORDINLINE(0x203C, 0x007C, 4, 0xA800);
extern pascal long MIDIGetRefCon(short refnum)
 FOURWORDINLINE(0x203C, 0x0080, 4, 0xA800);
extern pascal void MIDISetRefCon(short refnum, long refCon)
 FOURWORDINLINE(0x203C, 0x0084, 4, 0xA800);
extern pascal long MIDIGetClRefCon(OSType clientID)
 FOURWORDINLINE(0x203C, 0x0088, 4, 0xA800);
extern pascal void MIDISetClRefCon(OSType clientID, long refCon)
 FOURWORDINLINE(0x203C, 0x008C, 4, 0xA800);
extern pascal short MIDIGetTCFormat(short refnum)
 FOURWORDINLINE(0x203C, 0x0090, 4, 0xA800);
extern pascal void MIDISetTCFormat(short refnum, short format)
 FOURWORDINLINE(0x203C, 0x0094, 4, 0xA800);
extern pascal void MIDISetRunRate(short refnum, short rate, long time)
 FOURWORDINLINE(0x203C, 0x0098, 4, 0xA800);
extern pascal Handle MIDIGetClientIcon(OSType clientID)
 FOURWORDINLINE(0x203C, 0x009C, 4, 0xA800);
extern pascal ProcPtr MIDICallAddress(short callNum)
 FOURWORDINLINE(0x203C, 164, 4, 0xA800);
extern pascal void MIDISetConnectionProc(short refNum, ProcPtr connectionProc, long refCon)
 FOURWORDINLINE(0x203C, 168, 4, 0xA800);
extern pascal void MIDIGetConnectionProc(short refnum, ProcPtr *connectionProc, long *refCon)
 FOURWORDINLINE(0x203C, 172, 4, 0xA800);
extern pascal void MIDIDiscardPacket(short refnum, MIDIPacketPtr packet)
 FOURWORDINLINE(0x203C, 176, 4, 0xA800);
extern pascal OSErr MDVRSignIn(OSType clientID, long refCon, Handle icon, Str255 name)
 FOURWORDINLINE(0x203C, 180, 4, 0xA800);
extern pascal void MDVRSignOut(OSType clientID)
 FOURWORDINLINE(0x203C, 184, 4, 0xA800);
extern pascal MDVRPtr MDVROpen(short portType, short refnum)
 FOURWORDINLINE(0x203C, 188, 4, 0xA800);
extern pascal void MDVRClose(MDVRPtr driverPtr)
 FOURWORDINLINE(0x203C, 192, 4, 0xA800);
extern pascal void MDVRControlIn(MDVRPtr portPtr, MDVRInCtlPtr inputCtl)
 FOURWORDINLINE(0x203C, 196, 4, 0xA800);
extern pascal void MDVRControlOut(MDVRPtr portPtr, MDVROutCtlPtr outputCtl)
 FOURWORDINLINE(0x203C, 200, 4, 0xA800);
extern pascal void MDVRIn(MDVRPtr portPtr)
 FOURWORDINLINE(0x203C, 204, 4, 0xA800);
extern pascal void MDVROut(MDVRPtr portPtr, char *dataPtr, short length)
 FOURWORDINLINE(0x203C, 208, 4, 0xA800);
extern pascal void MDVRNotesOff(MDVRPtr portPtr, short mode)
 FOURWORDINLINE(0x203C, 212, 4, 0xA800);
enum {
	uppMIDIReadHookProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(MIDIPacketPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppMIDITimeProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppMIDIConnectionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(OSType)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(OSType)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(short))),
	uppMDVRCommProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppMDVRTimeCodeProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppMDVRReadProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(char*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewMIDIReadHookProc(userRoutine)		\
		(MIDIReadHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMIDIReadHookProcInfo, GetCurrentArchitecture())
#define NewMIDITimeProc(userRoutine)		\
		(MIDITimeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMIDITimeProcInfo, GetCurrentArchitecture())
#define NewMIDIConnectionProc(userRoutine)		\
		(MIDIConnectionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMIDIConnectionProcInfo, GetCurrentArchitecture())
#define NewMDVRCommProc(userRoutine)		\
		(MDVRCommUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMDVRCommProcInfo, GetCurrentArchitecture())
#define NewMDVRTimeCodeProc(userRoutine)		\
		(MDVRTimeCodeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMDVRTimeCodeProcInfo, GetCurrentArchitecture())
#define NewMDVRReadProc(userRoutine)		\
		(MDVRReadUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMDVRReadProcInfo, GetCurrentArchitecture())
#else
#define NewMIDIReadHookProc(userRoutine)		\
		((MIDIReadHookUPP) (userRoutine))
#define NewMIDITimeProc(userRoutine)		\
		((MIDITimeUPP) (userRoutine))
#define NewMIDIConnectionProc(userRoutine)		\
		((MIDIConnectionUPP) (userRoutine))
#define NewMDVRCommProc(userRoutine)		\
		((MDVRCommUPP) (userRoutine))
#define NewMDVRTimeCodeProc(userRoutine)		\
		((MDVRTimeCodeUPP) (userRoutine))
#define NewMDVRReadProc(userRoutine)		\
		((MDVRReadUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallMIDIReadHookProc(userRoutine, myPacket, myRefCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMIDIReadHookProcInfo, (myPacket), (myRefCon))
#define CallMIDITimeProc(userRoutine, curTime, myRefCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMIDITimeProcInfo, (curTime), (myRefCon))
#define CallMIDIConnectionProc(userRoutine, refnum, refcon, portType, clientID, portID, connect, direction)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMIDIConnectionProcInfo, (refnum), (refcon), (portType), (clientID), (portID), (connect), (direction))
#define CallMDVRCommProc(userRoutine, refnum, request, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMDVRCommProcInfo, (refnum), (request), (refCon))
#define CallMDVRTimeCodeProc(userRoutine, refnum, newFormat, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMDVRTimeCodeProcInfo, (refnum), (newFormat), (refCon))
#define CallMDVRReadProc(userRoutine, midiChars, length, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMDVRReadProcInfo, (midiChars), (length), (refCon))
#else
#define CallMIDIReadHookProc(userRoutine, myPacket, myRefCon)		\
		(*(userRoutine))((myPacket), (myRefCon))
#define CallMIDITimeProc(userRoutine, curTime, myRefCon)		\
		(*(userRoutine))((curTime), (myRefCon))
#define CallMIDIConnectionProc(userRoutine, refnum, refcon, portType, clientID, portID, connect, direction)		\
		(*(userRoutine))((refnum), (refcon), (portType), (clientID), (portID), (connect), (direction))
#define CallMDVRCommProc(userRoutine, refnum, request, refCon)		\
		(*(userRoutine))((refnum), (request), (refCon))
#define CallMDVRTimeCodeProc(userRoutine, refnum, newFormat, refCon)		\
		(*(userRoutine))((refnum), (newFormat), (refCon))
#define CallMDVRReadProc(userRoutine, midiChars, length, refCon)		\
		(*(userRoutine))((midiChars), (length), (refCon))
#endif


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MIDI__ */
