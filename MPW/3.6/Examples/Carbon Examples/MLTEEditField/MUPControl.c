/*
    File: mUPControl.c
    
    Description:
        mUPControl implementation.

 	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	Copyright © 2000-2001 Apple Computer, Inc., All Rights Reserved
*/



#include "mUPControl.h"
#include "CurrentEvent.h"

#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

enum {
	kShiftKeyCode = 56
};

/* kUserClickedToFocusPart is a part code we pass to the SetKeyboardFocus
	routine.  In our focus switching routine this part code is understood
	as meaning 'the user has clicked in the control and we need to switch
	the current focus to ourselves before we can continue'. */
#define kUserClickedToFocusPart 100


/* kmUPClickScrollDelayTicks is a time measurement in ticks used to
	slow the speed of 'auto scrolling' inside of our clickloop routine.
	This value prevents the text from wizzzzzing by while the mouse
	is being held down inside of the text area. */
#define kmUPClickScrollDelayTicks 3


/* STPTextPaneVars is a structure used for storing the the mUP Control's
	internal variables and state information.  A handle to this record is
	stored in the pane control's reference value field using the
	SetControlReference routine. */

typedef struct {
		/* OS records referenced */
	TXNObject fTXNRec; /* the txn record */
	TXNFrameID fTXNFrame; /* the txn frame ID */
	ControlHandle fUserPaneRec;  /* handle to the user pane control */
	WindowPtr fOwner; /* window containing control */
	CGrafPtr fDrawingEnvironment; /* grafport where control is drawn */
		/* flags */
	Boolean fInFocus; /* true while the focus rect is drawn around the control */
	Boolean fIsActive; /* true while the control is drawn in the active state */
	Boolean fTEActive; /* reflects the activation state of the text edit record */ 
	Boolean fInDialogWindow; /* true if displayed in a dialog window */ 
		/* calculated locations */
	Rect fRTextArea; /* area where the text is drawn */
	Rect fRFocusOutline;  /* rectangle used to draw the focus box */
	Rect fRTextOutline; /* rectangle used to draw the border */
	RgnHandle fTextBackgroundRgn; /* background region for the text, erased before calling TEUpdate */
		/* our focus advance override routine */
	EventHandlerUPP handlerUPP;
	EventHandlerRef handlerRef;
} STPTextPaneVars;




/* Univerals Procedure Pointer variables used by the
	mUP Control.  These variables are set up
	the first time that mUPOpenControl is called. */
ControlUserPaneDrawUPP gTPDrawProc = NULL;
ControlUserPaneHitTestUPP gTPHitProc = NULL;
ControlUserPaneTrackingUPP gTPTrackProc = NULL;
ControlUserPaneIdleUPP gTPIdleProc = NULL;
ControlUserPaneKeyDownUPP gTPKeyProc = NULL;
ControlUserPaneActivateUPP gTPActivateProc = NULL;
ControlUserPaneFocusUPP gTPFocusProc = NULL;

	/* events handled by our focus advance override routine */
static const EventTypeSpec gMLTEEvents[] = { { kEventClassTextInput, kEventTextInputUnicodeForKeyEvent } };
#define kMLTEEventCount (sizeof( gMLTEEvents ) / sizeof( EventTypeSpec ))



/* TPActivatePaneText activates or deactivates the text edit record
	according to the value of setActive.  The primary purpose of this
	routine is to ensure each call is only made once. */
static void TPActivatePaneText(STPTextPaneVars **tpvars, Boolean setActive) {
	STPTextPaneVars *varsp;
	varsp = *tpvars;
	if (varsp->fTEActive != setActive) {
	
		varsp->fTEActive = setActive;
		
		TXNActivate(varsp->fTXNRec, varsp->fTXNFrame, varsp->fTEActive);
		
		if (varsp->fInFocus)
			TXNFocus( varsp->fTXNRec, varsp->fTEActive);
	}
}


/* TPFocusPaneText set the focus state for the text record. */
static void TPFocusPaneText(STPTextPaneVars **tpvars, Boolean setFocus) {
	STPTextPaneVars *varsp;
	varsp = *tpvars;
	if (varsp->fInFocus != setFocus) {
		varsp->fInFocus = setFocus;
		TXNFocus( varsp->fTXNRec, varsp->fInFocus);
	}
}


  


/* TPPaneDrawEntry and TPPaneDrawExit are utility routines used for
	saving and restoring the port's drawing color and pen mode.  They
	are intended to be used around all calls to text edit that may
	draw something on the screen.  These routines ensure that the
	text will be drawn black with a white background. */


/* STPPaneState is used to store the drawing enviroment information */

typedef struct {
	STPTextPaneVars **tpvars;
	RGBColor sForground, sBackground;
	PenState sPen;
} STPPaneState;





/* TPPaneDrawEntry sets the current grafport to the mUP control's
	grafport and it sets up the drawing colors in preparation for
	drawing the text field (after saving the current drawing colors). */
static void TPPaneDrawEntry(STPTextPaneVars **tpvars, STPPaneState *ps) {
	RGBColor rgbWhite = {0xFFFF, 0xFFFF, 0xFFFF}, rgbBlack = {0, 0, 0};
	Rect gbounds;
	GDHandle dev;
		/* save vars ptr */
	ps->tpvars = tpvars;
		/* set the port to our window */
	SetPort((**tpvars).fDrawingEnvironment);
		/* save the current drawing colors */
	GetForeColor(&ps->sForground);
	GetBackColor(&ps->sBackground);
		/* set the drawing colors to black and white */
	RGBForeColor(&rgbBlack);
	RGBBackColor(&rgbWhite);
		/* save the pen state.  Paranoia?  what?  What? */
	GetPenState(&ps->sPen);
		/* theme pen too!!! */
	gbounds = (**tpvars).fRTextArea;
	LocalToGlobal((Point*) &gbounds.top);
	LocalToGlobal((Point*) &gbounds.bottom);
	dev = GetMaxDevice(&gbounds);
	if (dev != NULL) {
		SetThemePen(  kThemeBrushBlack, GetPixDepth((**dev).gdPMap), true);
		SetThemeBackground( kThemeBrushWhite, GetPixDepth((**dev).gdPMap), true);
	}
}

/* TPPaneDrawExit should be called after TPPaneDrawEntry.  This
	routine restores the drawing colors that were saved away
	by TPPaneDrawEntry. */
static void TPPaneDrawExit(STPPaneState *ps) {
	Rect gbounds;
	GDHandle dev;
		/* set the port to our window */
	SetPort((**ps->tpvars).fDrawingEnvironment);
		/* restore the colors and the pen state */
	RGBForeColor(&ps->sForground);
	RGBBackColor(&ps->sBackground);
	SetPenState(&ps->sPen);
		/* theme background too!!! */
	gbounds = (**ps->tpvars).fRTextArea;
	LocalToGlobal((Point*) &gbounds.top);
	LocalToGlobal((Point*) &gbounds.bottom);
	dev = GetMaxDevice(&gbounds);
	if (dev != NULL) {
		ThemeBrush brushToUse;
		if ((**ps->tpvars).fInDialogWindow)
			brushToUse = ((**ps->tpvars).fIsActive ? kThemeBrushDialogBackgroundActive : kThemeBrushDialogBackgroundInactive);
		else brushToUse = kThemeBrushDocumentWindowBackground;
		SetThemeBackground( brushToUse, GetPixDepth((**dev).gdPMap), true);
	}
}



/* TPPaneDrawProc is called to redraw the control and for update events
	referring to the control.  This routine erases the text area's background,
	and redraws the text.  This routine assumes the scroll bar has been
	redrawn by a call to DrawControls. */
static pascal void TPPaneDrawProc(ControlRef theControl, ControlPartCode thePart) {
	STPPaneState ps;
	STPTextPaneVars **tpvars, *varsp;
	char state;
	Rect bounds;
		/* set up our globals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
		state = HGetState((Handle) tpvars);
		HLock((Handle) tpvars);
		varsp = *tpvars;
			
			/* save the drawing state */
		TPPaneDrawEntry(tpvars, &ps);

			/* verify our boundary */
		GetControlBounds(theControl, &bounds);
		if ( ! EqualRect(&bounds, &varsp->fRTextArea) ) {
			SetRect(&varsp->fRFocusOutline, bounds.left, bounds.top, bounds.right, bounds.bottom);
			SetRect(&varsp->fRTextOutline, bounds.left, bounds.top, bounds.right, bounds.bottom);
			SetRect(&varsp->fRTextArea, bounds.left, bounds.top, bounds.right, bounds.bottom);
			RectRgn(varsp->fTextBackgroundRgn, &varsp->fRTextOutline);
			TXNSetFrameBounds(  varsp->fTXNRec, bounds.top, bounds.left, bounds.bottom, bounds.right, varsp->fTXNFrame);
		}

			/* update the text region */
		EraseRgn(varsp->fTextBackgroundRgn);
		TXNDraw(varsp->fTXNRec, NULL);
			/* restore the drawing environment */
		TPPaneDrawExit(&ps);
			/* draw the text frame and focus frame (if necessary) */
		DrawThemeEditTextFrame(&varsp->fRTextOutline, varsp->fIsActive ? kThemeStateActive: kThemeStateInactive);
		if ((**tpvars).fIsActive && varsp->fInFocus) DrawThemeFocusRect(&varsp->fRFocusOutline, true);
			/* release our globals */
		HSetState((Handle) tpvars, state);
	}
}


/* TPPaneHitTestProc is called when the control manager would
	like to determine what part of the control the mouse resides over.
	We also call this routine from our tracking proc to determine how
	to handle mouse clicks. */
static pascal ControlPartCode TPPaneHitTestProc(ControlHandle theControl, Point where) {
	STPTextPaneVars **tpvars;
	ControlPartCode result;
	char state;
		/* set up our locals and lock down our globals*/
	result = 0;
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
		state = HGetState((Handle) tpvars);
		HLock((Handle) tpvars);
			/* find the region where we clicked */
		if (PtInRect(where, &(**tpvars).fRTextArea)) {
			result = kmUPTextPart;
		} else result = 0;
			/* release oure globals */
		HSetState((Handle) tpvars, state);
	}
	return result;
}





/* TPPaneTrackingProc is called when the mouse is being held down
	over our control.  This routine handles clicks in the text area
	and in the scroll bar. */
static pascal ControlPartCode TPPaneTrackingProc(ControlHandle theControl, Point startPt, ControlActionUPP actionProc) {
	STPTextPaneVars **tpvars, *varsp;
	char state;
	ControlPartCode partCodeResult;
		/* make sure we have some variables... */
	partCodeResult = 0;
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
			/* lock 'em down */
		state = HGetState((Handle) tpvars);
		HLock((Handle) tpvars);
		varsp = *tpvars;
			/* we don't do any of these functions unless we're in focus */
		if ( ! varsp->fInFocus) {
			WindowPtr owner;
			owner = GetControlOwner(theControl);
			ClearKeyboardFocus(owner);
			SetKeyboardFocus(owner, theControl, kUserClickedToFocusPart);
		}
			/* find the location for the click */
		switch (TPPaneHitTestProc(theControl, startPt)) {
				
				/* handle clicks in the text part */
			case kmUPTextPart:
				
				TXNClick( varsp->fTXNRec, GetCurrentEventRecord());

				break;
			
		}
		
		HSetState((Handle) tpvars, state);
	}
	return partCodeResult;
}


/* TPPaneIdleProc is our user pane idle routine.  When our text field
	is active and in focus, we use this routine to set the cursor. */
static pascal void TPPaneIdleProc(ControlHandle theControl) {
	STPTextPaneVars **tpvars, *varsp;
		/* set up locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
			/* if we're not active, then we have nothing to say about the cursor */
		if ((**tpvars).fIsActive) {
			char state;
			Rect bounds;
			Point mousep;
				/* lock down the globals */
			state = HGetState((Handle) tpvars);
			HLock((Handle) tpvars);
			varsp = *tpvars;
				/* get the current mouse coordinates (in our window) */
			SetPort(GetWindowPort(GetControlOwner(theControl)));
			GetMouse(&mousep);
				/* there's a 'focus thing' and an 'unfocused thing' */
			if (varsp->fInFocus) {
				STPPaneState ps;
					/* flash the cursor */
				TPPaneDrawEntry(tpvars, &ps);
					TXNIdle(varsp->fTXNRec);
					/* set the cursor */
					if (PtInRect(mousep, &varsp->fRTextArea)) {
						RgnHandle theRgn;
						RectRgn((theRgn = NewRgn()), &varsp->fRTextArea);
						TXNAdjustCursor(varsp->fTXNRec, theRgn);
						DisposeRgn(theRgn);
					 } else SetThemeCursor(kThemeArrowCursor);
				TPPaneDrawExit(&ps);
			} else {
				/* if it's in our bounds, set the cursor */
				GetControlBounds(theControl, &bounds);
				if (PtInRect(mousep, &bounds))
					SetThemeCursor(kThemeArrowCursor);
			}
			
			HSetState((Handle) tpvars, state);
		}
	}
}


/* TPPaneKeyDownProc is called whenever a keydown event is directed
	at our control.  Here, we direct the keydown event to the text
	edit record and redraw the scroll bar and text field as appropriate. */
static pascal ControlPartCode TPPaneKeyDownProc(ControlHandle theControl,
							SInt16 keyCode, SInt16 charCode, SInt16 modifiers) {
	STPTextPaneVars **tpvars;
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
		if ((**tpvars).fInFocus) {
			STPPaneState ps;
				/* turn autoscrolling on and send the key event to text edit */
			TPPaneDrawEntry(tpvars, &ps);
			TXNKeyDown( (**tpvars).fTXNRec, GetCurrentEventRecord());
			TPPaneDrawExit(&ps);
		}
	}
	return kControlEntireControl;
}


/* TPPaneActivateProc is called when the window containing
	the user pane control receives activate events. Here, we redraw
	the control and it's text as necessary for the activation state. */
static pascal void TPPaneActivateProc(ControlHandle theControl, Boolean activating) {
	Rect bounds;
	STPPaneState ps;
	STPTextPaneVars **tpvars, *varsp;
	char state;
		/* set up locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
		state = HGetState((Handle) tpvars);
		HLock((Handle) tpvars);
		varsp = *tpvars;
			/* de/activate the text edit record */
		TPPaneDrawEntry(tpvars, &ps);
			GetControlBounds(theControl, &bounds);
			varsp->fIsActive = activating;
			TPActivatePaneText(tpvars, varsp->fIsActive && varsp->fInFocus);
		TPPaneDrawExit(&ps);
			/* redraw the frame */
		DrawThemeEditTextFrame(&varsp->fRTextOutline, varsp->fIsActive ? kThemeStateActive: kThemeStateInactive);
		if (varsp->fInFocus) DrawThemeFocusRect(&varsp->fRFocusOutline, varsp->fIsActive);
		HSetState((Handle) tpvars, state);
	}
}


/* TPPaneFocusProc is called when every the focus changes to or
	from our control.  Herein, switch the focus appropriately
	according to the parameters and redraw the control as
	necessary.  */
static pascal ControlPartCode TPPaneFocusProc(ControlHandle theControl, ControlFocusPart action) {
	STPPaneState ps;
	ControlPartCode focusResult;
	STPTextPaneVars **tpvars, *varsp;
	char state;
		/* set up locals */
	focusResult = kControlFocusNoPart;
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
	if (tpvars != NULL) {
		state = HGetState((Handle) tpvars);
		HLock((Handle) tpvars);
		varsp = *tpvars;
			/* if kControlFocusPrevPart and kControlFocusNextPart are received when the user is
			tabbing forwards (or shift tabbing backwards) through the items in the dialog,
			and kControlFocusNextPart will be received.  When the user clicks in our field
			and it is not the current focus, then the constant kUserClickedToFocusPart will
			be received.  The constant kControlFocusNoPart will be received when our control
			is the current focus and the user clicks in another control.  In your focus routine,
			you should respond to these codes as follows:

			kControlFocusNoPart - turn off focus and return kControlFocusNoPart.  redraw
				the control and the focus rectangle as necessary.

			kControlFocusPrevPart or kControlFocusNextPart - toggle focus on or off
				depending on its current state.  redraw the control and the focus rectangle
				as appropriate for the new focus state.  If the focus state is 'off', return the constant
				kControlFocusNoPart, otherwise return a non-zero part code.
			kUserClickedToFocusPart - is a constant defined for this example.  You should
				define your own value for handling click-to-focus type events. */
		switch (action) {
			default:
			case kControlFocusNoPart:
				TPFocusPaneText(tpvars, false);
				focusResult = kControlFocusNoPart;
				break;
			case kUserClickedToFocusPart:
				TPFocusPaneText(tpvars, true);
				focusResult = 1;
				break;
			case kControlFocusPrevPart:
			case kControlFocusNextPart:
				TPFocusPaneText(tpvars, ( ! varsp->fInFocus));
				focusResult = varsp->fInFocus ? 1 : kControlFocusNoPart;
				break;
		}
			/* reactivate the text as necessary */
		TPPaneDrawEntry(tpvars, &ps);
			TPActivatePaneText(tpvars, varsp->fIsActive && varsp->fInFocus);
		TPPaneDrawExit(&ps);
			/* redraw the text fram and focus rectangle to indicate the
			new focus state */
		DrawThemeEditTextFrame(&varsp->fRTextOutline, varsp->fIsActive ? kThemeStateActive: kThemeStateInactive);
		DrawThemeFocusRect(&varsp->fRFocusOutline, varsp->fIsActive && varsp->fInFocus);
			/* done */
		HSetState((Handle) tpvars, state);
	}
	return focusResult;
}











//This our carbon event handler for unicode key downs
static pascal OSStatus FocusAdvanceOverride(EventHandlerCallRef myHandler, EventRef event, void* userData) {
	WindowRef window;
	STPTextPaneVars **tpvars;
	OSStatus err;
	unsigned short mUnicodeText;
	ByteCount charCounts=0;
		/* get our window pointer */
	tpvars = (STPTextPaneVars **) userData;
	window = (**tpvars).fOwner;
		//find out how many bytes are needed
	err = GetEventParameter(event, kEventParamTextInputSendText,
				typeUnicodeText, NULL, 0, &charCounts, NULL);
	if (err != noErr) goto bail;
		/* we're only looking at single characters */
	if (charCounts != 2) { err = eventNotHandledErr; goto bail; }
		/* get the character */
	err = GetEventParameter(event, kEventParamTextInputSendText, 
				typeUnicodeText, NULL, sizeof(mUnicodeText),
				&charCounts, (char*) &mUnicodeText);
	if (err != noErr) goto bail;
		/* if it's not the tab key, forget it... */
	if ((mUnicodeText != '\t')) { err = eventNotHandledErr; goto bail; }
		/* advance the keyboard focus */
	AdvanceKeyboardFocus(window);
		/* noErr lets the CEM know we handled the event */
	return noErr;
bail:
	
	return eventNotHandledErr;
}



/* mUPOpenControl initializes a user pane control so it will be drawn
	and will behave as a scrolling text edit field inside of a window.
	This routine performs all of the initialization steps necessary,
	except it does not create the user pane control itself.  theControl
	should refer to a user pane control that you have either created
	yourself or extracted from a dialog's control heirarchy using
	the GetDialogItemAsControl routine.  */
OSStatus mUPOpenControl(ControlHandle theControl) {
	Rect bounds;
	WindowPtr theWindow;
	STPTextPaneVars **tpvars, *varsp;
	STPPaneState ps;
	OSStatus err;
	RGBColor rgbWhite = {0xFFFF, 0xFFFF, 0xFFFF};
	TXNBackground tback;
	
		/* set up our globals */
	if (gTPDrawProc == NULL) gTPDrawProc = NewControlUserPaneDrawUPP(TPPaneDrawProc);
	if (gTPHitProc == NULL) gTPHitProc = NewControlUserPaneHitTestUPP(TPPaneHitTestProc);
	if (gTPTrackProc == NULL) gTPTrackProc = NewControlUserPaneTrackingUPP(TPPaneTrackingProc);
	if (gTPIdleProc == NULL) gTPIdleProc = NewControlUserPaneIdleUPP(TPPaneIdleProc);
	if (gTPKeyProc == NULL) gTPKeyProc = NewControlUserPaneKeyDownUPP(TPPaneKeyDownProc);
	if (gTPActivateProc == NULL) gTPActivateProc = NewControlUserPaneActivateUPP(TPPaneActivateProc);
	if (gTPFocusProc == NULL) gTPFocusProc = NewControlUserPaneFocusUPP(TPPaneFocusProc);
		
		/* allocate our private storage */
	tpvars = (STPTextPaneVars **) NewHandleClear(sizeof(STPTextPaneVars));
	SetControlReference(theControl, (long) tpvars);
	HLock((Handle) tpvars);
	varsp = *tpvars;
		/* set the initial settings for our private data */
	varsp->fInFocus = false;
	varsp->fIsActive = true;
	varsp->fTEActive = false;
	varsp->fUserPaneRec = theControl;
	theWindow = varsp->fOwner = GetControlOwner(theControl);
	varsp->fDrawingEnvironment = GetWindowPort(varsp->fOwner);
	varsp->fInDialogWindow = ( GetWindowKind(varsp->fOwner) == kDialogWindowKind );
		/* set up the user pane procedures */
	SetControlData(theControl, kControlEntireControl, kControlUserPaneDrawProcTag, sizeof(gTPDrawProc), &gTPDrawProc);
	SetControlData(theControl, kControlEntireControl, kControlUserPaneHitTestProcTag, sizeof(gTPHitProc), &gTPHitProc);
	SetControlData(theControl, kControlEntireControl, kControlUserPaneTrackingProcTag, sizeof(gTPTrackProc), &gTPTrackProc);
	SetControlData(theControl, kControlEntireControl, kControlUserPaneIdleProcTag, sizeof(gTPIdleProc), &gTPIdleProc);
	SetControlData(theControl, kControlEntireControl, kControlUserPaneKeyDownProcTag, sizeof(gTPKeyProc), &gTPKeyProc);
	SetControlData(theControl, kControlEntireControl, kControlUserPaneActivateProcTag, sizeof(gTPActivateProc), &gTPActivateProc);
	SetControlData(theControl, kControlEntireControl, kControlUserPaneFocusProcTag, sizeof(gTPFocusProc), &gTPFocusProc);
		/* calculate the rectangles used by the control */
	GetControlBounds(theControl, &bounds);
	SetRect(&varsp->fRFocusOutline, bounds.left, bounds.top, bounds.right, bounds.bottom);
	SetRect(&varsp->fRTextOutline, bounds.left, bounds.top, bounds.right, bounds.bottom);
	SetRect(&varsp->fRTextArea, bounds.left, bounds.top, bounds.right, bounds.bottom);
		/* calculate the background region for the text.  In this case, it's kindof
		and irregular region because we're setting the scroll bar a little ways inside
		of the text area. */
	RectRgn((varsp->fTextBackgroundRgn = NewRgn()), &varsp->fRTextOutline);

		/* allocate our text edit record */
	SetPort(varsp->fDrawingEnvironment);

		/* set up the drawing environment */
	TPPaneDrawEntry(tpvars, &ps);

		/* create the new edit field */
	TXNNewObject(NULL, varsp->fOwner, &varsp->fRTextArea,
		kTXNWantVScrollBarMask | kTXNAlwaysWrapAtViewEdgeMask,
		kTXNTextEditStyleFrameType,
		kTXNTextensionFile,
		kTXNSystemDefaultEncoding, 
		&varsp->fTXNRec, &varsp->fTXNFrame, (TXNObjectRefcon) tpvars);
		
		/* set the field's background */
	tback.bgType = kTXNBackgroundTypeRGB;
	tback.bg.color = rgbWhite;
	TXNSetBackground( varsp->fTXNRec, &tback);
	
		/* restore the drawing environment */
	TPPaneDrawExit(&ps);
	
		/* install our focus advance override routine */
	varsp->handlerUPP = NewEventHandlerUPP(FocusAdvanceOverride);
	err = InstallWindowEventHandler( varsp->fOwner, varsp->handlerUPP,
		kMLTEEventCount, gMLTEEvents, tpvars, &varsp->handlerRef );

		/* unlock our storage */
	HUnlock((Handle) tpvars);
		/* perform final activations and setup for our text field.  Here,
		we assume that the window is going to be the 'active' window. */
	TPActivatePaneText(tpvars, varsp->fIsActive && varsp->fInFocus);
		/* all done */
	return noErr;
}



/* mUPCloseControl deallocates all of the structures allocated
	by mUPOpenControl.  */
OSStatus mUPCloseControl(ControlHandle theControl) {
	STPTextPaneVars **tpvars;
		/* set up locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
		/* release our sub records */
	TXNDeleteObject((**tpvars).fTXNRec);
		/* remove our focus advance override */
	RemoveEventHandler((**tpvars).handlerRef);
	DisposeEventHandlerUPP((**tpvars).handlerUPP);
		/* delete our private storage */
	DisposeHandle((Handle) tpvars);
		/* zero the control reference */
	SetControlReference(theControl, 0);
	return noErr;
}




	/* mUPSetText replaces the contents of the selection with the unicode
	text described by the text and count parameters:.
		text = pointer to unicode text buffer
		count = number of bytes in the buffer.  */
OSStatus mUPSetText(ControlHandle theControl, char* text, long count) {
	STPTextPaneVars **tpvars;
		/* set up locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
		/* set the text in the record */
	return TXNSetData( (**tpvars).fTXNRec, kTXNUnicodeTextData, text, count,
		kTXNUseCurrentSelection, kTXNUseCurrentSelection);

	return noErr;
}


/* mUPSetSelection sets the text selection and autoscrolls the text view
	so either the cursor or the selction is in the view. */
void mUPSetSelection(ControlHandle theControl, long selStart, long selEnd) {
	STPTextPaneVars **tpvars;
	STPPaneState ps;
		/* set up our locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
		/* and our drawing environment as the operation
		may force a redraw in the text area. */
	TPPaneDrawEntry(tpvars, &ps);
		/* change the selection */
	TXNSetSelection( (**tpvars).fTXNRec, selStart, selEnd);
		/* restore the drawing enviroment */
	TPPaneDrawExit(&ps);
}





/* mUPGetText returns the current text data being displayed inside of
	the mUPControl.  When noErr is returned, *theText contain a new
	handle containing all of the Unicode text copied from the current
	selection.  It is the caller's responsibiliby to dispose of this handle. */
OSStatus mUPGetText(ControlHandle theControl, Handle *theText) {
	STPTextPaneVars **tpvars;
	OSStatus err;
		/* set up locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
		/* extract the text from the record */
	err = TXNGetData( (**tpvars).fTXNRec, kTXNUseCurrentSelection, kTXNUseCurrentSelection, theText);
		/* all done */
	return err;
}



/* mUPCreateControl creates a new user pane control and then it passes it
	to mUPOpenControl to initialize it as a scrolling text user pane control. */
OSStatus mUPCreateControl(WindowPtr theWindow, Rect *bounds, ControlHandle *theControl) {
	short featurSet;
		/* the following feature set can be specified in CNTL resources by using
		the value 1214.  When creating a user pane control, we pass this value
		in the 'value' parameter. */
	featurSet = kControlSupportsEmbedding | kControlSupportsFocus | kControlWantsIdle
			| kControlWantsActivate | kControlHandlesTracking | kControlHasSpecialBackground
			| kControlGetsFocusOnClick | kControlSupportsLiveFeedback;
		/* create the control */
	*theControl = NewControl(theWindow, bounds, "\p", true, featurSet, 0, featurSet, kControlUserPaneProc, 0);
		/* set up the mUP specific features and data */
	mUPOpenControl(*theControl);
		/* all done.... */
	return noErr;
}


/* mUPDisposeControl calls mUPCloseControl and then it calls DisposeControl. */
OSStatus mUPDisposeControl(ControlHandle theControl) {
		/* deallocate the mUP specific data */
	mUPCloseControl(theControl);
		/* deallocate the user pane control itself */
	DisposeControl(theControl);
	return noErr;
}




/* IsmUPControl returns true if theControl is not NULL
	and theControl refers to a mUP Control.  */
Boolean IsmUPControl(ControlHandle theControl) {
	Size theSize;
	ControlUserPaneFocusUPP localFocusProc;
		/* a NULL control is not a mUP control */
	if (theControl == NULL) return false;
		/* check if the control is using our focus procedure */
	theSize = sizeof(localFocusProc);
	if (GetControlData(theControl, kControlEntireControl, kControlUserPaneFocusProcTag,
		sizeof(localFocusProc), &localFocusProc, &theSize) != noErr) return false;
	if (localFocusProc != gTPFocusProc) return false;
		/* all tests passed, it's a mUP control */
	return true;
}


/* mUPDoEditCommand performs the editing command specified
	in the editCommand parameter.  The mUPControl's text
	and scroll bar are redrawn and updated as necessary. */
void mUPDoEditCommand(ControlHandle theControl, short editCommand) {
	STPTextPaneVars **tpvars;
	STPPaneState ps;
		/* set up our locals */
	tpvars = (STPTextPaneVars **) GetControlReference(theControl);
		/* and our drawing environment as the operation
		may force a redraw in the text area. */
	TPPaneDrawEntry(tpvars, &ps);
		/* perform the editing command */
	switch (editCommand) {
		case kmUPCut:
			ClearCurrentScrap();
			TXNCut((**tpvars).fTXNRec); 
			break;
		case kmUPCopy:
			ClearCurrentScrap();
			TXNCopy((**tpvars).fTXNRec);
			break;
		case kmUPPaste:
			TXNPaste((**tpvars).fTXNRec);
			break;
		case kmUPClear:
			TXNClear((**tpvars).fTXNRec);
			break;
	}
		/* restore the drawing enviroment */
	TPPaneDrawExit(&ps);
}

