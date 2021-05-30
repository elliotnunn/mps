/*
	Controls.h -- Color Control Manager interface 

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-87
	All rights reserved.
*/

#ifndef __CONTROLS__
#define __CONTROLS__
#ifndef __QUICKDRAW__
#include <QuickDraw.h>
#endif

#define pushButProc 0
#define checkBoxProc 1
#define radioButProc 2
#define useWFont 8
#define scrollBarProc 16
#define inButton 10
#define inCheckBox 11
#define inUpButton 20
#define inDownButton 21
#define inPageUp 22
#define inPageDown 23
#define inThumb 129
#define noConstraint 0
#define hAxisOnly 1
#define vAxisOnly 2
#define drawCntl 0
#define testCntl 1
#define calcCRgns 2
#define initCntl 3
#define dispCntl 4
#define posCntl 5
#define thumbCntl 6
#define dragCntl 7
#define autoTrack 8

typedef struct ControlRecord {
	struct ControlRecord **nextControl;
	struct GrafPort *contrlOwner;
	Rect contrlRect;
	unsigned char contrlVis;
	unsigned char contrlHilite;
	short contrlValue;
	short contrlMin;
	short contrlMax;
	Handle contrlDefProc;
	Handle contrlData;
	ProcPtr contrlAction;
	long contrlRfCon;
	Str255 contrlTitle;
} ControlRecord,*ControlPtr,**ControlHandle;

ControlHandle NewControl();
pascal ControlHandle GetNewControl(controlID,theWindow)
	short controlID;
	struct GrafPort *theWindow;
	extern 0xA9BE;
pascal void DisposeControl(theControl)
	ControlHandle theControl;
	extern 0xA955;
pascal void KillControls(theWindow)
	struct GrafPort *theWindow;
	extern 0xA956;
pascal void HideControl(theControl)
	ControlHandle theControl;
	extern 0xA958;
pascal void ShowControl(theControl)
	ControlHandle theControl;
	extern 0xA957;
pascal void DrawControls(theWindow)
	struct GrafPort *theWindow;
	extern 0xA969;
pascal void Draw1Control(theControl)
	ControlHandle theControl;
	extern 0xA96D;
pascal void HiliteControl(theControl,hiliteState)
	ControlHandle theControl;
	short hiliteState;
	extern 0xA95D;
pascal void UpdtControl(theWindow,updateRgn)
	struct GrafPort *theWindow;
	RgnHandle updateRgn;
	extern 0xA953;
pascal void MoveControl(theControl,h,v)
	ControlHandle theControl;
	short h;
	short v;
	extern 0xA959;
pascal void SizeControl(theControl,w,h)
	ControlHandle theControl;
	short w;
	short h;
	extern 0xA95C;
pascal void SetCtlValue(theControl,theValue)
	ControlHandle theControl;
	short theValue;
	extern 0xA963;
pascal short GetCtlValue(theControl)
	ControlHandle theControl;
	extern 0xA960;
pascal void SetCtlMin(theControl,minValue)
	ControlHandle theControl;
	short minValue;
	extern 0xA964;
pascal short GetCtlMin(theControl)
	ControlHandle theControl;
	extern 0xA961;
pascal void SetCtlMax(theControl,maxValue)
	ControlHandle theControl;
	short maxValue;
	extern 0xA965;
pascal short GetCtlMax(theControl)
	ControlHandle theControl;
	extern 0xA962;
pascal void SetCRefCon(theControl,data)
	ControlHandle theControl;
	long data;
	extern 0xA95B;
pascal long GetCRefCon(theControl)
	ControlHandle theControl;
	extern 0xA95A;
pascal void SetCtlAction(theControl,actionProc)
	ControlHandle theControl;
	ProcPtr actionProc;
	extern 0xA96B;
pascal ProcPtr GetCtlAction(theControl)
	ControlHandle theControl;
	extern 0xA96A;



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


	/* Constants for the colors of control parts */

#define cFrameColor			0
#define cBodyColor			1
#define cTextColor			2
#define cElevatorColor		3


typedef struct AuxCtlRec{
	Handle			nextAuxCtl;			/* handle to next AuxCtlRec */
	ControlHandle	auxCtlOwner;		/* handle for aux record's control */
	CTabHandle		ctlCTable;			/* color table for this control */
	short			auxCtlFlags;		/* misc flag byte */
	long			caReserved;			/* reserved for use by Apple */
	long			caRefCon;			/* for use by application */
} AuxCtlRec, *AuxCtlPtr, **AuxCtlHndl;

	
typedef struct CtlCTab{
	long			ccSeed;				/* reserved */
	short			ccRider;			/* see what you have done - reserved */
	short			ctSize;				/* usually 3 for controls */
	ColorSpec		ctTable[4];
} CtlCTab, *CCTabPtr, **CCTabHandle;
					  	
							
pascal void SetCtlColor(theControl, newColorTable)
	ControlHandle theControl;
	CCTabHandle newColorTable;
	extern 0xAA43;
pascal Boolean GetAuxCtl(theControl, ACHndl)
	ControlHandle theControl;
	AuxCtlHndl *ACHndl;
	extern 0xAA44;
pascal short GetCVariant(theControl)
	ControlHandle theControl;
	extern 0xA809;


#endif
#endif
