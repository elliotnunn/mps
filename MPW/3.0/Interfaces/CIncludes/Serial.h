/************************************************************

Created: Tuesday, October 4, 1988 at 9:17 PM
    Serial.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __SERIAL__
#define __SERIAL__

#ifndef __TYPES__
#include <Types.h>
#endif

#define baud300 380
#define baud600 189
#define baud1200 94
#define baud1800 62
#define baud2400 46
#define baud3600 30
#define baud4800 22
#define baud7200 14
#define baud9600 10
#define baud19200 4
#define baud57600 0
#define stop10 16384
#define stop15 -32768
#define stop20 -16384
#define noParity 0
#define oddParity 4096
#define evenParity 12288
#define data5 0
#define data6 2048
#define data7 1024
#define data8 3072
#define ctsEvent 32
#define breakEvent 128
#define xOffWasSent 128
#define dtrNegated 64
#define ainRefNum -6        /*serial port A input*/
#define aoutRefNum -7       /*serial port A output*/
#define binRefNum -8        /*serial port B input*/
#define boutRefNum -9       /*serial port B output*/

enum {sPortA,sPortB};
typedef unsigned char SPortSel;

struct SerShk {
    char fXOn;              /*XOn flow control enabled flag*/
    char fCTS;              /*CTS flow control enabled flag*/
    unsigned char xOn;      /*XOn character*/
    unsigned char xOff;     /*XOff character*/
    char errs;              /*errors mask bits*/
    char evts;              /*event enable mask bits*/
    char fInX;              /*Input flow control enabled flag*/
    char fDTR;              /*DTR input flow control flag*/
};

#ifndef __cplusplus
typedef struct SerShk SerShk;
#endif

struct SerStaRec {
    char cumErrs;
    char xOffSent;
    char rdPend;
    char wrPend;
    char ctsHold;
    char xOffHold;
};

#ifndef __cplusplus
typedef struct SerStaRec SerStaRec;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal OSErr RamSDOpen(SPortSel whichPort); 
pascal void RamSDClose(SPortSel whichPort); 
pascal OSErr SerReset(short refNum,short serConfig); 
pascal OSErr SerSetBuf(short refNum,Ptr serBPtr,short serBLen); 
pascal OSErr SerHShake(short refNum,const SerShk *flags); 
pascal OSErr SerSetBrk(short refNum); 
pascal OSErr SerClrBrk(short refNum); 
pascal OSErr SerGetBuf(short refNum,long *count); 
pascal OSErr SerStatus(short refNum,SerStaRec *serSta); 
#ifdef __safe_link
}
#endif

#endif
