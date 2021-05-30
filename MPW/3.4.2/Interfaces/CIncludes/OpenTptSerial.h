/*
	File:		OpenTptSerial.h

	Contains:	Definitions for Serial Port

	Copyright:	© 1993-1996 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTSERIAL__
#define __OPENTPTSERIAL__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

/*******************************************************************************
** Module Definitions
********************************************************************************/
//
// XTI Level
//

enum
{
	COM_SERIAL	= 'SERL'
};
//
// Version Number
//
#define kSerialABVersion	"1.1.1"

//
// Module Names
//
#define kSerialABName		"serialAB"
#define kSerialName			"serial"
#define kSerialPortAName	"serialA"
#define kSerialPortBName	"serialB"

enum
{
	kSerialABModuleID	= 7200
};

enum
{
	kOTSerialFramingAsync			= 0x01,		/* Support Async serial mode 			*/
	kOTSerialFramingHDLC			= 0x02,		/* Support HDLC synchronous serial mode	*/
	kOTSerialFramingSDLC			= 0x04,		/* Support SDLC synchronous serial mode	*/
	kOTSerialFramingAsyncPackets	= 0x08 		/* Support Async "packet" serial mode	*/
};

/*******************************************************************************
** IOCTL Calls for Serial Drivers
********************************************************************************/

enum
{
	/* 
	 * Set DTR (0 = off, 1 = on)
	 */
	I_SetSerialDTR			= MIOC_CMD(MIOC_SRL, 0),
		kOTSerialSetDTROff			= 0,
		kOTSerialSetDTROn			= 1,
	/*
	 * Send a break on the line - kOTSerialSetBreakOff = off, kOTSerialSetBreakOn = on,
	 * Any other number is the number of milliseconds to leave break on, then
	 * auto shutoff
	 */
	I_SetSerialBreak		= MIOC_CMD(MIOC_SRL, 1),
		kOTSerialSetBreakOn		= 0xffffffff,
		kOTSerialSetBreakOff	= 0,
	/*
	 * Force XOFF state - 0 = Unconditionally clear XOFF state, 1 = unconditionally set it
	 */
	I_SetSerialXOffState	= MIOC_CMD(MIOC_SRL, 2),
		kOTSerialForceXOffTrue		= 1,
		kOTSerialForceXOffFalse		= 0,
	/*
	 * Send an XON character
	 * 0 = send only if in XOFF state, 1 = send always
	 */
	I_SetSerialXOn			= MIOC_CMD(MIOC_SRL, 3),
		kOTSerialSendXOnAlways		= 1,
		kOTSerialSendXOnIfXOffTrue	= 0,
	/*
	 * Send an XOFF character
	 * 0 = send only if in XON state, 1 = send always
	 */
	I_SetSerialXOff			= MIOC_CMD(MIOC_SRL, 4),
		kOTSerialSendXOffAlways		= 1,
		kOTSerialSendXOffIfXOnTrue	= 0
};

/*******************************************************************************
** Option Management for Serial Drivers
********************************************************************************/
/*
** These options are all 4-byte values.
** BaudRate is the baud rate.
** DataBits is the number of data bits.
** StopBits is the number of stop bits times 10.
** Parity is an enum
*/

enum 
{
	SERIAL_OPT_BAUDRATE	= 0x0100,	/* UInt32	*/
	SERIAL_OPT_DATABITS	= 0x0101,	/* UInt32	*/
	SERIAL_OPT_STOPBITS	= 0x0102,	/* UInt32 10, 15 or 20 for 1, 1.5 or 2	*/
	SERIAL_OPT_PARITY	= 0x0103	/* UInt32	*/
};

	enum ParityOptionValues
	{
		kOTSerialNoParity = 0, kOTSerialOddParity = 1, kOTSerialEvenParity = 2
	};

//
// The "Status" option is a 4-byte value option that is ReadOnly
// It returns a bitmap of the current serial status
//
enum
{
	SERIAL_OPT_STATUS = 0x0104,
	
	kOTSerialSwOverRunErr	= 0x01,
	kOTSerialBreakOn		= 0x08,
	kOTSerialParityErr		= 0x10,
	kOTSerialOverrunErr		= 0x20,
	kOTSerialFramingErr		= 0x40,
	kOTSerialXOffSent		= 0x0010000,
	kOTSerialDTRNegated		= 0x0020000,
	kOTSerialCTLHold		= 0x0040000,
	kOTSerialXOffHold		= 0x0080000,
	kOTSerialOutputBreakOn	= 0x1000000
};

//
// The "Handshake" option defines what kind of handshaking the serial port
// will do for line flow control.  The value is a 32-bit value defined by
// the function or macro SerialHandshakeData below.
// For no handshake, or CTS handshake, the onChar and offChar parameters
// are ignored.
//
enum
{ 
	SERIAL_OPT_HANDSHAKE = 0x0105
};
//
// These are bits to enable specific types of handshaking
//
enum
{
	kOTSerialXOnOffInputHandshake	= 1,	/* Want XOn/XOff handshake for incoming characters	*/
	kOTSerialXOnOffOutputHandshake	= 2,	/* Want XOn/XOff handshake for outgoing characters	*/
	kOTSerialCTSInputHandshake		= 4,	/* Want CTS handshake for incoming characters		*/
	kOTSerialDTROutputHandshake		= 8		/* Want DTR handshake for outoing characters		*/
};

#ifdef __cplusplus

inline UInt32 OTSerialHandshakeData(UInt16 type, UInt8 onChar, UInt8 offChar)
{
	return (((UInt32)type) << 16) | (((UInt32)onChar) << 8) | offChar;
}

#else

#define OTSerialHandshakeData(type, onChar, offChar)	\
	((((UInt32)type) << 16) | (((UInt32)onChar) << 8) | offChar)
	
#endif
//
// The "RcvTimeout" option defines how long the receiver should wait before delivering
// less than the RcvLoWat number of characters.  If RcvLoWat is 0, then the RcvTimeout
// is how long a gap to wait for before delivering characters.  This parameter is advisory,
// and serial drivers are free to deliver data whenever they deem it convenient.  For instance,
// many serial drivers will deliver data whenever 64 bytes have been received, since 64 bytes
// is the smallest STREAMS buffer size. Keep in mind that timeouts are quantized, so be sure to
// look at the return value of the option to determine what it was negotiated to.
//
enum
{ 
	SERIAL_OPT_RCVTIMEOUT = 0x0106
};
//
// This option defines how characters with parity errors are handled.
// A 0 value will disable all replacement.  A single character value in the low
// byte designates the replacement character.  When characters are received with a 
// parity error, they are replaced by this specified character.  If a valid incoming
// character matches the replacement character, then the received character's msb is
// cleared. For this situation, the alternate character is used, if specified in bits
// 8 through 15 of the option long, with 0xff being place in bits 16 through 23.
// Whenever a valid character is received that matches the first replacement character,
// it is replaced with this alternate character.
//
enum
{ 
	SERIAL_OPT_ERRORCHARACTER = 0x0107
};

#ifdef __cplusplus

inline UInt32 OTSerialSetErrorCharacter(UInt8 rep)
{
	return rep & 0xff;
}

inline UInt32 OTSerialSetErrorCharacterWithAlternate(UInt8 rep, UInt8 alternate)
{
	return (((rep & 0xff) | ((alternate & 0xff) << 8)) | 0x80000000L);
}

#else

#define OTSerialSetErrorCharacter(rep)	\
	((rep) & 0xff)

#define OTSerialSetErrorCharacterWithAlternate(rep, alternate)	\
	((((rep) & 0xff) | (((alternate) & 0xff) << 8)) | 0x80000000L)

#endif
//
// The "ExtClock" requests an external clock.  A 0-value turns off external clocking.
// Any other value is a requested divisor for the external clock.  Be aware that
// not all serial implementations support an external clock, and that not all
// requested divisors will be supported if it does support an external clock.
//
enum
{ 
	SERIAL_OPT_EXTCLOCK = 0x0108
};
//
// The "BurstMode" option informs the serial driver that it should continue looping,
// reading incoming characters, rather than waiting for an interrupt for each character.
// This option may not be supported by all Serial driver
//
enum
{ 
	SERIAL_OPT_BURSTMODE = 0x0109
};

//
// Default attributes for the serial ports
//
enum
{
	kOTSerialDefaultBaudRate		= 19200,
	kOTSerialDefaultDataBits		= 8,
	kOTSerialDefaultStopBits		= 10,
	kOTSerialDefaultParity			= kOTSerialNoParity,
	kOTSerialDefaultHandshake		= 0,
	kOTSerialDefaultOnChar			= ('Q' & ~0x40),
	kOTSerialDefaultOffChar			= ('S' & ~0x40),
	kOTSerialDefaultSndBufSize		= 1024,
	kOTSerialDefaultRcvBufSize		= 1024,
	kOTSerialDefaultSndLoWat		= 96,
	kOTSerialDefaultRcvLoWat		= 1,
	kOTSerialDefaultRcvTimeout		= 10
};

#endif	/* __OPENTPTSERIAL */
