/*
	file History.h
	
	Description:
	This file contains routine prototypes and type declarations that can
	be used to access the routines defined in History.c  These routines
	are used to store visitled links.
	
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


#ifndef __HISTORY__
#define __HISTORY__

#include <Types.h>
#include <Menus.h>


/* HistoryDataHandle defines the data type we are using
	for storing historical information about visited links.
	A history is maintained as a list/stack where we can
	move backwards and forwards referencing elements as
	required.  The only difference between a history and
	a stack is that if we add a new element to the history,
	then all elements beyond the current reference are
	deleted before the new element is added. */
typedef struct HistoryData HistoryData;
typedef HistoryData *HistoryDataPtr, **HistoryDataHandle;


/* NewHistory creats a new history and returns
	a handle to it. */
HistoryDataHandle NewHistory(void);


/* DisposeHistory disposes of a history and all of the
	structures allocated for it. */
void DisposeHistory(HistoryDataHandle hd);


/* AddToHistory adds a new element to the history.  Both
	the URL and the printed representation of its url
	are stored.  NOTE:  if we have called GoBack a few times
	before this call, then those previously viewed items
	are removed from the history. This is so if we choose
	GoBack again, then we will arrive at the same link we
	are looking at now.  */
OSErr AddToHistory(HistoryDataHandle hd, char const* url, StringPtr printName);


/* InHistory returns true if the URL is among the urls
	currently stored in the history. */
Boolean InHistory(HistoryDataHandle hd, char const* url);

/* CanGoBack returns true if it makes sense to call the
	GoBack command.  i.e. if there are one or more links
	in the history beyond the current one. */
Boolean CanGoBack(HistoryDataHandle hd);

/* GoBack copies the previous url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used. */
OSErr GoBack(HistoryDataHandle hd, Handle *url);


/* CanGoForward returns true if it makes sense to call the
	GoForward command.  i.e. if there are one or more links
	in the history ahead of the current one.  This can only
	happen after the user has chosen GoBack one or more
	times. */
Boolean CanGoForward(HistoryDataHandle hd);


/* GoForward copies the next url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used. */
OSErr GoForward(HistoryDataHandle hd, Handle *url);


/* CanGoHome returns true if it makes sense to call the
	GoHome command.  i.e. if there are one or more links
	in the history.  This can only happen after AddToHistory
	has been called one or more times. */
Boolean CanGoHome(HistoryDataHandle hd);


/* GoBack copies the first url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used. */
OSErr GoHome(HistoryDataHandle hd, Handle *url);


/* AppendHistoryToMenu rebuilds the Go menu adding items to the
	bottom of the menu according to the items in the
	history.  The names of the items are the same as
	the printNames provided in the AddToHistory command. */
OSErr AppendHistoryToMenu(HistoryDataHandle hd, MenuHandle theMenu);


/* GoToMenuItem copies the itemIndex'th url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used.  This routine
	should only be called after a menu selection has
	been made in a menu built by AppendHistoryToMenu.  */
OSErr GoToMenuItem(HistoryDataHandle hd, Handle *url, short itemIndex);


#endif
