/*
 	File:		Serial.h
 
 	Contains:	Asynchronous Serial Driver (.AIn/.AOut/.BIn/.BOut) Interfaces
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __SERIAL__
#define __SERIAL__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	baud150						= 763,
	baud300						= 380,
	baud600						= 189,
	baud1200					= 94,
	baud1800					= 62,
	baud2400					= 46,
	baud3600					= 30,
	baud4800					= 22,
	baud7200					= 14,
	baud9600					= 10,
	baud14400					= 6,
	baud19200					= 4,
	baud28800					= 2,
	baud38400					= 1,
	baud57600					= 0,
	stop10						= 16384,
	stop15						= -32768L,
	stop20						= -16384,
	noParity					= 0,
	oddParity					= 4096,
	evenParity					= 12288,
	data5						= 0,
	data6						= 2048,
	data7						= 1024,
	data8						= 3072
};

enum {
	aData						= 6,							/* channel A data in or out (historical) */
	aCtl						= 2,							/* channel A control (historical) */
	bData						= 4,							/* channel B data in or out (historical) */
	bCtl						= 0,							/* channel B control (historical) */
	ctsEvent					= 32,							/* flag for SerShk.errs and SerShk.evts */
	breakEvent					= 128,							/* flag for SerShk.errs and SerShk.evts */
	xOffWasSent					= 128,							/* flag for SerStaRec.xOffSent */
	dtrNegated					= 64,							/* flag for SerStaRec.xOffSent */
	ainRefNum					= -6,							/* serial port A input */
	aoutRefNum					= -7,							/* serial port A output */
	binRefNum					= -8,							/* serial port B input */
	boutRefNum					= -9,							/* serial port B output */
	swOverrunErr				= 1,							/* serial driver error masks */
	breakErr					= 8,							/* serial driver error masks */
	parityErr					= 16,							/* serial driver error masks */
	hwOverrunErr				= 32,							/* serial driver error masks */
	framingErr					= 64,							/* serial driver error masks */
	kOptionClockX1CTS			= 64,							/* option bit used with Control code 16 */
	kOptionPreserveDTR			= 128							/* option bit used with Control code 16 */
};

enum {
	sPortA						= 0,
	sPortB						= 1
};

typedef SInt8 SPortSel;

/* csCodes for serial driver Control routines */

enum {
	kSERDConfiguration			= 8,							/* program port speed, bits/char, parity, and stop bits */
	kSERDInputBuffer			= 9,							/* set buffer for chars received with no read pending */
	kSERDSerHShake				= 10,							/* equivalent to SerHShake, largely obsolete */
	kSERDClearBreak				= 11,							/* assert break signal on output */
	kSERDSetBreak				= 12,							/* negate break state on output */
	kSERDBaudRate				= 13,							/* set explicit baud rate, other settings unchanged */
	kSERDHandshake				= 14,							/* superset of 10, honors setting of fDTR */
	kSERDClockMIDI				= 15,							/* clock externally on CTS with specified multiplier */
	kSERDMiscOptions			= 16,							/* select clock source and DTR behavior on close */
	kSERDAssertDTR				= 17,							/* assert DTR output */
	kSERDNegateDTR				= 18,							/* negate DTR output */
	kSERDSetPEChar				= 19,							/* select char to replace chars with invalid parity */
	kSERDSetPEAltChar			= 20,							/* select char to replace char that replaces chars with invalid parity */
	kSERDSetXOffFlag			= 21,							/* set XOff output flow control (same as receiving XOff) */
	kSERDClearXOffFlag			= 22,							/* clear XOff output flow control (same as receiving XOn) */
	kSERDSendXOn				= 23,							/* send XOn if input flow control state is XOff */
	kSERDSendXOnOut				= 24,							/* send XOn regardless of input flow control state */
	kSERDSendXOff				= 25,							/* send XOff if input flow control state is XOn */
	kSERDSendXOffOut			= 26,							/* send XOff regardless of input flow control state */
	kSERDResetChannel			= 27,							/* reset serial I/O channel hardware */
	kSERD115KBaud				= 115,							/* set 115.2K baud data rate (some driver versions) */
	kSERD230KBaud				= 230							/* set 230.4K baud data rate (some driver versions) */
};

/* csCodes for serial driver Status routines */

enum {
	kSERDInputCount				= 2,							/* return characters available (SerGetBuf) */
	kSERDStatus					= 8,							/* return characters available (SerStatus) */
	kSERDVersion				= 9								/* return version number in first byte of csParam */
};

struct SerShk {
	Byte 							fXOn;						/* XOn flow control enabled flag */
	Byte 							fCTS;						/* CTS flow control enabled flag */
	unsigned char 					xOn;						/* XOn character */
	unsigned char 					xOff;						/* XOff character */
	Byte 							errs;						/* errors mask bits */
	Byte 							evts;						/* event enable mask bits */
	Byte 							fInX;						/* Input flow control enabled flag */
	Byte 							fDTR;						/* DTR input flow control flag */
};
typedef struct SerShk SerShk;

struct SerStaRec {
	Byte 							cumErrs;					/* errors accumulated since last SerStatus() call */
	Byte 							xOffSent;					/* input (requested to be) held off by xOffWasSent or dtrNegated */
	Byte 							rdPend;						/* incomplete read pending in I/O queue */
	Byte 							wrPend;						/* incomplete write pending in I/O queue */
	Byte 							ctsHold;					/* transmit disabled by hardware handshaking */
	Byte 							xOffHold;					/* transmit disabled by XOn/XOff handshaking */
};
typedef struct SerStaRec SerStaRec;

#if OLDROUTINENAMES

/* ********************************************************************************************* */
/* The following constant names have been retired in favor of standard, more descriptive names.  */
/* You can still compile old code by defining OLDROUTINENAMES. There were several constants that */
/* were formerly available that have been removed, as they are now regarded as either private or */
/* unsupported. We advise that you stop using any constants that are not defined in this file.   */
/* ********************************************************************************************* */

enum {
	serdOptionClockExternal		= kOptionClockX1CTS,		/* option bit used with Control code 16 */
	serdOptionPreserveDTR		= kOptionPreserveDTR		/* option bit used with Control code 16 */
};

/* csCodes for serial driver Control routines */
enum {
	serdReset					= kSERDConfiguration,
	serdSetBuf					= kSERDInputBuffer,
	serdHShake					= kSERDSerHShake,
	serdClrBrk					= kSERDClearBreak,
	serdSetBrk					= kSERDSetBreak,
	serdSetBaud					= kSERDBaudRate,
	serdHShakeDTR				= kSERDHandshake,
	serdSetMIDI					= kSERDClockMIDI,
	serdSetMisc					= kSERDMiscOptions,
	serdSetDTR					= kSERDAssertDTR,
	serdClrDTR					= kSERDNegateDTR,
	
	serdSetPEChar				= kSERDSetPEChar,
	serdSetPECharAlternate		= kSERDSetPEAltChar,
	
	serdSetXOff					= kSERDSetXOffFlag,
	serdClrXOff					= kSERDClearXOffFlag,
	serdSendXOnConditional		= kSERDSendXOn,
	serdSendXOn					= kSERDSendXOnOut,
	serdSendXOffConditional		= kSERDSendXOff,
	serdSendXOff				= kSERDSendXOffOut,
	
	serdChannelReset			= kSERDResetChannel,
	
	serdSet230KBaud				= kSERD230KBaud			/* set 230K baud data rate */
};


/* csCodes for serial driver Status routines */
enum {
	serdGetBuf					= kSERDInputCount,
	serdStatus					= kSERDStatus,
	serdGetVers					= kSERDVersion
};

#endif	/* OLDROUTINENAMES */


extern pascal OSErr SerReset(short refNum, short serConfig);
extern pascal OSErr SerSetBuf(short refNum, Ptr serBPtr, short serBLen);
extern pascal OSErr SerHShake(short refNum, const SerShk *flags);
extern pascal OSErr SerSetBrk(short refNum);
extern pascal OSErr SerClrBrk(short refNum);
extern pascal OSErr SerGetBuf(short refNum, long *count);
extern pascal OSErr SerStatus(short refNum, SerStaRec *serSta);


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SERIAL__ */
