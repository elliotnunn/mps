/*
 	File:		CursorDevices.h
 
 	Contains:	Cursor Devices (mouse/trackball/etc) Interfaces.
 
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

#ifndef __CURSORDEVICES__
#define __CURSORDEVICES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

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
	                    * * *  I M P O R T A N T  * * * 

	        You will need CursorDevicesGlue.o to use CDM from PowerPC


	In order to use the Cursor Devices Manager (CDM) on PowerPC systems, you must 
	link with the file CursorDevicesGlue.o and InterfaceLib 1.1.3.  This is necessary
	because the original MixedMode transition code for CDM in InterfaceLib in ROM
	was wrong.  The code in CursorDevicesGlue.o will check to see if the ROM has
    been fixed and calls through to it if so.  If it detects that the ROM has not
	been fixed, it uses its own implementation of the CDM MixedMode transition 
	routines. 
	
*/

typedef short ButtonOpcode;

/* ButtonOpcodes */

enum {
	kButtonNoOp					= 0,							/* No action for this button */
	kButtonSingleClick			= 1,							/* Normal mouse button */
	kButtonDoubleClick			= 2,							/* Click-release-click when pressed */
	kButtonClickLock			= 3,							/* Click on press, release on next press */
	kButtonCustom				= 6								/* Custom behavior, data = CursorDeviceCustomButtonUPP */
};

/* Device Classes */
enum {
	kDeviceClassAbsolute		= 0,							/* a flat-response device */
	kDeviceClassMouse			= 1,							/* mechanical or optical mouse */
	kDeviceClassTrackball		= 2,							/* trackball */
	kDeviceClassTrackPad		= 3,
	kDeviceClass3D				= 6								/* a 3D pointing device */
};

/* Structures used in Cursor Device Manager calls */
struct CursorData {
	struct CursorData				*nextCursorData;			/* next in global list */
	Ptr								displayInfo;				/* unused (reserved for future) */
	Fixed							whereX;						/* horizontal position */
	Fixed							whereY;						/* vertical position */
	Point							where;						/* the pixel position */
	Boolean							isAbs;						/* has been stuffed with absolute coords */
	UInt8							buttonCount;				/* number of buttons currently pressed */
	unsigned short					screenRes;					/* pixels per inch on the current display */
	short							privateFields[22];			/* fields use internally by CDM */
};
typedef struct CursorData CursorData, *CursorDataPtr;

struct CursorDevice {
	struct CursorDevice				*nextCursorDevice;			/* pointer to next record in linked list */
	CursorData						*whichCursor;				/* pointer to data for target cursor */
	long							refCon;						/* application-defined */
	long							unused;						/* reserved for future */
	OSType							devID;						/* device identifier (from ADB reg 1) */
	Fixed							resolution;					/* units/inch (orig. from ADB reg 1) */
	UInt8							devClass;					/* device class (from ADB reg 1) */
	UInt8							cntButtons;					/* number of buttons (from ADB reg 1) */
	UInt8							filler1;					/* reserved for future */
	UInt8							buttons;					/* state of all buttons */
	UInt8							buttonOp[8];				/* action performed per button */
	unsigned long					buttonTicks[8];				/* ticks when button last went up (for debounce) */
	long							buttonData[8];				/* data for the button operation */
	unsigned long					doubleClickTime;			/* device-specific double click speed */
	Fixed							acceleration;				/* current acceleration */
	short							privateFields[15];			/* fields used internally to CDM */
};
typedef struct CursorDevice CursorDevice, *CursorDevicePtr;

/* for use with CursorDeviceButtonOp when opcode = kButtonCustom */
/*
		CursorDeviceCustomButtonProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*CursorDeviceCustomButtonProcPtr)(CursorDevicePtr ourDevice, short button);

		In:
		 => ourDevice   	A2.L
		 => button      	D3.W
*/

#if GENERATINGCFM
typedef UniversalProcPtr CursorDeviceCustomButtonUPP;
#else
typedef Register68kProcPtr CursorDeviceCustomButtonUPP;
#endif

enum {
	uppCursorDeviceCustomButtonProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterA2, SIZE_CODE(sizeof(CursorDevicePtr)))
		 | REGISTER_ROUTINE_PARAMETER(2, kRegisterD3, SIZE_CODE(sizeof(short)))
};

#if GENERATINGCFM
#define NewCursorDeviceCustomButtonProc(userRoutine)		\
		(CursorDeviceCustomButtonUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppCursorDeviceCustomButtonProcInfo, GetCurrentArchitecture())
#else
#define NewCursorDeviceCustomButtonProc(userRoutine)		\
		((CursorDeviceCustomButtonUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallCursorDeviceCustomButtonProc(userRoutine, ourDevice, button)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppCursorDeviceCustomButtonProcInfo, (ourDevice), (button))
#else
/* (*CursorDeviceCustomButtonProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif

extern pascal OSErr CursorDeviceMove(CursorDevicePtr ourDevice, long deltaX, long deltaY)
 TWOWORDINLINE(0x7000, 0xAADB);
extern pascal OSErr CursorDeviceMoveTo(CursorDevicePtr ourDevice, long absX, long absY)
 TWOWORDINLINE(0x7001, 0xAADB);
extern pascal OSErr CursorDeviceFlush(CursorDevicePtr ourDevice)
 TWOWORDINLINE(0x7002, 0xAADB);
extern pascal OSErr CursorDeviceButtons(CursorDevicePtr ourDevice, short buttons)
 TWOWORDINLINE(0x7003, 0xAADB);
extern pascal OSErr CursorDeviceButtonDown(CursorDevicePtr ourDevice)
 TWOWORDINLINE(0x7004, 0xAADB);
extern pascal OSErr CursorDeviceButtonUp(CursorDevicePtr ourDevice)
 TWOWORDINLINE(0x7005, 0xAADB);
extern pascal OSErr CursorDeviceButtonOp(CursorDevicePtr ourDevice, short buttonNumber, ButtonOpcode opcode, long data)
 TWOWORDINLINE(0x7006, 0xAADB);
extern pascal OSErr CursorDeviceSetButtons(CursorDevicePtr ourDevice, short numberOfButtons)
 TWOWORDINLINE(0x7007, 0xAADB);
extern pascal OSErr CursorDeviceSetAcceleration(CursorDevicePtr ourDevice, Fixed acceleration)
 TWOWORDINLINE(0x7008, 0xAADB);
extern pascal OSErr CursorDeviceDoubleTime(CursorDevicePtr ourDevice, long durationTicks)
 TWOWORDINLINE(0x7009, 0xAADB);
extern pascal OSErr CursorDeviceUnitsPerInch(CursorDevicePtr ourDevice, Fixed resolution)
 TWOWORDINLINE(0x700A, 0xAADB);
extern pascal OSErr CursorDeviceNextDevice(CursorDevicePtr *ourDevice)
 TWOWORDINLINE(0x700B, 0xAADB);
extern pascal OSErr CursorDeviceNewDevice(CursorDevicePtr *ourDevice)
 TWOWORDINLINE(0x700C, 0xAADB);
extern pascal OSErr CursorDeviceDisposeDevice(CursorDevicePtr ourDevice)
 TWOWORDINLINE(0x700D, 0xAADB);


/*
	                   * * *  W A R N I N G  * * * 
				
	The routines CrsrDevMoveTo and CrsrDevNextDevice are no longer needed.
	They were added as a work around until the glue code CursorDevicesGlue.o
	was created.  Please use the functions CursorDeviceMoveTo and
	CursorDeviceNextDevice instead.

*/
pascal OSErr CrsrDevMoveTo(CursorDevicePtr ourDevice, long absX, long absY)
 TWOWORDINLINE(0x7001, 0xAADB);

pascal OSErr CrsrDevNextDevice(CursorDevicePtr *ourDevice)
 TWOWORDINLINE(0x700B, 0xAADB);


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CURSORDEVICES__ */
