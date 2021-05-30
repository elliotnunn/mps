/*
	file RenderingWindow.h
	
	Description:
	This file contains exported routine prototypes that can be used to call
	the routines defined in RenderingWindow.c.  These routines used to
	manage the windows displayed by the HTMLSample application.
	
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

#ifndef __RENDERINGWINDOW__
#define __RENDERINGWINDOW__

#include <Types.h>
#include <Windows.h>



/* InitRenderingWindows is called to initialize the environment used by 
	routines defined in this file.  It should be called before any of the 
	other routines defined in this file are called. */
OSStatus InitRenderingWindows(void);

/* CloseRenderingWindows closes any open rendering windows and
	deallocates any structures allocated when InitRenderingWindows
	was called. */
OSStatus CloseRenderingWindows(void);



/* RWOpen opens a new, empty rendering window.  If successful,
	then *rWindow will contain a pointer to a newly created window. */
OSStatus RWOpen(WindowPtr *rWindow);

/* RWCloseWindow closes the rendering window pointed to by
	rWin.  */
void RWCloseWindow(WindowPtr rWin);

/* IsARenderingWindow returns true if rWin points to a rendering
	window created by RWOpen. You should not call any of the routines
	below for windows that are not rendering windows.  This routine
	provides a convenient way to tell if a windowptr returned by one
	of the toolbox routines is a rendering window. */
Boolean IsARenderingWindow(WindowPtr rWin);



/* RWGotoURL displays HTML file referred to by the url in the
	rendering window.  if addToHistory is true, then the window
	will be added to the window's history list. */
OSStatus RWGotoURL(WindowPtr rWin, char* url, Boolean addToHistory);

/* RWGotoAppRelLink displays HTML file referred to by the application
	relative link in the rendering window.  if addToHistory is true, then
	the window will be added to the window's history list. */
OSStatus RWGotoAppRelLink(WindowPtr rWin, char* linkstr, Boolean addToHistory);



/* RWResetGotoMenu should be called before calling MenuKey or MenuSelect.  It
	enables the back, forward, and home menu commands depending on what
	commands are available and it rebuilds the history list at the bottom
	of the go to menu. */
void RWResetGotoMenu(WindowPtr rWin);

/* RWHandleGotoMenu should be called when an item is chosen from the
	go to menu.  item is the number of the item that was chosen. */
void RWHandleGotoMenu(WindowPtr rWin, short item);



/* RWUpdate should be called in response to an update event.
	it calls BeginUpdate and EndUpdate redrawing the window's
	contents as necessary. */
void RWUpdate(WindowPtr rWin);

/* RWActivate should be called in response to activate events.*/
void RWActivate(WindowPtr rWin, Boolean activate);

/* RWRecalculateSize should be called whenever the size of a rendering
	window changes.  This routine resizes and redraws the windows
	contents appropriately. */
void RWRecalculateSize(WindowPtr rWin);

/* RWHandleMouseDown should be called in response to mouse down
	events occuring inside of a rendering window.  This routine responds
	to mouse clicks in the controls at the top of the window. */
void RWHandleMouseDown(WindowPtr rWin, Point where);

/* RWKeyDown should be called for keydown events when a rendering
	window is the frontmost window.  This routine maps the left, up,
	and right arrow keys to the back, home, and forward commands. */
void RWKeyDown(WindowPtr rWin, char theKey);

#endif

