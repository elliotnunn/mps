{
     File:       Serial.p
 
     Contains:   Asynchronous Serial Driver (.AIn/.AOut/.BIn/.BOut) Interfaces
 
     Version:    Technology: System 7.6+
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	baud150						= 763;
	baud300						= 380;
	baud600						= 189;
	baud1200					= 94;
	baud1800					= 62;
	baud2400					= 46;
	baud3600					= 30;
	baud4800					= 22;
	baud7200					= 14;
	baud9600					= 10;
	baud14400					= 6;
	baud19200					= 4;
	baud28800					= 2;
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

	aData						= 6;							{  channel A data in or out (historical)  }
	aCtl						= 2;							{  channel A control (historical)  }
	bData						= 4;							{  channel B data in or out (historical)  }
	bCtl						= 0;							{  channel B control (historical)  }

	dsrEvent					= 2;							{  flag for SerShk.evts  }
	riEvent						= 4;							{  flag for SerShk.evts  }
	dcdEvent					= 8;							{  flag for SerShk.evts  }
	ctsEvent					= 32;							{  flag for SerShk.evts  }
	breakEvent					= 128;							{  flag for SerShk.evts  }

	xOffWasSent					= 128;							{  flag for SerStaRec.xOffSent  }
	dtrNegated					= 64;							{  flag for SerStaRec.xOffSent  }
	rtsNegated					= 32;							{  flag for SerStaRec.xOffSent  }

	ainRefNum					= -6;							{  serial port A input  }
	aoutRefNum					= -7;							{  serial port A output  }
	binRefNum					= -8;							{  serial port B input  }
	boutRefNum					= -9;							{  serial port B output  }

	swOverrunErr				= 1;							{  serial driver error masks  }
	breakErr					= 8;							{  serial driver error masks  }
	parityErr					= 16;							{  serial driver error masks  }
	hwOverrunErr				= 32;							{  serial driver error masks  }
	framingErr					= 64;							{  serial driver error masks  }

	kOptionPreserveDTR			= 128;							{  option bit used with Control code 16  }
	kOptionClockX1CTS			= 64;							{  option bit used with Control code 16  }

	kUseCTSOutputFlowControl	= 128;							{  flag for SerShk.fCTS  }
	kUseDSROutputFlowControl	= 64;							{  flag for SerShk.fCTS  }
	kUseRTSInputFlowControl		= 128;							{  flag for SerShk.fDTR  }
	kUseDTRInputFlowControl		= 64;							{  flag for SerShk.fDTR  }

	sPortA						= 0;							{  Macintosh modem port  }
	sPortB						= 1;							{  Macintosh printer port  }
	sCOM1						= 2;							{  RS-232 port COM1  }
	sCOM2						= 3;							{  RS-232 port COM2  }


TYPE
	SPortSel							= SInt8;
	{	 csCodes for serial driver Control routines 	}

CONST
	kSERDConfiguration			= 8;							{  program port speed, bits/char, parity, and stop bits  }
	kSERDInputBuffer			= 9;							{  set buffer for chars received with no read pending  }
	kSERDSerHShake				= 10;							{  equivalent to SerHShake, largely obsolete  }
	kSERDClearBreak				= 11;							{  assert break signal on output  }
	kSERDSetBreak				= 12;							{  negate break state on output  }
	kSERDBaudRate				= 13;							{  set explicit baud rate, other settings unchanged  }
	kSERDHandshake				= 14;							{  superset of 10, honors setting of fDTR  }
	kSERDClockMIDI				= 15;							{  clock externally on CTS with specified multiplier  }
	kSERDMiscOptions			= 16;							{  select clock source and DTR behavior on close  }
	kSERDAssertDTR				= 17;							{  assert DTR output  }
	kSERDNegateDTR				= 18;							{  negate DTR output  }
	kSERDSetPEChar				= 19;							{  select char to replace chars with invalid parity  }
	kSERDSetPEAltChar			= 20;							{  select char to replace char that replaces chars with invalid parity  }
	kSERDSetXOffFlag			= 21;							{  set XOff output flow control (same as receiving XOff)  }
	kSERDClearXOffFlag			= 22;							{  clear XOff output flow control (same as receiving XOn)  }
	kSERDSendXOn				= 23;							{  send XOn if input flow control state is XOff  }
	kSERDSendXOnOut				= 24;							{  send XOn regardless of input flow control state  }
	kSERDSendXOff				= 25;							{  send XOff if input flow control state is XOn  }
	kSERDSendXOffOut			= 26;							{  send XOff regardless of input flow control state  }
	kSERDResetChannel			= 27;							{  reset serial I/O channel hardware  }
	kSERDHandshakeRS232			= 28;							{  extension of 14, allows full RS-232 hardware handshaking  }
	kSERDStickParity			= 29;							{  use mark/space parity  }
	kSERDAssertRTS				= 30;							{  assert RTS output  }
	kSERDNegateRTS				= 31;							{  negate RTS output  }
	kSERD115KBaud				= 115;							{  set 115.2K baud data rate  }
	kSERD230KBaud				= 230;							{  set 230.4K baud data rate  }


	{	 csCodes for serial driver Status routines 	}
	kSERDInputCount				= 2;							{  return characters available (SerGetBuf)  }
	kSERDStatus					= 8;							{  return characters available (SerStatus)  }
	kSERDVersion				= 9;							{  return version number in first byte of csParam  }
	kSERDGetDCD					= 256;							{  get instantaneous state of DCD (GPi)  }



TYPE
	SerShkPtr = ^SerShk;
	SerShk = PACKED RECORD
		fXOn:					Byte;									{  XOn/XOff output flow control flag  }
		fCTS:					Byte;									{  hardware output flow control flags  }
		xOn:					UInt8;									{  XOn character  }
		xOff:					UInt8;									{  XOff character  }
		errs:					Byte;									{  errors mask bits  }
		evts:					Byte;									{  event enable mask bits  }
		fInX:					Byte;									{  XOn/XOff input flow control flag  }
		fDTR:					Byte;									{  hardware input flow control flags  }
	END;

	SerStaRecPtr = ^SerStaRec;
	SerStaRec = PACKED RECORD
		cumErrs:				Byte;									{  errors accumulated since last SerStatus() call  }
		xOffSent:				Byte;									{  input (requested to be) held off by xOffWasSent or dtrNegated or rtsNegated  }
		rdPend:					Byte;									{  incomplete read pending in I/O queue  }
		wrPend:					Byte;									{  incomplete write pending in I/O queue  }
		ctsHold:				Byte;									{  transmit disabled by hardware handshaking  }
		xOffHold:				Byte;									{  transmit disabled by XOn/XOff handshaking  }
		dsrHold:				Byte;									{  transmit disabled: external device not ready  }
		modemStatus:			Byte;									{  reports modem status according to SerShk.evts  }
	END;

{$IFC OLDROUTINENAMES }
	{	 ********************************************************************************************* 	}
	{	 The following constant names have been retired in favor of standard, more descriptive names.  	}
	{	 You can still compile old code by defining OLDROUTINENAMES. There were several constants that 	}
	{	 were formerly available that have been removed, as they are now regarded as either private or 	}
	{	 unsupported. We advise that you stop using any constants that are not defined in this file.   	}
	{	 ********************************************************************************************* 	}

CONST
	serdOptionClockExternal		= 64;							{  option bit used with Control code 16  }
	serdOptionPreserveDTR		= 128;							{  option bit used with Control code 16  }

	{	 csCodes for serial driver Control routines 	}
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
	serdSet230KBaud				= 230;							{  set 230K baud data rate  }


	{	 csCodes for serial driver Status routines 	}
	serdGetBuf					= 2;
	serdStatus					= 8;
	serdGetVers					= 9;

{$ENDC}  {OLDROUTINENAMES}

{
    The following interfaces are for the legacy high-level serial driver glue in
    the interface libraries of your development system. They merely substitue for
    the corresponding synchronous calls to PBControl and PBStatus.

    They have not been updated as the serial driver API has evolved. Take note:

        SerHShake does not support hardware input flow control. Use csCode 14.
        SerStatus returns only the first six bytes of SerStaRec (through xOffHold).
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  SerReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerReset(refNum: INTEGER; serConfig: INTEGER): OSErr;

{
 *  SerSetBuf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerSetBuf(refNum: INTEGER; serBPtr: Ptr; serBLen: INTEGER): OSErr;

{
 *  SerHShake()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerHShake(refNum: INTEGER; {CONST}VAR flags: SerShk): OSErr;

{
 *  SerSetBrk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerSetBrk(refNum: INTEGER): OSErr;

{
 *  SerClrBrk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerClrBrk(refNum: INTEGER): OSErr;

{
 *  SerGetBuf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerGetBuf(refNum: INTEGER; VAR count: LONGINT): OSErr;

{
 *  SerStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SerStatus(refNum: INTEGER; VAR serSta: SerStaRec): OSErr;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SerialIncludes}

{$ENDC} {__SERIAL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
