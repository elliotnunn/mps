/************************************************************

Created: Monday, September 18, 1989 at 8:11 PM
    MIDI.h
    C Interface to the Macintosh Libraries


    
       
        Author: John Worthington, Don Marsh, Mark Lentczner
        Copyright © 1988, Apple Computer, Inc.
        All Rights Reserved
     

************************************************************/


#ifndef __MIDI__
#define __MIDI__

#ifndef __TYPES__
#include <Types.h>
#endif

#define midiToolNum 4                   /*tool number of MIDI Manager for SndDispVersion call*/
#define midiMaxNameLen 31               /*maximum number of characters in port and client names*/

/* Time formats */

#define midiFormatMSec 0                /*milliseconds*/
#define midiFormatBeats 1               /*beats*/
#define midiFormat24fpsBit 2            /*24 frames/sec.*/
#define midiFormat25fpsBit 3            /*25 frames/sec.*/
#define midiFormat30fpsDBit 4           /*30 frames/sec. drop-frame*/
#define midiFormat30fpsBit 5            /*30 frames/sec.*/
#define midiFormat24fpsQF 6             /*24 frames/sec. longInt format */
#define midiFormat25fpsQF 7             /*25 frames/sec. longInt format */
#define midiFormat30fpsDQF 8            /*30 frames/sec. drop-frame longInt format */
#define midiFormat30fpsQF 9             /*30 frames/sec. longInt format */
#define midiInternalSync 0              /*internal sync*/
#define midiExternalSync 1              /*external sync*/

/*  Port types */

#define midiPortTypeTime 0              /*time port*/
#define midiPortTypeInput 1             /*input port*/
#define midiPortTypeOutput 2            /*output port*/
#define midiPortTypeTimeInv 3           /*invisible time port*/

/* OffsetTimes  */

#define midiGetEverything 0x7FFFFFFF    /*get all packets, regardless of time stamps*/
#define midiGetNothing 0x80000000       /*get no packets, regardless of time stamps*/
#define midiGetCurrent 0x00000000       /*get current packets only*/

/*     MIDI data and messages are passed in MIDIPacket records (see below).
    The first byte of every MIDIPacket contains a set of flags
   
    bits 0-1    00 = new MIDIPacket, not continued
                     01 = begining of continued MIDIPacket
                     10 = end of continued MIDIPacket
                    11 = continuation
    bits 2-3     reserved
  
    bits 4-6      000 = packet contains MIDI data
   
                     001 = packet contains MIDI Manager message
   
    bit 7              0 = MIDIPacket has valid stamp
                        1 = stamp with current clock */

#define midiContMask 0x03
#define midiNoCont 0x00
#define midiStartCont 0x01
#define midiMidCont 0x03
#define midiEndCont 0x02
#define midiTypeMask 0x70
#define midiMsgType 0x00
#define midiMgrType 0x10
#define midiTimeStampMask 0x80
#define midiTimeStampCurrent 0x80
#define midiTimeStampValid 0x00

/*     MIDI Manager MIDIPacket command words (the first word in the data field
    for midiMgrType messages) */

#define midiOverflowErr 0x0001
#define midiSCCErr 0x0002
#define midiPacketErr 0x0003
#define midiMaxErr 0x00FF               /*all command words less than this value  are error indicators*/

/* Valid results to be returned by readHooks  */

#define midiKeepPacket 0
#define midiMorePacket 1
#define midiNoMorePacket 2

/*  Errors: */

#define midiNoClientErr -250            /*no client with that ID found*/
#define midiNoPortErr -251              /*no port with that ID found*/
#define midiTooManyPortsErr -252        /*too many ports already installed in the system*/
#define midiTooManyConsErr -253         /*too many connections made*/
#define midiVConnectErr -254            /*pending virtual connection created*/
#define midiVConnectMade -255           /*pending virtual connection resolved*/
#define midiVConnectRmvd -256           /*pending virtual connection removed*/
#define midiNoConErr -257               /*no connection exists between specified ports*/
#define midiWriteErr -258               /*MIDIWritePacket couldn't write to all connected ports*/
#define midiNameLenErr -259             /*name supplied is longer than 31 characters*/
#define midiDupIDErr -260               /*duplicate client ID*/
#define midiInvalidCmdErr -261          /*command not supported for port type*/

/*      Driver calls: */

#define midiOpenDriver 1
#define midiCloseDriver 2

struct MIDIPacket {
    unsigned char flags;
    unsigned char len;
    long tStamp;
    unsigned char data[249];
};

typedef struct MIDIPacket MIDIPacket;
typedef MIDIPacket *MIDIPacketPtr;

struct MIDIClkInfo {
    short sync;                         /*synchronization external/internal*/
    long curTime;                       /*current value of port's clock*/
    short format;                       /*time code format*/
};

typedef struct MIDIClkInfo MIDIClkInfo;
struct MIDIIDRec {
    OSType clientID;
    OSType portID;
};

typedef struct MIDIIDRec MIDIIDRec;
struct MIDIPortInfo {
    short portType;                     /*type of port*/
    MIDIIDRec timeBase;                 /*MIDIIDRec for time base*/
    short numConnects;                  /*number of connections*/
    MIDIIDRec cList[];                  /*ARRAY [1..numConnects] of MIDIIDRec*/
};

typedef struct MIDIPortInfo MIDIPortInfo;
typedef MIDIPortInfo *MIDIPortInfoPtr, **MIDIPortInfoHdl;

struct MIDIPortParams {
    OSType portID;                      /*ID of port, unique within client*/
    short portType;                     /*Type of port - input, output, time, etc.*/
    short timeBase;                     /*refnum of time base, 0 if none*/
    long offsetTime;                    /*offset for current time stamps*/
    Ptr readHook;                       /*routine to call when input data is valid*/
    long refCon;                        /*refcon for port (for client use)*/
    MIDIClkInfo initClock;              /*initial settings for a time base*/
    Str255 name;                        /*name of the port, This is a real live string, not a ptr.*/
};

typedef struct MIDIPortParams MIDIPortParams;
typedef MIDIPortParams *MIDIPortParamsPtr;

struct MIDIIDList {
    short numIDs;
    OSType list[];
};

typedef struct MIDIIDList MIDIIDList;
typedef MIDIIDList *MIDIIDListPtr, **MIDIIDListHdl;

#ifdef __cplusplus
extern "C" {
#endif

/* 
     Prototype Declarations for readHook and timeProc
     
     extern pascal short myReadHook(MIDIPacketPtr myPacket, long myRefCon);
     extern pascal void myTimeProc(long curTime, long myRefCon);
    
     MIDI Manager Routines
*/

pascal long SndDispVersion(short toolnum); 
pascal OSErr MIDISignIn(OSType clientID,long refCon,Handle icon,const Str255 name)
    = {0x203C,0x0004,midiToolNum,0xA800}; 
pascal void MIDISignOut(OSType clientID)
    = {0x203C,0x0008,midiToolNum,0xA800}; 
pascal MIDIIDListHdl MIDIGetClients(void)
    = {0x203C,0x000C,midiToolNum,0xA800}; 
pascal void MIDIGetClientName(OSType clientID,const Str255 name)
    = {0x203C,0x0010,midiToolNum,0xA800}; 
pascal void MIDISetClientName(OSType clientID,const Str255 name)
    = {0x203C,0x0014,midiToolNum,0xA800}; 
pascal MIDIIDListHdl MIDIGetPorts(OSType clientID)
    = {0x203C,0x0018,midiToolNum,0xA800}; 
pascal OSErr MIDIAddPort(OSType clientID,short BufSize,short *refnum,MIDIPortParamsPtr init)
    = {0x203C,0x001C,midiToolNum,0xA800}; 
pascal MIDIPortInfoHdl MIDIGetPortInfo(OSType clientID,OSType portID)
    = {0x203C,0x0020,midiToolNum,0xA800}; 
pascal OSErr MIDIConnectData(OSType srcClID,OSType srcPortID,OSType dstClID,
    OSType dstPortID)
    = {0x203C,0x0024,midiToolNum,0xA800}; 
pascal OSErr MIDIUnConnectData(OSType srcClID,OSType srcPortID,OSType dstClID,
    OSType dstPortID)
    = {0x203C,0x0028,midiToolNum,0xA800}; 
pascal OSErr MIDIConnectTime(OSType srcClID,OSType srcPortID,OSType dstClID,
    OSType dstPortID)
    = {0x203C,0x002C,midiToolNum,0xA800}; 
pascal OSErr MIDIUnConnectTime(OSType srcClID,OSType srcPortID,OSType dstClID,
    OSType dstPortID)
    = {0x203C,0x0030,midiToolNum,0xA800}; 
pascal void MIDIFlush(short refnum)
    = {0x203C,0x0034,midiToolNum,0xA800}; 
pascal ProcPtr MIDIGetReadHook(short refnum)
    = {0x203C,0x0038,midiToolNum,0xA800}; 
pascal void MIDISetReadHook(short refnum,ProcPtr hook)
    = {0x203C,0x003C,midiToolNum,0xA800}; 
pascal void MIDIGetPortName(OSType clientID,OSType portID,const Str255 name)
    = {0x203C,0x0040,midiToolNum,0xA800}; 
pascal void MIDISetPortName(OSType clientID,OSType portID,const Str255 name)
    = {0x203C,0x0044,midiToolNum,0xA800}; 
pascal void MIDIWakeUp(short refnum,long time,long period,ProcPtr timeProc)
    = {0x203C,0x0048,midiToolNum,0xA800}; 
pascal void MIDIRemovePort(short refnum)
    = {0x203C,0x004C,midiToolNum,0xA800}; 
pascal short MIDIGetSync(short refnum)
    = {0x203C,0x0050,midiToolNum,0xA800}; 
pascal void MIDISetSync(short refnum,short sync)
    = {0x203C,0x0054,midiToolNum,0xA800}; 
pascal long MIDIGetCurTime(short refnum)
    = {0x203C,0x0058,midiToolNum,0xA800}; 
pascal void MIDISetCurTime(short refnum,long time)
    = {0x203C,0x005C,midiToolNum,0xA800}; 
pascal void MIDIStartTime(short refnum)
    = {0x203C,0x0060,midiToolNum,0xA800}; 
pascal void MIDIStopTime(short refnum)
    = {0x203C,0x0064,midiToolNum,0xA800}; 
pascal void MIDIPoll(short refnum,long offsetTime)
    = {0x203C,0x0068,midiToolNum,0xA800}; 
pascal OSErr MIDIWritePacket(short refnum,MIDIPacketPtr packet)
    = {0x203C,0x006C,midiToolNum,0xA800}; 
pascal Boolean MIDIWorldChanged(OSType clientID)
    = {0x203C,0x0070,midiToolNum,0xA800}; 
pascal long MIDIGetOffsetTime(short refnum)
    = {0x203C,0x0074,midiToolNum,0xA800}; 
pascal void MIDISetOffsetTime(short refnum,long offsetTime)
    = {0x203C,0x0078,midiToolNum,0xA800}; 
pascal long MIDIConvertTime(short srcformat,short dstformat,long time)
    = {0x203C,0x007C,midiToolNum,0xA800}; 
pascal long MIDIGetRefCon(short refnum)
    = {0x203C,0x0080,midiToolNum,0xA800}; 
pascal void MIDISetRefCon(short refnum,long refCon)
    = {0x203C,0x0084,midiToolNum,0xA800}; 
pascal long MIDIGetClRefCon(OSType clientID)
    = {0x203C,0x0088,midiToolNum,0xA800}; 
pascal void MIDISetClRefCon(OSType clientID,long refCon)
    = {0x203C,0x008C,midiToolNum,0xA800}; 
pascal short MIDIGetTCFormat(short refnum)
    = {0x203C,0x0090,midiToolNum,0xA800}; 
pascal void MIDISetTCFormat(short refnum,short format)
    = {0x203C,0x0094,midiToolNum,0xA800}; 
pascal void MIDISetRunRate(short refnum,short rate,long time)
    = {0x203C,0x0098,midiToolNum,0xA800}; 
pascal Handle MIDIGetClientIcon(OSType clientID)
    = {0x203C,0x009C,midiToolNum,0xA800}; 
#ifdef __cplusplus
}
#endif

#endif
