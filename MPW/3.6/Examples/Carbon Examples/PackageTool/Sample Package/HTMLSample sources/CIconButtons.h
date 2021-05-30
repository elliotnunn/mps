/*
	file CIconButtons.h
	
	Description:
	This file contains type declarations, constants, and routine prototypes
	for accessing the routines implemented in CIconButtons.c.  These routines
	are used to implement the color icon buttons displayed in the top of
	HTMLSample's windows.
	
	HTMLSample is an application illustrating how to use the new
	HTMLRenderingLib services found in Mac OS 9. HTMLRenderingLib
	is Apple's light-weight HTML rendering engine capable of
	displaying HTML files.

	by John Montbriand, 1999.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/16/99 created by John Montbriand
*/

#ifndef __CICONBUTTONS__
#define __CICONBUTTONS__

#include <Types.h>

	/* these are the resource types we use.  ResEdit
	templates for these resource types are defined in
	the application's resource fork. */
enum {
	kIconButtonIDListType = 'RBCL',
	kIconButtonType = 'CICB'
};

	/* buttons have three states, and three icons
	for each of those states.  disabled is how it looks
	when it cannot be clicked, up and down define
	how it looks in each of those states. */
enum {
	kCBdisabled = 0,
	kCBup = 1,
	kCBdown = 2
};

#pragma options align=mac68k
typedef struct {
	Rect bounds;
	short drawnstate;
	short cicnIDs[3]; /* resource id's for each state's cicn
				resource.  indexes in this array map to the
				states defined above. */
	char stringdata[1]; /* variable size c string */
} CIconButton, **CIconButtonHandle;
#pragma options align=reset


/* NewCIconButton retrieves a new color icon button
	resource from the resource file.  the id number
	corresponds to the resource id of the CICB resource. */
CIconButtonHandle NewCIconButton(short id);


/* DisposeCIconButton disposes of any structures allocated
	for the color icon button allocated by NewCIconButton. */
void DisposeCIconButton(CIconButtonHandle cicb);


/* SetCIconButtonPosition sets the color icon button's 
	screen postion. h and v are coordinates in the
	current grafport. */
void SetCIconButtonPosition(CIconButtonHandle cicb, short h, short v);


/* GetCIconButtonStringData returns a new handled containing
	the string data copied from the color icon resource.  The
	handle will contain a C-style string terminated with a zero
	byte.  It is the caller's responsibility to dispose of this
	handle after it has been used. */
OSErr GetCIconButtonStringData(CIconButtonHandle cicb, Handle *strdata);


/* DrawCIconButton draws the icon button using the
	as it should appear given the state specified.  state
	should be either kCBdisabled, kCBup, or kCBdown.
	The last state a button is drawn in affects the
	result of TrackCIconButton. */
void DrawCIconButton(CIconButtonHandle cicb, short state);


/* TrackCIconButton should be called whenever a click is made
	inside of a color icon button.  if the last time the button
	was drawn its state was not kCBup or the click is outside
	of the button, then this routine returns false. */
Boolean TrackCIconButton(CIconButtonHandle cicb, Point where);

/* RBCLRsrcHandle defines the resource type used to store
	a list of color icon button resource IDs.  In this example,
	the user configurable button ids are stored in a RBCLRsrcHandle
	resource. */
#pragma options align=mac68k
typedef struct {
	short n;
	short ids[1];
} RBCLResource, **RBCLRsrcHandle;
#pragma options align=reset

#endif