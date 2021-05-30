{
     File:       CursorDevices.p
 
     Contains:   Cursor Devices (mouse/trackball/etc) Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CursorDevices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CURSORDEVICES__}
{$SETC __CURSORDEVICES__ := 1}

{$I+}
{$SETC CursorDevicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
                        * * *  I M P O R T A N T  * * * 

            You will need CursorDevicesGlue.o to use CDM from PowerPC


    In order to use the Cursor Devices Manager (CDM) on PowerPC systems, you must 
    link with the file CursorDevicesGlue.o and InterfaceLib 1.1.3.  This is necessary
    because the original MixedMode transition code for CDM in InterfaceLib in ROM
    was wrong.  The code in CursorDevicesGlue.o will check to see if the ROM has
    been fixed and calls through to it if so.  If it detects that the ROM has not
    been fixed, it uses its own implementation of the CDM MixedMode transition 
    routines. 
    
}


TYPE
	ButtonOpcode						= INTEGER;
	{	 ButtonOpcodes 	}

CONST
	kButtonNoOp					= 0;							{  No action for this button  }
	kButtonSingleClick			= 1;							{  Normal mouse button  }
	kButtonDoubleClick			= 2;							{  Click-release-click when pressed  }
	kButtonClickLock			= 3;							{  Click on press, release on next press  }

	kButtonCustom				= 6;							{  Custom behavior, data = CursorDeviceCustomButtonUPP  }

	{	 Device Classes 	}
	kDeviceClassAbsolute		= 0;							{  a flat-response device  }
	kDeviceClassMouse			= 1;							{  mechanical or optical mouse  }
	kDeviceClassTrackball		= 2;							{  trackball  }
	kDeviceClassTrackPad		= 3;

	kDeviceClass3D				= 6;							{  a 3D pointing device  }

	{	 Structures used in Cursor Device Manager calls 	}

TYPE
	CursorDataPtr = ^CursorData;
	CursorData = RECORD
		nextCursorData:			CursorDataPtr;							{  next in global list  }
		displayInfo:			Ptr;									{  unused (reserved for future)  }
		whereX:					Fixed;									{  horizontal position  }
		whereY:					Fixed;									{  vertical position  }
		where:					Point;									{  the pixel position  }
		isAbs:					BOOLEAN;								{  has been stuffed with absolute coords  }
		buttonCount:			SInt8;									{  number of buttons currently pressed  }
		screenRes:				LONGINT;								{  pixels per inch on the current display  }
		privateFields:			ARRAY [0..21] OF INTEGER;				{  fields use internally by CDM  }
	END;

	CursorDevicePtr = ^CursorDevice;
	CursorDevice = RECORD
		nextCursorDevice:		CursorDevicePtr;						{  pointer to next record in linked list  }
		whichCursor:			CursorDataPtr;							{  pointer to data for target cursor  }
		refCon:					LONGINT;								{  application-defined  }
		unused:					LONGINT;								{  reserved for future  }
		devID:					OSType;									{  device identifier (from ADB reg 1)  }
		resolution:				Fixed;									{  units/inch (orig. from ADB reg 1)  }
		devClass:				SInt8;									{  device class (from ADB reg 1)  }
		cntButtons:				SInt8;									{  number of buttons (from ADB reg 1)  }
		filler1:				SInt8;									{  reserved for future  }
		buttons:				SInt8;									{  state of all buttons  }
		buttonOp:				PACKED ARRAY [0..7] OF UInt8;			{  action performed per button  }
		buttonTicks:			ARRAY [0..7] OF UInt32;					{  ticks when button last went up (for debounce)  }
		buttonData:				ARRAY [0..7] OF LONGINT;				{  data for the button operation  }
		doubleClickTime:		UInt32;									{  device-specific double click speed  }
		acceleration:			Fixed;									{  current acceleration  }
		privateFields:			ARRAY [0..14] OF INTEGER;				{  fields used internally to CDM  }
	END;

	{	 for use with CursorDeviceButtonOp when opcode = kButtonCustom 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CursorDeviceCustomButtonProcPtr = PROCEDURE(ourDevice: CursorDevicePtr; button: INTEGER);
{$ELSEC}
	CursorDeviceCustomButtonProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CursorDeviceCustomButtonUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CursorDeviceCustomButtonUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppCursorDeviceCustomButtonProcInfo = $000ED802;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewCursorDeviceCustomButtonUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewCursorDeviceCustomButtonUPP(userRoutine: CursorDeviceCustomButtonProcPtr): CursorDeviceCustomButtonUPP; { old name was NewCursorDeviceCustomButtonProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeCursorDeviceCustomButtonUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeCursorDeviceCustomButtonUPP(userUPP: CursorDeviceCustomButtonUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeCursorDeviceCustomButtonUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeCursorDeviceCustomButtonUPP(ourDevice: CursorDevicePtr; button: INTEGER; userRoutine: CursorDeviceCustomButtonUPP); { old name was CallCursorDeviceCustomButtonProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  CursorDeviceMove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceMove(ourDevice: CursorDevicePtr; deltaX: LONGINT; deltaY: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AADB;
	{$ENDC}

{
 *  CursorDeviceMoveTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceMoveTo(ourDevice: CursorDevicePtr; absX: LONGINT; absY: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AADB;
	{$ENDC}

{
 *  CursorDeviceFlush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceFlush(ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AADB;
	{$ENDC}

{
 *  CursorDeviceButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceButtons(ourDevice: CursorDevicePtr; buttons: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AADB;
	{$ENDC}

{
 *  CursorDeviceButtonDown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceButtonDown(ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AADB;
	{$ENDC}

{
 *  CursorDeviceButtonUp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceButtonUp(ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AADB;
	{$ENDC}

{
 *  CursorDeviceButtonOp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceButtonOp(ourDevice: CursorDevicePtr; buttonNumber: INTEGER; opcode: ButtonOpcode; data: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AADB;
	{$ENDC}

{
 *  CursorDeviceSetButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceSetButtons(ourDevice: CursorDevicePtr; numberOfButtons: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AADB;
	{$ENDC}

{
 *  CursorDeviceSetAcceleration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceSetAcceleration(ourDevice: CursorDevicePtr; acceleration: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AADB;
	{$ENDC}

{
 *  CursorDeviceDoubleTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceDoubleTime(ourDevice: CursorDevicePtr; durationTicks: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AADB;
	{$ENDC}

{
 *  CursorDeviceUnitsPerInch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceUnitsPerInch(ourDevice: CursorDevicePtr; resolution: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AADB;
	{$ENDC}

{
 *  CursorDeviceNextDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceNextDevice(VAR ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AADB;
	{$ENDC}

{
 *  CursorDeviceNewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceNewDevice(VAR ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AADB;
	{$ENDC}

{
 *  CursorDeviceDisposeDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CursorDeviceDisposeDevice(ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AADB;
	{$ENDC}


{
                       * * *  W A R N I N G  * * * 
                
    The routines CrsrDevMoveTo and CrsrDevNextDevice are no longer needed.
    They were added as a work around until the glue code CursorDevicesGlue.o
    was created.  Please use the functions CursorDeviceMoveTo and
    CursorDeviceNextDevice instead.

}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  CrsrDevMoveTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CrsrDevMoveTo(ourDevice: CursorDevicePtr; absX: LONGINT; absY: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AADB;
	{$ENDC}

{
 *  CrsrDevNextDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CrsrDevNextDevice(VAR ourDevice: CursorDevicePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AADB;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CursorDevicesIncludes}

{$ENDC} {__CURSORDEVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
