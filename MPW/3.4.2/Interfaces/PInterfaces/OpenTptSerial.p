{
 	File:		OpenTptSerial.p
 
 	Contains:	Definitions for Serial Port
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptSerial;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTSERIAL__}
{$SETC __OPENTPTSERIAL__ := 1}

{$I+}
{$SETC OpenTptSerialIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
******************************************************************************
** Module Definitions
*******************************************************************************
}
{  XTI Level }

CONST
	COM_SERIAL					= 'SERL';

{  Version Number }
	kSerialABVersion	=	'1.1.1';
{  Module Names }
	kSerialABName	=	'serialAB';
	kSerialName		=	'serial';
	kSerialPortAName	=	'serialA';
	kSerialPortBName	=	'serialB';
	kSerialABModuleID			= 7200;

	kOTSerialFramingAsync		= $01;							{  Support Async serial mode 			 }
	kOTSerialFramingHDLC		= $02;							{  Support HDLC synchronous serial mode	 }
	kOTSerialFramingSDLC		= $04;							{  Support SDLC synchronous serial mode	 }
	kOTSerialFramingAsyncPackets = $08;							{  Support Async "packet" serial mode	 }

{
******************************************************************************
** IOCTL Calls for Serial Drivers
*******************************************************************************
}
	I_SetSerialDTR				= $5400;						{  Set DTR (0 = off, 1 = on)		 }
	kOTSerialSetDTROff			= 0;
	kOTSerialSetDTROn			= 1;
	I_SetSerialBreak			= $5401;						{  Send a break on the line - kOTSerialSetBreakOff = off, 	 }
	kOTSerialSetBreakOn			= $FFFFFFFF;					{  kOTSerialSetBreakOn = on, Any other number is the number  }
	kOTSerialSetBreakOff		= 0;							{  of milliseconds to leave break on, then auto shutoff		 }
	I_SetSerialXOffState		= $5402;						{  Force XOFF state 				 }
	kOTSerialForceXOffTrue		= 1;							{  1 = unconditionally set it		 }
	kOTSerialForceXOffFalse		= 0;							{  0 = unconditionall clearr it		 }
	I_SetSerialXOn				= $5403;						{  Send an XON character			 }
	kOTSerialSendXOnAlways		= 1;							{  1 = send always					 }
	kOTSerialSendXOnIfXOffTrue	= 0;							{  0 = send only if in XOFF state	 }
	I_SetSerialXOff				= $5404;						{  Send an XOFF character			 }
	kOTSerialSendXOffAlways		= 1;							{  1 = send always					 }
	kOTSerialSendXOffIfXOnTrue	= 0;							{  0 = send only if in XON state	 }

{
******************************************************************************
** Option Management for Serial Drivers
*******************************************************************************
}
{
** These options are all 4-byte values.
** BaudRate is the baud rate.
** DataBits is the number of data bits.
** StopBits is the number of stop bits times 10.
** Parity is an enum
}
	SERIAL_OPT_BAUDRATE			= $0100;						{  UInt32	 }
	SERIAL_OPT_DATABITS			= $0101;						{  UInt32	 }
	SERIAL_OPT_STOPBITS			= $0102;						{  UInt32 10, 15 or 20 for 1, 1.5 or 2	 }
	SERIAL_OPT_PARITY			= $0103;						{  UInt32	 }

	kOTSerialNoParity			= 0;
	kOTSerialOddParity			= 1;
	kOTSerialEvenParity			= 2;

{
 The "Status" option is a 4-byte value option that is ReadOnly
 It returns a bitmap of the current serial status
}
	SERIAL_OPT_STATUS			= $0104;
	kOTSerialSwOverRunErr		= $01;
	kOTSerialBreakOn			= $08;
	kOTSerialParityErr			= $10;
	kOTSerialOverrunErr			= $20;
	kOTSerialFramingErr			= $40;
	kOTSerialXOffSent			= $00010000;
	kOTSerialDTRNegated			= $00020000;
	kOTSerialCTLHold			= $00040000;
	kOTSerialXOffHold			= $00080000;
	kOTSerialOutputBreakOn		= $01000000;

{
 The "Handshake" option defines what kind of handshaking the serial port
 will do for line flow control.  The value is a 32-bit value defined by
 the function or macro SerialHandshakeData below.
 For no handshake, or CTS handshake, the onChar and offChar parameters
 are ignored.
}
	SERIAL_OPT_HANDSHAKE		= $0105;

{  These are bits to enable specific types of handshaking }
	kOTSerialXOnOffInputHandshake = 1;							{  Want XOn/XOff handshake for incoming characters	 }
	kOTSerialXOnOffOutputHandshake = 2;							{  Want XOn/XOff handshake for outgoing characters	 }
	kOTSerialCTSInputHandshake	= 4;							{  Want CTS handshake for incoming characters		 }
	kOTSerialDTROutputHandshake	= 8;							{  Want DTR handshake for outoing characters		 }

{
 The "RcvTimeout" option defines how long the receiver should wait before delivering
 less than the RcvLoWat number of characters.  If RcvLoWat is 0, then the RcvTimeout
 is how long a gap to wait for before delivering characters.  This parameter is advisory,
 and serial drivers are free to deliver data whenever they deem it convenient.  For instance,
 many serial drivers will deliver data whenever 64 bytes have been received, since 64 bytes
 is the smallest STREAMS buffer size. Keep in mind that timeouts are quantized, so be sure to
 look at the return value of the option to determine what it was negotiated to.
}
	SERIAL_OPT_RCVTIMEOUT		= $0106;

{
 This option defines how characters with parity errors are handled.
 A 0 value will disable all replacement.  A single character value in the low
 byte designates the replacement character.  When characters are received with a 
 parity error, they are replaced by this specified character.  If a valid incoming
 character matches the replacement character, then the received character's msb is
 cleared. For this situation, the alternate character is used, if specified in bits
 8 through 15 of the option long, with 0xff being place in bits 16 through 23.
 Whenever a valid character is received that matches the first replacement character,
 it is replaced with this alternate character.
}
	SERIAL_OPT_ERRORCHARACTER	= $0107;

{
 The "ExtClock" requests an external clock.  A 0-value turns off external clocking.
 Any other value is a requested divisor for the external clock.  Be aware that
 not all serial implementations support an external clock, and that not all
 requested divisors will be supported if it does support an external clock.
}
	SERIAL_OPT_EXTCLOCK			= $0108;

{
 The "BurstMode" option informs the serial driver that it should continue looping,
 reading incoming characters, rather than waiting for an interrupt for each character.
 This option may not be supported by all Serial driver
}
	SERIAL_OPT_BURSTMODE		= $0109;

{  Default attributes for the serial ports }
	kOTSerialDefaultBaudRate	= 19200;
	kOTSerialDefaultDataBits	= 8;
	kOTSerialDefaultStopBits	= 10;
	kOTSerialDefaultParity		= 0;
	kOTSerialDefaultHandshake	= 0;
	kOTSerialDefaultOnChar		= $11;							{  Control-Q }
	kOTSerialDefaultOffChar		= $13;							{  Control-S }
	kOTSerialDefaultSndBufSize	= 128;
	kOTSerialDefaultRcvBufSize	= 128;
	kOTSerialDefaultSndLoWat	= 96;
	kOTSerialDefaultRcvLoWat	= 1;
	kOTSerialDefaultRcvTimeout	= 10;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTptSerialIncludes}

{$ENDC} {__OPENTPTSERIAL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
