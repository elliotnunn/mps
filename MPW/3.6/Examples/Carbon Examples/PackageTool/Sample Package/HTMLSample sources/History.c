/*
	file History.c
	
	Description:
	These routines are used to store visitled links.
	
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

#include "History.h"
#include "SampleUtils.h"
#include <stddef.h>
#include <Memory.h>
#include <TextUtils.h>
#include <Errors.h>
#include <string.h>



/* individual elements in the history are stored in a linked
	list.  it's a two way list for easy insertions and deletions. */
typedef struct HistoryStruct HistoryRecord;
typedef HistoryRecord *HistoryPtr, **HistoryHandle;
struct HistoryStruct {
	HistoryHandle prev, next;
	char url[1];
	unsigned char printName[1];
};

/* the history data handle contains a list of history
	elements along with a pointer to the current
	element being displayed. */
struct HistoryData {
	HistoryHandle first, last;
	HistoryHandle current;
};



/* NewHistory creats a new history and returns
	a handle to it. Here, we just return an handled
	set to zero. */
HistoryDataHandle NewHistory(void) {
	return (HistoryDataHandle) NewHandleClear(sizeof(HistoryData));
}


/* DisposeHistory disposes of a history and all of the
	structures allocated for it. */
void DisposeHistory(HistoryDataHandle hd) {
	HistoryHandle rover, temp;
	rover = (**hd).first;
		/* delete all of the elements in the history list */
	while (rover != NULL) {
		temp = rover;
		rover = (**rover).next;
		DisposeHandle((Handle) temp);
	}
	DisposeHandle((Handle) hd);
}


/* AddToHistory adds a new element to the history.  Both
	the URL and the printed representation of its url
	are stored.  NOTE:  if we have called GoBack a few times
	before this call, then those previously viewed items
	are removed from the history. This is so if we choose
	GoBack again, then we will arrive at the same link we
	are looking at now.  */
OSErr AddToHistory(HistoryDataHandle hd, char const* url, StringPtr printName) {
	HistoryHandle hrec, rover;
	long strbytes;
		/* create a new history record */
	strbytes = SUstrlen(url);
	hrec = (HistoryHandle) NewHandle(offsetof(HistoryRecord, url) + strbytes + 1 + printName[0] + 1);
	if (hrec == NULL) return memFullErr;
	BlockMoveData(url, (**hrec).url, strbytes + 1);
	BlockMoveData(printName, (**hrec).url + strbytes + 1, printName[0] + 1);
	(**hrec).prev = (**hrec).next = NULL;
		/* clear out records after current.  We do this
		so the next time we choose the go back command,
		we'll arrive at the same one that was the current
		one before this routine was called.  Essentially, the
		user is conducting a depth first search of the html,
		and here we are branching.  */
	while ((**hd).current != (**hd).last && (**hd).current != NULL) {
		rover = (**(**hd).current).next;
		if ((**rover).next != NULL)
			(**(**rover).next).prev = (**rover).prev;
		else (**hd).last = (**rover).prev;
		if ((**rover).prev != NULL)
			(**(**rover).prev).next = (**rover).next;
		else (**hd).first = (**rover).next;
		DisposeHandle((Handle) rover);
	}
		/* add the new record to the end of the list */
	if ((**hd).first == NULL)
		(**hd).first = (**hd).last = hrec;
	else {
		(**hrec).prev = (**hd).last;
		(**(**hd).last).next = hrec;
		(**hd).last = hrec;
	}
	(**hd).current = hrec;
	return noErr;
}


/* InHistory returns true if the URL is among the urls
	currently stored in the history. */
Boolean InHistory(HistoryDataHandle hd, char const* url) {
	HistoryHandle rover;
	Boolean isequal;
	for (rover = (**hd).first; rover != NULL; rover = (**rover).next) {
		HLock((Handle) rover);
		isequal = (SUstrcmp(url, (**rover).url) == 0);
		HUnlock((Handle) rover);
		if (isequal) return true;
	}
	return false;
}


/* CanGoBack returns true if it makes sense to call the
	GoBack command.  i.e. if there are one or more links
	in the history beyond the current one. */
Boolean CanGoBack(HistoryDataHandle hd) {
	if ((**hd).current == NULL)
		return false;
	else return ((**(**hd).current).prev != NULL);
}


/* GoBack copies the previous url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used. */
OSErr GoBack(HistoryDataHandle hd, Handle *url) {
	OSErr err;
	HistoryHandle nextcurrent;
	if ((**hd).current == NULL) return paramErr;
	nextcurrent = (**(**hd).current).prev;
	HLock((Handle) nextcurrent);
	err = PtrToHand((**nextcurrent).url, url, SUstrlen((**nextcurrent).url) + 1);
	HUnlock((Handle) nextcurrent);
	if (err == noErr)
		(**hd).current = nextcurrent;
	return err;
}


/* CanGoForward returns true if it makes sense to call the
	GoForward command.  i.e. if there are one or more links
	in the history ahead of the current one.  This can only
	happen after the user has chosen GoBack one or more
	times. */
Boolean CanGoForward(HistoryDataHandle hd) {
	if ((**hd).current == NULL)
		return false;
	else return ((**(**hd).current).next != NULL);
}


/* GoForward copies the next url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used. */
OSErr GoForward(HistoryDataHandle hd, Handle *url) {
	OSErr err;
	HistoryHandle nextcurrent;
	if ((**hd).current == NULL) return paramErr;
	nextcurrent = (**(**hd).current).next;
	HLock((Handle) nextcurrent);
	err = PtrToHand((**nextcurrent).url, url, SUstrlen((**nextcurrent).url) + 1);
	HUnlock((Handle) nextcurrent);
	if (err == noErr)
		(**hd).current = nextcurrent;
	return err;
}


/* CanGoHome returns true if it makes sense to call the
	GoHome command.  i.e. if there are one or more links
	in the history.  This can only happen after AddToHistory
	has been called one or more times. */
Boolean CanGoHome(HistoryDataHandle hd) {
	return ((**hd).first != (**hd).current) && ((**hd).current != NULL);
}


/* GoBack copies the first url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used. */
OSErr GoHome(HistoryDataHandle hd, Handle *url) {
	OSErr err;
	if ((**hd).first == NULL) return paramErr;
	HLock((Handle) (**hd).first);
	err = PtrToHand((**(**hd).first).url, url, SUstrlen((**(**hd).first).url) + 1);
	HUnlock((Handle) (**hd).first);
	if (err == noErr)
		(**hd).current = (**hd).first;
	return err;
}


/* AppendHistoryToMenu rebuilds the Go menu adding items to the
	bottom of the menu according to the items in the
	history.  The names of the items are the same as
	the printNames provided in the AddToHistory command. */
OSErr AppendHistoryToMenu(HistoryDataHandle hd, MenuHandle theMenu) {
	HistoryHandle rover;
	Str255 title;
	unsigned char *titlep;
	if ((**hd).last == NULL) return noErr;
	AppendMenu(theMenu, "\p(-");
	for (rover = (**hd).last; rover != NULL; rover = (**rover).prev) {
		HUnlock((Handle) rover);
		titlep = (unsigned char *) ((**rover).url + SUstrlen((**rover).url) + 1);
		BlockMoveData(titlep, title, titlep[0] + 1);
		AppendMenu(theMenu, title);
		HUnlock((Handle) rover);
	}
	return noErr;
}


/* GoToMenuItem copies the itemIndex'th url in the history
	into a new handle and returns that handle in
	*url.  It is the caller's responsibility to dispose
	of the handle after it has been used.  This routine
	should only be called after a menu selection has
	been made in a menu built by AppendHistoryToMenu.  */
OSErr GoToMenuItem(HistoryDataHandle hd, Handle *url, short itemIndex) {
	HistoryHandle rover;
	short i;
	OSErr err;
	if ((**hd).last == NULL) return paramErr;
	for (i = 1, rover = (**hd).last; rover != NULL; rover = (**rover).prev, i++) {
		if (i == itemIndex) {
			HLock((Handle) rover);
			err = PtrToHand((**rover).url, url, SUstrlen((**rover).url) + 1);
			HUnlock((Handle) rover);
			if (err == noErr)
				(**hd).current = rover;
			return err;
		}
	}
	return noErr;
}