/*
	File:		Devices.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __DEVICES__
#define __DEVICES__

#ifndef __OSUTILS__
#include <OSUtils.h>
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*		#include <MixedMode.h>									*/
/*			#include <Traps.h>									*/
#endif

#ifndef __FILES__
#include <Files.h>
/*	#include <SegLoad.h>										*/
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
/*	#include <QuickdrawText.h>									*/
/*		#include <IntlResources.h>								*/
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
/*	#include <Windows.h>										*/
/*		#include <Controls.h>									*/
/*			#include <Menus.h>									*/
/*	#include <TextEdit.h>										*/
#endif

#ifndef __DESK__
#include <Desk.h>
#endif

enum  {
	newSelMsg					= 12,
	fillListMsg					= 13,
	getSelMsg					= 14,
	selectMsg					= 15,
	deselectMsg					= 16,
	terminateMsg				= 17,
	buttonMsg					= 19,
	chooserID					= 1,
	initDev						= 0,							/*Time for cdev to initialize itself*/
	hitDev						= 1,							/*Hit on one of my items*/
	closeDev					= 2,							/*Close yourself*/
	nulDev						= 3,							/*Null event*/
	updateDev					= 4,							/*Update event*/
	activDev					= 5,							/*Activate event*/
	deactivDev					= 6,							/*Deactivate event*/
	keyEvtDev					= 7,							/*Key down/auto key*/
	macDev						= 8,							/*Decide whether or not to show up*/
	undoDev						= 9,
	cutDev						= 10,
	copyDev						= 11
};

enum  {
	pasteDev					= 12,
	clearDev					= 13,
	cursorDev					= 14,
	cdevGenErr					= -1,							/*General error; gray cdev w/o alert*/
	cdevMemErr					= 0,							/*Memory shortfall; alert user please*/
	cdevResErr					= 1,							/*Couldn't get a needed resource; alert*/
	cdevUnset					= 3,							/* cdevValue is initialized to this*/
/* Monitors control panel messages */
	initMsg						= 1,							/*initialization*/
	okMsg						= 2,							/*user clicked OK button*/
	cancelMsg					= 3,							/*user clicked Cancel button*/
	hitMsg						= 4,							/*user clicked control in Options dialog*/
	nulMsg						= 5,							/*periodic event*/
	updateMsg					= 6,							/*update event*/
	activateMsg					= 7,							/*not used*/
	deactivateMsg				= 8,							/*not used*/
	keyEvtMsg					= 9,							/*keyboard event*/
	superMsg					= 10,							/*show superuser controls*/
	normalMsg					= 11,							/*show only normal controls*/
	startupMsg					= 12							/*code has been loaded*/
};

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct DCtlEntry {
	Ptr							dCtlDriver;
	short						dCtlFlags;
	QHdr						dCtlQHdr;
	long						dCtlPosition;
	Handle						dCtlStorage;
	short						dCtlRefNum;
	long						dCtlCurTicks;
	WindowPtr					dCtlWindow;
	short						dCtlDelay;
	short						dCtlEMask;
	short						dCtlMenu;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct DCtlEntry DCtlEntry;

typedef DCtlEntry *DCtlPtr, **DCtlHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct AuxDCE {
	Ptr							dCtlDriver;
	short						dCtlFlags;
	QHdr						dCtlQHdr;
	long						dCtlPosition;
	Handle						dCtlStorage;
	short						dCtlRefNum;
	long						dCtlCurTicks;
	GrafPtr						dCtlWindow;
	short						dCtlDelay;
	short						dCtlEMask;
	short						dCtlMenu;
	char						dCtlSlot;
	char						dCtlSlotId;
	long						dCtlDevBase;
	Ptr							dCtlOwner;
	char						dCtlExtDev;
	char						fillByte;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct AuxDCE AuxDCE;

typedef AuxDCE *AuxDCEPtr, **AuxDCEHandle;

typedef pascal long (*ControlPanelDefProcPtr)(short message, short item, short numItems, short cPanelID, EventRecord *theEvent, long cdevValue, DialogPtr cpDialog);

enum {
	uppControlPanelDefProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(DialogPtr)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr ControlPanelDefUPP;

#define CallControlPanelDefProc(userRoutine, message, item, numItems, cPanelID, theEvent, cdevValue, cpDialog)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppControlPanelDefProcInfo, (message), (item), (numItems), (cPanelID), (theEvent), (cdevValue), (cpDialog))
#define NewControlPanelDefProc(userRoutine)		\
		(ControlPanelDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlPanelDefProcInfo, GetCurrentISA())
#else
typedef ControlPanelDefProcPtr ControlPanelDefUPP;

#define CallControlPanelDefProc(userRoutine, message, item, numItems, cPanelID, theEvent, cdevValue, cpDialog)		\
		(*(userRoutine))((message), (item), (numItems), (cPanelID), (theEvent), (cdevValue), (cpDialog))
#define NewControlPanelDefProc(userRoutine)		\
		(ControlPanelDefUPP)(userRoutine)
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern pascal DCtlHandle GetDCtlEntry(short refNum);

/*
	SetChooserAlert used to simply set a bit in a low-mem global
	to tell the Chooser not to display its warning message when
	the printer is changed. However, under MultiFinder and System 7,
	this low-mem is swapped out when a layer change occurs, and the
	Chooser never sees the change. It is obsolete, and completely
	unsupported on the PowerPC. 68K apps can still call it if they
	wish.
*/

#if defined(OBSOLETE) && !defined(powerc) && !defined(__powerc)
extern pascal Boolean SetChooserAlert(Boolean f);
#endif

extern pascal OSErr DrvrInstall(Handle drvrHandle, short refNum);
extern pascal OSErr DrvrRemove(short refNum);
extern pascal OSErr OpenDriver(ConstStr255Param name, short *drvrRefNum);
extern OSErr opendriver(char *driverName, short *refNum);
extern pascal OSErr CloseDriver(short refNum);
extern pascal OSErr Control(short refNum, short csCode, const void *csParamPtr);
extern pascal OSErr Status(short refNum, short csCode, void *csParamPtr);
extern pascal OSErr KillIO(short refNum);

#if USES68KINLINES
#pragma parameter __D0 PBControlSync(__A0)
#endif
extern pascal OSErr PBControlSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA004);

#if USES68KINLINES
#pragma parameter __D0 PBControlAsync(__A0)
#endif
extern pascal OSErr PBControlAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA404);

#if USES68KINLINES
#pragma parameter __D0 PBControlImmed(__A0)
#endif
extern pascal OSErr PBControlImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA204);

#if USES68KINLINES
#pragma parameter __D0 PBStatusSync(__A0)
#endif
extern pascal OSErr PBStatusSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA005);

#if USES68KINLINES
#pragma parameter __D0 PBStatusAsync(__A0)
#endif
extern pascal OSErr PBStatusAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA405);

#if USES68KINLINES
#pragma parameter __D0 PBStatusImmed(__A0)
#endif
extern pascal OSErr PBStatusImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA205);

#if USES68KINLINES
#pragma parameter __D0 PBKillIOSync(__A0)
#endif
extern pascal OSErr PBKillIOSync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA006);

#if USES68KINLINES
#pragma parameter __D0 PBKillIOAsync(__A0)
#endif
extern pascal OSErr PBKillIOAsync(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA406);

#if USES68KINLINES
#pragma parameter __D0 PBKillIOImmed(__A0)
#endif
extern pascal OSErr PBKillIOImmed(ParmBlkPtr paramBlock)
 ONEWORDINLINE(0xA206);
#define PBControl(pb, async) ((async) ? PBControlAsync(pb) : PBControlSync(pb))

#define PBStatus(pb, async) ((async) ? PBStatusAsync(pb) : PBStatusSync(pb))

#define PBKillIO(pb, async) ((async) ? PBKillIOAsync(pb) : PBKillIOSync(pb))

#ifdef __cplusplus
}
#endif

#endif
