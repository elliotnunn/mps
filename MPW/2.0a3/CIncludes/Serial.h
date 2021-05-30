/*
	Serial.h - Serial Driver

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

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
#define stop15 (-32768)
#define stop20 (-16384)
#define noParity 0
#define oddParity 4096
#define evenParity 12288
#define data5 0
#define data6 2048
#define data7 1024
#define data8 3072
#define ctsEvent 32
#define breakEvent 128
#define xOffWasSent 0x80
#define dtrNegated 0x40
typedef enum {
	sPortA,
	sPortB
} SPortSel;
typedef struct SerShk {
	char fXOn;
	char fCTS;
	unsigned char xOn;
	unsigned char xOff;
	char errs;
	char evts;
	char fInX;
	char fDTR;
} SerShk;
typedef struct SerStaRec {
	char cumErrs;
	char xOffSent;
	char rdPend;
	char wrPend;
	char ctsHold;
	char xOffHold;
} SerStaRec;
#endif
