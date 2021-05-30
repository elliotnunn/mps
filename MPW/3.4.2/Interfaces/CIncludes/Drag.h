/*
 	File:		Drag.h
 
 	Contains:	Drag and Drop Interfaces.
 
 	Version:	Technology:	Macintosh Drag and Drop 1.1
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __DRAG__
#define __DRAG__


#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Types.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __TEXTEDIT__
#include <TextEdit.h>
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


enum {
/* Flavor Flags */
	flavorSenderOnly			= 0x00000001L,					/* flavor is available to sender only */
	flavorSenderTranslated		= 0x00000002L,					/* flavor is translated by sender */
	flavorNotSaved				= 0x00000004L,					/* flavor should not be saved */
	flavorSystemTranslated		= 0x00000100L					/* flavor is translated by system */
};

typedef unsigned long FlavorFlags;


enum {
/* Drag Attributes */
	dragHasLeftSenderWindow		= 0x00000001L,					/* drag has left the source window since TrackDrag */
	dragInsideSenderApplication	= 0x00000002L,					/* drag is occurring within the sender application */
	dragInsideSenderWindow		= 0x00000004L					/* drag is occurring within the sender window */
};

typedef unsigned long DragAttributes;


enum {
/* Special Flavor Types */
	flavorTypeHFS				= 'hfs ',						/* flavor type for HFS data */
	flavorTypePromiseHFS		= 'phfs',						/* flavor type for promised HFS data */
	flavorTypeDirectory			= 'diry'
};

enum {
/* Drag Tracking Handler Messages */
	dragTrackingEnterHandler	= 1,							/* drag has entered handler */
	dragTrackingEnterWindow		= 2,							/* drag has entered window */
	dragTrackingInWindow		= 3,							/* drag is moving within window */
	dragTrackingLeaveWindow		= 4,							/* drag has exited window */
	dragTrackingLeaveHandler	= 5								/* drag has exited handler */
};

typedef short DragTrackingMessage;


enum {
/* Drag Drawing Procedure Messages */
	dragRegionBegin				= 1,							/* initialize drawing */
	dragRegionDraw				= 2,							/* draw drag feedback */
	dragRegionHide				= 3,							/* hide drag feedback */
	dragRegionIdle				= 4,							/* drag feedback idle time */
	dragRegionEnd				= 5								/* end of drawing */
};

typedef short DragRegionMessage;


enum {
/* Zoom Acceleration */
	zoomNoAcceleration			= 0,							/* use linear interpolation */
	zoomAccelerate				= 1,							/* ramp up step size */
	zoomDecelerate				= 2								/* ramp down step size */
};

typedef short ZoomAcceleration;

/* Drag Manager Data Types */
typedef unsigned long DragReference;

typedef unsigned long ItemReference;

typedef ResType FlavorType;

/* HFS Flavors */
struct HFSFlavor {
	OSType							fileType;					/* file type */
	OSType							fileCreator;				/* file creator */
	unsigned short					fdFlags;					/* Finder flags */
	FSSpec							fileSpec;					/* file system specification */
};
typedef struct HFSFlavor HFSFlavor;

struct PromiseHFSFlavor {
	OSType							fileType;					/* file type */
	OSType							fileCreator;				/* file creator */
	unsigned short					fdFlags;					/* Finder flags */
	FlavorType						promisedFlavor;				/* promised flavor containing an FSSpec */
};
typedef struct PromiseHFSFlavor PromiseHFSFlavor;

/* Application-Defined Drag Handler Routines */
typedef pascal OSErr (*DragTrackingHandlerProcPtr)(DragTrackingMessage message, WindowPtr theWindow, void *handlerRefCon, DragReference theDragRef);

#if GENERATINGCFM
typedef UniversalProcPtr DragTrackingHandlerUPP;
#else
typedef DragTrackingHandlerProcPtr DragTrackingHandlerUPP;
#endif

enum {
	uppDragTrackingHandlerProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DragTrackingMessage)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(WindowPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(DragReference)))
};

#if GENERATINGCFM
#define NewDragTrackingHandlerProc(userRoutine)		\
		(DragTrackingHandlerUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragTrackingHandlerProcInfo, GetCurrentArchitecture())
#else
#define NewDragTrackingHandlerProc(userRoutine)		\
		((DragTrackingHandlerUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDragTrackingHandlerProc(userRoutine, message, theWindow, handlerRefCon, theDragRef)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDragTrackingHandlerProcInfo, (message), (theWindow), (handlerRefCon), (theDragRef))
#else
#define CallDragTrackingHandlerProc(userRoutine, message, theWindow, handlerRefCon, theDragRef)		\
		(*(userRoutine))((message), (theWindow), (handlerRefCon), (theDragRef))
#endif

typedef DragTrackingHandlerUPP DragTrackingHandler;

typedef pascal OSErr (*DragReceiveHandlerProcPtr)(WindowPtr theWindow, void *handlerRefCon, DragReference theDragRef);

#if GENERATINGCFM
typedef UniversalProcPtr DragReceiveHandlerUPP;
#else
typedef DragReceiveHandlerProcPtr DragReceiveHandlerUPP;
#endif

enum {
	uppDragReceiveHandlerProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(DragReference)))
};

#if GENERATINGCFM
#define NewDragReceiveHandlerProc(userRoutine)		\
		(DragReceiveHandlerUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragReceiveHandlerProcInfo, GetCurrentArchitecture())
#else
#define NewDragReceiveHandlerProc(userRoutine)		\
		((DragReceiveHandlerUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDragReceiveHandlerProc(userRoutine, theWindow, handlerRefCon, theDragRef)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDragReceiveHandlerProcInfo, (theWindow), (handlerRefCon), (theDragRef))
#else
#define CallDragReceiveHandlerProc(userRoutine, theWindow, handlerRefCon, theDragRef)		\
		(*(userRoutine))((theWindow), (handlerRefCon), (theDragRef))
#endif

typedef DragReceiveHandlerUPP DragReceiveHandler;

/* Application-Defined Routines */
typedef pascal OSErr (*DragSendDataProcPtr)(FlavorType theType, void *dragSendRefCon, ItemReference theItemRef, DragReference theDragRef);

#if GENERATINGCFM
typedef UniversalProcPtr DragSendDataUPP;
#else
typedef DragSendDataProcPtr DragSendDataUPP;
#endif

enum {
	uppDragSendDataProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(FlavorType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(ItemReference)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(DragReference)))
};

#if GENERATINGCFM
#define NewDragSendDataProc(userRoutine)		\
		(DragSendDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragSendDataProcInfo, GetCurrentArchitecture())
#else
#define NewDragSendDataProc(userRoutine)		\
		((DragSendDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDragSendDataProc(userRoutine, theType, dragSendRefCon, theItemRef, theDragRef)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDragSendDataProcInfo, (theType), (dragSendRefCon), (theItemRef), (theDragRef))
#else
#define CallDragSendDataProc(userRoutine, theType, dragSendRefCon, theItemRef, theDragRef)		\
		(*(userRoutine))((theType), (dragSendRefCon), (theItemRef), (theDragRef))
#endif

typedef DragSendDataUPP DragSendDataProc;

typedef pascal OSErr (*DragInputProcPtr)(Point *mouse, short *modifiers, void *dragInputRefCon, DragReference theDragRef);

#if GENERATINGCFM
typedef UniversalProcPtr DragInputUPP;
#else
typedef DragInputProcPtr DragInputUPP;
#endif

enum {
	uppDragInputProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Point*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(DragReference)))
};

#if GENERATINGCFM
#define NewDragInputProc(userRoutine)		\
		(DragInputUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragInputProcInfo, GetCurrentArchitecture())
#else
#define NewDragInputProc(userRoutine)		\
		((DragInputUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDragInputProc(userRoutine, mouse, modifiers, dragInputRefCon, theDragRef)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDragInputProcInfo, (mouse), (modifiers), (dragInputRefCon), (theDragRef))
#else
#define CallDragInputProc(userRoutine, mouse, modifiers, dragInputRefCon, theDragRef)		\
		(*(userRoutine))((mouse), (modifiers), (dragInputRefCon), (theDragRef))
#endif

typedef DragInputUPP DragInputProc;

typedef pascal OSErr (*DragDrawingProcPtr)(DragRegionMessage message, RgnHandle showRegion, Point showOrigin, RgnHandle hideRegion, Point hideOrigin, void *dragDrawingRefCon, DragReference theDragRef);

#if GENERATINGCFM
typedef UniversalProcPtr DragDrawingUPP;
#else
typedef DragDrawingProcPtr DragDrawingUPP;
#endif

enum {
	uppDragDrawingProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DragRegionMessage)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Point)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(Point)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(DragReference)))
};

#if GENERATINGCFM
#define NewDragDrawingProc(userRoutine)		\
		(DragDrawingUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragDrawingProcInfo, GetCurrentArchitecture())
#else
#define NewDragDrawingProc(userRoutine)		\
		((DragDrawingUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDragDrawingProc(userRoutine, message, showRegion, showOrigin, hideRegion, hideOrigin, dragDrawingRefCon, theDragRef)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDragDrawingProcInfo, (message), (showRegion), (showOrigin), (hideRegion), (hideOrigin), (dragDrawingRefCon), (theDragRef))
#else
#define CallDragDrawingProc(userRoutine, message, showRegion, showOrigin, hideRegion, hideOrigin, dragDrawingRefCon, theDragRef)		\
		(*(userRoutine))((message), (showRegion), (showOrigin), (hideRegion), (hideOrigin), (dragDrawingRefCon), (theDragRef))
#endif

typedef DragDrawingUPP DragDrawingProc;

/* Drag Manager Routines */
/* Installing and Removing Drag Handlers */
extern pascal OSErr InstallTrackingHandler(DragTrackingHandler trackingHandler, WindowPtr theWindow, void *handlerRefCon)
 TWOWORDINLINE(0x7001, 0xABED);
extern pascal OSErr InstallReceiveHandler(DragReceiveHandler receiveHandler, WindowPtr theWindow, void *handlerRefCon)
 TWOWORDINLINE(0x7002, 0xABED);
extern pascal OSErr RemoveTrackingHandler(DragTrackingHandler trackingHandler, WindowPtr theWindow)
 TWOWORDINLINE(0x7003, 0xABED);
extern pascal OSErr RemoveReceiveHandler(DragReceiveHandler receiveHandler, WindowPtr theWindow)
 TWOWORDINLINE(0x7004, 0xABED);
/* Creating and Disposing Drag References */
extern pascal OSErr NewDrag(DragReference *theDragRef)
 TWOWORDINLINE(0x7005, 0xABED);
extern pascal OSErr DisposeDrag(DragReference theDragRef)
 TWOWORDINLINE(0x7006, 0xABED);
/* Adding Drag Item Flavors */
extern pascal OSErr AddDragItemFlavor(DragReference theDragRef, ItemReference theItemRef, FlavorType theType, const void *dataPtr, Size dataSize, FlavorFlags theFlags)
 TWOWORDINLINE(0x7007, 0xABED);
extern pascal OSErr SetDragItemFlavorData(DragReference theDragRef, ItemReference theItemRef, FlavorType theType, const void *dataPtr, Size dataSize, unsigned long dataOffset)
 TWOWORDINLINE(0x7009, 0xABED);
/* Providing Drag Callback Procedures */
extern pascal OSErr SetDragSendProc(DragReference theDragRef, DragSendDataProc sendProc, void *dragSendRefCon)
 TWOWORDINLINE(0x700A, 0xABED);
extern pascal OSErr SetDragInputProc(DragReference theDragRef, DragInputProc inputProc, void *dragInputRefCon)
 TWOWORDINLINE(0x700B, 0xABED);
extern pascal OSErr SetDragDrawingProc(DragReference theDragRef, DragDrawingProc drawingProc, void *dragDrawingRefCon)
 TWOWORDINLINE(0x700C, 0xABED);
extern pascal OSErr TrackDrag(DragReference theDragRef, const EventRecord *theEvent, RgnHandle theRegion)
 TWOWORDINLINE(0x700D, 0xABED);
/* Getting Drag Item Information */
extern pascal OSErr CountDragItems(DragReference theDragRef, unsigned short *numItems)
 TWOWORDINLINE(0x700E, 0xABED);
extern pascal OSErr GetDragItemReferenceNumber(DragReference theDragRef, unsigned short index, ItemReference *theItemRef)
 TWOWORDINLINE(0x700F, 0xABED);
extern pascal OSErr CountDragItemFlavors(DragReference theDragRef, ItemReference theItemRef, unsigned short *numFlavors)
 TWOWORDINLINE(0x7010, 0xABED);
extern pascal OSErr GetFlavorType(DragReference theDragRef, ItemReference theItemRef, unsigned short index, FlavorType *theType)
 TWOWORDINLINE(0x7011, 0xABED);
extern pascal OSErr GetFlavorFlags(DragReference theDragRef, ItemReference theItemRef, FlavorType theType, FlavorFlags *theFlags)
 TWOWORDINLINE(0x7012, 0xABED);
extern pascal OSErr GetFlavorDataSize(DragReference theDragRef, ItemReference theItemRef, FlavorType theType, Size *dataSize)
 TWOWORDINLINE(0x7013, 0xABED);
extern pascal OSErr GetFlavorData(DragReference theDragRef, ItemReference theItemRef, FlavorType theType, void *dataPtr, Size *dataSize, unsigned long dataOffset)
 TWOWORDINLINE(0x7014, 0xABED);
extern pascal OSErr GetDragItemBounds(DragReference theDragRef, ItemReference theItemRef, Rect *itemBounds)
 TWOWORDINLINE(0x7015, 0xABED);
extern pascal OSErr SetDragItemBounds(DragReference theDragRef, ItemReference theItemRef, const Rect *itemBounds)
 TWOWORDINLINE(0x7016, 0xABED);
extern pascal OSErr GetDropLocation(DragReference theDragRef, AEDesc *dropLocation)
 TWOWORDINLINE(0x7017, 0xABED);
extern pascal OSErr SetDropLocation(DragReference theDragRef, const AEDesc *dropLocation)
 TWOWORDINLINE(0x7018, 0xABED);
/* Getting Information About a Drag */
extern pascal OSErr GetDragAttributes(DragReference theDragRef, DragAttributes *flags)
 TWOWORDINLINE(0x7019, 0xABED);
extern pascal OSErr GetDragMouse(DragReference theDragRef, Point *mouse, Point *pinnedMouse)
 TWOWORDINLINE(0x701A, 0xABED);
extern pascal OSErr SetDragMouse(DragReference theDragRef, Point pinnedMouse)
 TWOWORDINLINE(0x701B, 0xABED);
extern pascal OSErr GetDragOrigin(DragReference theDragRef, Point *initialMouse)
 TWOWORDINLINE(0x701C, 0xABED);
extern pascal OSErr GetDragModifiers(DragReference theDragRef, short *modifiers, short *mouseDownModifiers, short *mouseUpModifiers)
 TWOWORDINLINE(0x701D, 0xABED);
/* Drag Highlighting */
extern pascal OSErr ShowDragHilite(DragReference theDragRef, RgnHandle hiliteFrame, Boolean inside)
 TWOWORDINLINE(0x701E, 0xABED);
extern pascal OSErr HideDragHilite(DragReference theDragRef)
 TWOWORDINLINE(0x701F, 0xABED);
extern pascal OSErr DragPreScroll(DragReference theDragRef, short dH, short dV)
 TWOWORDINLINE(0x7020, 0xABED);
extern pascal OSErr DragPostScroll(DragReference theDragRef)
 TWOWORDINLINE(0x7021, 0xABED);
extern pascal OSErr UpdateDragHilite(DragReference theDragRef, RgnHandle updateRgn)
 TWOWORDINLINE(0x7022, 0xABED);
/* Drag Manager Utilities */
extern pascal Boolean WaitMouseMoved(Point initialMouse)
 TWOWORDINLINE(0x7023, 0xABED);
extern pascal OSErr ZoomRects(const Rect *fromRect, const Rect *toRect, short zoomSteps, ZoomAcceleration acceleration)
 TWOWORDINLINE(0x7024, 0xABED);
extern pascal OSErr ZoomRegion(RgnHandle region, Point zoomDistance, short zoomSteps, ZoomAcceleration acceleration)
 TWOWORDINLINE(0x7025, 0xABED);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __DRAG__ */
