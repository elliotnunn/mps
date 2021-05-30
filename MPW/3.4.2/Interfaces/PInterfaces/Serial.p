{
 	File:		Serial.p
 
 	Contains:	Serial port Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Serial;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SERIAL__}
{$SETC __SERIAL__ := 1}

{$I+}
{$SETC SerialIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	baud300						= 380;
	baud600						= 189;
	baud1200					= 94;
	baud1800					= 62;
	baud2400					= 46;
	baud3600					= 30;
	baud4800					= 22;
	baud7200					= 14;
	baud9600					= 10;
	baud19200					= 4;
	baud38400					= 1;
	baud57600					= 0;
	stop10						= 16384;
	stop15						= -32768;
	stop20						= -16384;
	noParity					= 0;
	oddParity					= 4096;
	evenParity					= 12288;
	data5						= 0;
	data6						= 2048;
	data7						= 1024;
	data8						= 3072;

	ctsEvent					= 32;
	breakEvent					= 128;
	xOffWasSent					= 128;
	dtrNegated					= 64;
	ainRefNum					= -6;							{serial port A input}
	aoutRefNum					= -7;							{serial port A output}
	binRefNum					= -8;							{serial port B input}
	boutRefNum					= -9;							{serial port B output}
	swOverrunErr				= 1;							{serial driver error masks}
	breakErr					= 8;							{serial driver error masks}
	parityErr					= 16;							{serial driver error masks}
	hwOverrunErr				= 32;							{serial driver error masks}
	framingErr					= 64;							{serial driver error masks}
	serdOptionClockExternal		= $40;							{option bit used with Control code 16}
	serdOptionPreserveDTR		= $80;							{option bit used with Control code 16}

	sPortA						= 0;
	sPortB						= 1;

	
TYPE
	SPortSel = SInt8;

{ csCodes for serial driver Control routines }

CONST
	serdReset					= 8;
	serdSetBuf					= 9;
	serdHShake					= 10;
	serdClrBrk					= 11;
	serdSetBrk					= 12;
	serdSetBaud					= 13;
	serdHShakeDTR				= 14;
	serdSetMIDI					= 15;
	serdSetMisc					= 16;
	serdSetDTR					= 17;
	serdClrDTR					= 18;
	serdSetPEChar				= 19;
	serdSetPECharAlternate		= 20;
	serdSetXOff					= 21;
	serdClrXOff					= 22;
	serdSendXOnConditional		= 23;
	serdSendXOn					= 24;
	serdSendXOffConditional		= 25;
	serdSendXOff				= 26;
	serdChannelReset			= 27;
	serdSet230KBaud				= 'JF';							{ set 230K baud data rate }
	serdSetPollWrite			= 'jf';							{ disable interrupt-driven transmit }
	serdSetFlushCount			= 'FC';

{ csCodes for serial driver Status routines }
	serdGetBuf					= 2;
	serdStatus					= 8;
	serdGetVers					= 9;
	serdGetVersSys				= $8000;


TYPE
	SerShk = PACKED RECORD
		fXOn:					Byte;									{XOn flow control enabled flag}
		fCTS:					Byte;									{CTS flow control enabled flag}
		xOn:					CHAR;									{XOn character}
		xOff:					CHAR;									{XOff character}
		errs:					Byte;									{errors mask bits}
		evts:					Byte;									{event enable mask bits}
		fInX:					Byte;									{Input flow control enabled flag}
		fDTR:					Byte;									{DTR input flow control flag}
	END;

	SerStaRec = PACKED RECORD
		cumErrs:				Byte;
		xOffSent:				Byte;
		rdPend:					Byte;
		wrPend:					Byte;
		ctsHold:				Byte;
		xOffHold:				Byte;
	END;


FUNCTION SerReset(refNum: INTEGER; serConfig: INTEGER): OSErr;
FUNCTION SerSetBuf(refNum: INTEGER; serBPtr: Ptr; serBLen: INTEGER): OSErr;
FUNCTION SerHShake(refNum: INTEGER; {CONST}VAR flags: SerShk): OSErr;
FUNCTION SerSetBrk(refNum: INTEGER): OSErr;
FUNCTION SerClrBrk(refNum: INTEGER): OSErr;
FUNCTION SerGetBuf(refNum: INTEGER; VAR count: LONGINT): OSErr;
FUNCTION SerStatus(refNum: INTEGER; VAR serSta: SerStaRec): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SerialIncludes}

{$ENDC} {__SERIAL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
