#ifndef __DLPROTOS__
#define __DLPROTOS__

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __APPLETALK__
#include <AppleTalk.h>
#endif

#ifndef __LISTS__
#include <Lists.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __PPCTOOLBOX__
#include <PPCToolbox.h>
#endif

#ifndef __STANDARDFILE__
#include <StandardFile.h>
#endif


/************** AEConnect.c **************/

void			InitConnectAppleEvents(void);
	/* This function initializes the connect AppleEvents stuff.  It needs to be
	** called so that DTS.framework applications can connect with other applications
	** specific to a targeted window. */

OSErr			SendConnect(FileRecHndl frHndl, char *theLocNBPType);
	/* frHndl:			Establish a connection between this document and a to-be-created
	**					document on some other machine.
	** theLocNBPType:	You may have registered an NBPAlias for the application.  If so,
	**					then you may pass in an alias (just a pascal-string) to this
	**					function.  If you aren't using aliases, then pass in nil.
	** 
	** This is the function that is called to establish a connection to another
	** DTS.framework-based application.  The "other" DTS.framework application is probably
	** the same application on another machine.  This code does a bit more than simply
	** connecting to another application.  It targets a specific window within that application.
	** It doesn’t just target zone-machine-application, which is the granularity that AppleEvents
	** gives you.  It also passes back and forth some information that is kind of a pain to get,
	** but is nice to have.  One such piece of information is the user name.  This needs to be
	** sent.  It can’t be determined from the message from an AppleEvent.  The sender sends
	** the user name, and the receiver returns the remote user name.  The user name is
	** placed in the document record for the window to be used if you wish. */

WindowPtr		GetAEWindow(long windID_0, long windID_1);
	/* This function is called to determine which window, if any, is the designated
	** target window.  The window ID’s are determined when the connection is established. */

void			GetFullPathAndAppName(StringPtr path, StringPtr app);
	/* This function is called to generate the full path of the running app, plus
	** return the application name. */

void			AllowAutoReconnect(FileRecHndl frHndl);
	/* This function should be called prior to calling SendConnect if you want to pass
	** the application being connected to the information necessary to remotely
	** restart the application.  The mutual information will be returned. */

pascal Boolean	AEPortFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo);
	/* Filters out apps other than itself. */

typedef pascal Boolean	(*GRPTProcPtr)(LocationNamePtr locationName, PortInfoPtr thePortInfo);
OSErr			GetRemoteProcessTarget(FileRecHndl frHndl, AEDesc *retDesc, GRPTProcPtr proc);
	/* Get the target of a remote process, given location information in the frHndl. */

OSErr			LaunchRemoteApp(FileRecHndl frHndl);
	/* Given proper information in the frHndl, auto-launch it. */



/************** AERequired.c **************/

OSErr			InitRequiredAppleEvents(void);
	/* Intializes AppleEvent dispatcher table for the required events.  It also
	** determines if the machine is PPCBrowser and AppleEvent capable.  If so,
	** the booleans gHasAppleEvents and gHasPPCToolbox are set true.  This function
	** must be the first AppleEvents initialization DTS.framework function called, as the
	** other functions depend on the booleans being set correctly. */

pascal OSErr	DoAEOpenApplication(AppleEvent *message, AppleEvent *reply, long refcon);



/************** AEUtils.c **************/

#ifndef         __AEUTILS__
#include		"AEUtils.h"
#endif



/************** AEWFMT.c **************/

void	InitWFMTAppleEvents(void);
	/* Install our custom AppleEvents for editing running applications.  This is done in
	** addition to installing the required AppleEvents.  InitAppleEvents, which installs
	** the required AppleEvents, must be called first, since it sets up some global values. */

OSErr	SendWFMTMessage(FileRecHndl frHndl, TreeObjHndl wobj, short messageType,
						ResType rtype, short resID, Handle *resHndl, StringPtr suffix);
	/* Send a message to the running application for various application-editing functions.
	** This is used by the AppsToGo application editor for editing running applications. */



/************** ATUtils.c **************/

#ifndef         __ATUTILS__
#include		"ATUtils.h"
#endif



/************** CIconControl.c **************/

#ifndef         __CICONCONTROL__
#include		"CIconControl.h"
#endif



/************** CtlHandler.c **************/

#ifndef         __CTLHANDLER__
#include		"CtlHandler.h"
#endif



/************** DoEvent.c **************/

void			DoEvent(EventRecord *event);


void			DoActivate(WindowPtr window);
	/* •• DTS.Lib..framework calls this. •• */
	/* This function is part of the application.  It is called at the appropriate times. */

void			DoCursor(void);
	/* •• DTS.Lib..framework calls this. •• */
	/* This function is part of the application.  It is called at the appropriate times. */



/************** File.c **************/

OSErr			InitDocument(FileRecHndl frHndl);
	/* •• DTS.Lib..framework calls this. •• */
	/* The framework calls this function once a file reference handle is created and initialized
	** to default values.  This is the application's chance to change the defaults. */

long			InitDocumentSize(OSType sftype);
	/* •• DTS.Lib..framework calls this. •• */
	/* The framework calls this function to find out how big the file reference handle should
	** be created for a particular document type. */



/************** File2.c **************/

OSErr			DefaultInitDocument(FileRecHndl frHndl, short version,
									short numUndos, short numSaveUndos);
	/* frHndl:			Recently created (most likely by the framework) file reference handle.
	** version:			Version number to store into the document.
	** numUndos:		The number of undos to be managed by the hierarchical document architecture.
	** numSaveUndos:	The number of undos to be saved with the document (commonly none, so 0).
	** 
	** This function does the standard document initialization.  The standard document uses
	** the hierarchical document package TreeObj.  Read the TreeObj documentation for
	** more information. */

OSErr			DisposeDocument(FileRecHndl frHndl);
	/* This function is automatically called by such functions as DisposeOneWindow.  It
	** calls the designated free document procedure, which by default is FreeDocument.
	** The free document procedure is responsible for disposing of any and all handles
	** that were created by the init document procedure. */

OSErr			NewDocument(FileRecHndl *returnHndl, OSType sftype, Boolean incTitleNum);
	/* This function needs to be called by the application at appropriate times.  It
	** calls the designated init document procedure, which by default is InitDocument.
	** The init document procedure is responsible for creating any and all initial
	** handles for the document.  New documents will be created with a default title.  This
	** title is created by appending a number to the corresponding STR# individual string.
	** The STR# resource ID #259 holds the default text for the window titles.  Which string
	** number is determined by the OSType array gTypeList.  gTypeList contains all of the
	** file types that can be opened by the application.  The list is walked, and the location
	** in the gTypeList array that holds the correct file type is used as an index into
	** the STR# resource.  If the file type isn’t found in the list, then the first string
	** in the STR# resource is used.
	** The next greatest integer is appended to the end of the individual string selected
	** for the document.  If incTitleNum is true, then the global integer is first incremented
	** prior to appending the number.
	** If you want to create a document with the title found in the 'WIND' resource, first
	** call NewDocument().  After you have the frHndl for the document, set the file name
	** in the (*frHndl)->fileState.fss.name field to an empty string.  When the window is
	** opened for this document, if this name is an empty string, it titles the window
	** according to what is found in the 'WIND' resource for that window.  If this field is
	** not an empty string, then the 'WIND' title is overridden, and the file name is used. */

OSErr			OpenDocument(FileRecHndl *result, FSSpecPtr fileToOpen, char permission);
	/* This function does the human-interface thing for opening a document.  It
	** also calls NewDocument() to initialize a document.  To actually read in
	** the data, OpenDocument() calls the designated read document procedure, which by
	** default is ReadDocument().  The read document procedure is responsible for reading
	** the document data into ram in association with the FileRecHndl created by
	** NewDocument(). */

OSErr			SaveDocument(FileRecHndl frHndl, WindowPtr window, short saveMode);
	/* This function does the human-interface thing for saving a document.  To
	** actually write out the data, SaveDocument calls the designated write document
	** procedure, which by default is WriteDocument.  The write document procedure is
	** responsible for writing the document data to the designated file. */

void			ConvertOldToNewSFReply(SFReply *oldReply, StandardFileReply *newReply);
	/* When running on a pre-7.0 system, SFGetFile or SFPutFile is called.  Then
	** ConvertOldToNewSFReply is called to convert the reply record to the new
	** format.  This allows the rest of the application to use only a single
	** record format. */

Boolean			DisplayGetFile(StandardFileReply *reply, short typeListLen, SFTypeList typeList);
	/* Simple routine to display a list of files with our file type. */

Boolean			DisplayPutFile(StandardFileReply *reply);
	/* Displays the StandardFile PutFile dialog box. Fills out the passed reply
	** record, and returns the sfGood field as a result. */

OSErr			UseDocResFile(FileRecHndl frHndl, short *oldRes, char perm);
	/* Use the resource fork for the designated document file.  This function
	** also returns the old CurResFile, so you can set it back when you are done.
	** Simply call this function, whether or not you have a resource fork.  If
	** there isn’t a resource fork, then one will be created.  If there is one,
	** but it isn’t open yet, it will be opened.  If it is already opened, it
	** sets it as the current resource fork.  What more do you want? */

OSErr			CloseDocResFile(FileRecHndl frHndl);
	/* If there is a resource fork open for this document, this closes it. */

long			GetModNum(void);
	/* Get the modification number for the document.  TreeObj automatically increments this. */

Boolean			GetDocDirty(FileRecHndl frHndl);
	/* Get the dirty state of the document. */

Boolean			GetWindowDirty(WindowPtr window);
	/* Given a window, return the dirty state of the associated document. */

void			SetDocDirty(FileRecHndl frHndl);
	/* Set the document dirty. */

void			SetWindowDirty(WindowPtr window);
	/* Given a window, set the associated document as dirty. */

OSErr			SetDefault(short newVRefNum, long newDirID, short *oldVRefNum, long *oldDirID);
	/*  The SetDefault function sets the default volume and directory to the volume specified
	**  by newVRefNum and the directory specified by newDirID. The current default volume 
	**  and directory are returned in oldVRefNum and oldDir and should be used to restore 
	**  things to their previous condition *as soon as possible* with the RestoreDefault 
	**  function. These two functions are designed to be used as a wrapper around
	**  Standard C I/O routines where the location of the file is implied to be the
	**  default volume and directory. In other words, this is how you should use these
	**  functions:
	**
	**		err = SetDefault(newVRefNum, newDirID, &oldVRefNum, &oldDirID);
	**		if (!err)
	**			{
	**				-- call the Stdio functions like remove, rename, tmpfile, fopen,   --
	**				-- freopen, etc. or non-ANSI extentions like fdopen, fsetfileinfo, --
	**				-- create, open, unlink, etc. here!								   --
	**
	**				err = RestoreDefault(oldVRefNum, oldDirID);
	**			}
	**
	**  By using these functions as a wrapper, you won't need to open a working directory 
	**  (because they use HSetVol) and you won't have to worry about the effects of using
	**  HSetVol (documented in Technical Note #140: Why PBHSetVol is Dangerous 
	**  and in the Inside Macintosh: Files book in the description of the HSetVol and 
	**  PBHSetVol functions) because the default volume/directory is restored before 
	**  giving up control to code that might be affected by HSetVol.
	** Use this and the below call instead of the old-style FSpSetWD and FSpResetWD. */

OSErr			RestoreDefault(short oldVRefNum, long oldDirID);
	/* Resets the default directory to what it was prior to calling SetDefault. */

OSErr			GetFileLocation(short refNum, short *vRefNum, long *dirID, StringPtr fileName);
	/* Get the vRefNum and dirID of a file, which is its location. */

OSErr			CurResOnly(Handle *hndl);
	/* After getting a resource, you can't actually be sure that it came from the current
	** resource file.  Even if you make a call such as Get1Resource, starting with system 7.1,
	** you can't really be sure that it came from the current resource file.  (The resource
	** files may be overridden, or they may be flagged to be extended, as is the case with
	** font files.)  This checks to see that the resource actually came from the current
	** resource file.  If it didn't, then the handle returned is nil, and the error returned
	** is resNotFound.  (You probably don't need this function unless you are doing some kind
	** of resource-editing function.) */



/************** Init.c **************/

void			Initialize(short moreMasters, long minHeap, long minSpace,
						   ProcPtr init1, ProcPtr init2);
	/* Given minHeap and minSpace values, get stuff going.  Also, we are passed
	** in two procedure pointers.  If these are not nil, they are called at
	** intermediate points during the initialization process.  The first proc
	** is called after the Utilities.c standard initialization is complete.  The
	** second proc is called very near the end of the initialization, but just
	** prior to the menus being initialized. */

void			StartDocuments(void);
	/* This function handles the documents selected in the finder, either for
	** loading or for printing.  This is only if we don't have AppleEvents.
	** If we have AppleEvents, then this will all be done automatically via
	** those wonderful AppleEvent thingies. */



/************** GWLayers.c **************/

#ifndef         __GWLAYERS__
#include		"GWLayers.h"
#endif



/************** ListControl.c **************/

#ifndef         __LISTCONTROL__
#include		"ListControl.h"
#endif



/************** Menu.c **************/

void			DoAdjustMenus(void);
	/* •• DTS.Lib..framework calls this. •• */
	/* The framework calls this at the appropriate times to adjust the menus.  The application
	** should then set the enable states for the various menu items.  (The menu items are
	** disabled prior to this being called.  This means that the application only has to
	** worry about enabling menus.) */

Boolean			DoMenuCommand(short menuID, short menuItem);
	/* •• DTS.Lib..framework calls this. •• */
	/* The framework calls this when a menu command is to be executed. */



/************** PICTControl.c **************/

#ifndef         __PICTCONTROL__
#include		"PICTControl.h"
#endif



/************** PPC.c **************/

#ifndef         __PPC__
#include		"PPC.h"
#endif



/************** Print.c **************/

OSErr			PrintDocument(FileRecHndl frHndl, Boolean jobDlg, Boolean firstJob);
	/* This print-loop function is designed to be called under various situations.
	** The big issue that it handles is finder printing.  If multiple documents
	** are to be printed from the finder, the user should only see one job dialog
	** for all the files.  (If a job dialog is shown for each file, how does the
	** user know for which file the dialog is for?)  So, for situations where
	** there is more than one file to be printed, call this code the first time
	** with the firstJob boolean true.  Normally, the jobDlg boolean will also
	** be true, except that under 7.0, you may be printing in the background.
	** If this is the case, you don't want a job dialog for even the first file,
	** and you should pass in false for the jobDlg boolean in this case.  For
	** files 2-N, you should pass false for both booleans.  For regular application
	** printing, you should pass true for both booleans, since the file is the
	** first (only) file, and you are not in the background.
	**
	** After calling this function to print a document, you need to call it
	** again with a nil document handle.  The print record for the first (or only)
	** document printed is preserved in a static variable.  This is so that the
	** job dialog information can be passed on to documents 2-N in the print job.
	** Calling this function with the document handle nil tells this function
	** that you are done printing documents, and that the print record for the
	** first job can be disposed of. */

void			DonePrinting(void);
	/* DonePrinting makes sure that PrintDocument gets rid of the prMergeHndl
	** print record that is used for multiple document printing.  Call this after
	** or the last document is printed, or you get a memory leak. */

OSErr			PresentStyleDialog(FileRecHndl frHndl);
	/* Call this from the application to present a style dialog.  The changes are
	** automatically saved in the document. */



/************** System6Help.c **************/

OSErr			HelpInitDocument(FileRecHndl frHndl);



/************** TextEditControl.c **************/

#ifndef         __TEXTEDITCONTROL__
#include		"TextEditControl.h"
#endif



/************** TreeObj.c **************/

#ifndef         __TREEOBJ__
#include		"TreeObj.h"
#endif



/************** ViewHierarchy.c **************/

OSErr			VHInitDocument(FileRecHndl frHndl);
long			VHFileTypeSize(void);
void			VHRootInfo(TreeObjHndl root, char *cptr);
void			VHFileRecInfo(TreeObjHndl root, char *cptr);
	/* These functions are in the framework to support the View Hierarchy debugging window.
	** The sample application AppWannabe has these calls in it.  They can be conditionally
	** removed by setting the compile variable VH_VERSION to 0. */



/************** Window2.c **************/

OSErr			DoNewWindow(FileRecHndl frHndl, WindowPtr *retWindow, WindowPtr relatedWindow,
							WindowPtr behind);
	/* frHndl:			Create a window, based on the description for the window
	**					in the file reference.
	** retWindow:		Return the window that was created.  (If you don't care, pass in nil.)
	** relatedWindow:	Create the window, related to this one.  (It will try to put the new
	**					window on the same monitor as the related window.)
	** behind:			Create the window behind this window (-1 for frontmost, 0 for backmost).
	**
	** This function is called by the application at appropriate times to give a document
	** a window.  To create a document window, first a document is created by the application
	** via NewDocument or OpenDocument.  If this succeeds then the application needs to create
	** a window for the document.  To do this, the application calls DoNewWindow.  DoNewWindow
	** calls the content initialization procedure, which by default is InitContent.
	** If you want a different content initialization procedure, replace the
	** default procedure pointer initContentProc with your own.  Normally however,
	** you will just place your own content initialization procedure in the
	** function InitContent.  It is possible though that your
	** application has more than one document type and window type.  If this
	** is the case, then you may very well want an alternate content
	** initialization procedure.  If you do, you will want to replace the
	** default procedure pointer after the NewDocument or OpenDocument
	** call and before the call to DoNewWindow.  (You may place the code for
	** replacing the content initialization procedure and imaging procedure
	** in the function InitDocument.  The defaults are already established
	** at that point.  You would just replace them with the alternates. */

void			NewWindowTitle(WindowPtr window, StringPtr altTitle);
	/* Call this function if you want to change the title of the window.
	** If you pass in nil, the window title will be gotten from the FSSpec of the document.
	** If you pass in an alternate title in altTitle, that will be used instead
	** of the document name. */

Boolean			DisposeAllWindows(void);
Boolean			DisposeOneWindow(WindowPtr window, short saveMode);
	/* These functions do exactly as you would expect.  The saveMode indicates
	** whether the window is being closed due to a close request, or due to the
	** application being quit.  If true is returned, then disposing of the window
	** was successful.  If false is returned, the user may have canceled the close
	** due to the document needing to be saved, a dialog as such popping up, and
	** the user clicking cancel. */

WindowPtr		SetFilePort(FileRecHndl frHndl);
	/* This function sets the current port for the designated file.  It also returns
	** the old port so that the port can be restored, if so desired. */

void			DoResizeWindow(WindowPtr window, short oldh, short oldv);
	/* This function is called when a window is resized.  This function needs to
	** know the old size of the window.  The new size is determined by the
	** dimensions of the window that was resized.  It moves and resizes the
	** document scrollbars and growIcon (if any) to reflect the new size of
	** the window.  It then calls the procedure stored in the procPtr field
	** resizeContentProc, in case there is additional sizing necessary for the window.
	** The default resizeContentProc is ResizeContent.  If you wish an alternate
	** resizeContentProc, then you can replace the default in the function
	** InitDocument, as the default is already established at this point. */

void			GetWindowChange(WindowPtr window, short oldh, short oldv, short *dx, short *dy);
	/* This function returns the difference between the old window size and the new window
	** size.  Pass in the old window size, and this function looks up the current size,
	** gets the difference, and returns it. */

void			DoUpdateSeparate(WindowPtr window, RgnHandle *contRgn, RgnHandle *frameRgn);
	/* This function separates the update region into two portions.  One portion is
	** the frame area, which consists of document scrollbars and growIcon (if any), plus
	** an optional application-defined frame area.  The other portion is the rest of the
	** window content that needs updating.  This separation is so that the document
	** scrollbars can be updated first, and then this area can be clipped out of the rest
	** of the updating so that the window content doesn’t draw over the document scrollbars
	** and growIcon.  The clipping is managed with just the visRgn.  This frees up the clipRgn
	** for application specific clipping. */

void			BeginContent(WindowPtr window);
	/* This function clips out the document scrollbars and growIcon from the updatable area.
	** It also sets the origin of the port to the current document scrollbar values.
	** BeginContent must be balanced by a call to EndContent.  BeginContent calls BeginUpdate,
	** and BeginUpdate calls can’t be nested.  Due to this, BeginContent has a usage counter,
	** which prevents nested calls to BeginUpdate.  BeginContent clips out the document
	** scrollbar and growIcon area without involving the clipRgn so that the application is
	** free to use the clipRgn as it sees fit.  The only caveat is that you can not modify the
	** updateRgn between the BeginContent and EndContent calls, as anything contributed to the
	** updateRgn between these calls will be lost.  If you need to do this, accumulate the areas
	** in a separate region, call EndContent, and then call InvalRgn. */

void			EndContent(WindowPtr window);
	/* Calls to BeginContent must be balanced.  They also don’t nest.  EndContent undoes the
	** clipping of the frame area that BeginContent invoked. */

void			BeginFrame(WindowPtr window);
	/* This function does the same thing as BeginContent, except that it clips out everything
	** except the frame area.  The frame area consists of the sidebars and any additional
	** application-defined frame area.  The application-defined frame area is defined in the
	** application function CalcFrameArea().  Also, the origin is set to -16384,0, which is
	** the coordinate space for sidebar controls created with the AppsToGo application editor. */

void			EndFrame(WindowPtr window);
	/* Calls to BeginFrame must be balanced.  They also don’t nest.  EndFrame undoes the
	** clipping of the frame area that BeginFrame invoked. */

void			AdjustScrollBars(WindowPtr window);
	/* You call this function whenever you need the scrollbars to reflect the window
	** state and position.  If you change the sidebar sizes or indent sizes by hand,
	** you will need to call this.  Generally an application will not have to call this
	** directly, as there are functions for scrolling, setting sidebar sizes, indent
	** sizes, etc. */

void			GetContentOrigin(WindowPtr window, Point *contOrg);
	/* This function returns the origin of the content of the window.  The value is
	** gotten from the current value of the document scrollbars.  If a scrollbar
	** is missing, the control value for that scrollbar is assumed to be 0.  Note that
	** if you have sidebars in your document, the origin value has the sidebar value
	** subtracted.  For example:  You have a top sidebar of 32 pixels, and the vertical
	** scrollbar has a control value of 0.  This will return you a vertical origin of -32. */

void			SetContentOrigin(WindowPtr window, long newh, long newv);
	/* This function allows you to change the value of the document scrollbars,
	** and by doing this, the document is scrolled to reflect the change, and
	** an update event is generated for the document scroll.  Note that if you are
	** using sidebars, you will have to subtract the value of the sidebar to get
	** the expected results (see GetContentOrigin).  Also note that this function accepts
	** long values.  You may have a proc for handling longs for the document scrollbars.
	** The proc is stored in the refCon of the document scrollbars.  If the refCon
	** value of the document scrollbars is 0, then it is assumed that values from 0
	** to 32767 are adequate for document scrolling. */

void			GetContentRect(WindowPtr window, Rect *contRct);
	/* This function returns a rectangle that represents the content area of the
	** window less the scrollbar and sidebar areas. */

void			SetDocSize(FileRecHndl frHndl, long hSize, long vSize);
	/* This function sets the document size to the new designated size.  It also
	** makes appropriate adjustments to the scrollbars to reflect the new size. */

void			SetSidebarSize(FileRecHndl frHndl, short newLeft, short newTop);
	/* This function is used to set the size of the sidebars.  This is particularly
	** useful for being able to show and hide a tool palette, or if you are using
	** OCE and want to show a mailer at the top of your window.  The sidebar value
	** should initially be set in File.c, along with other document initialization.
	** If you wish to change only one of the two sidebar sizes, send in a value of
	** kwNoChange for the one that is not to change. */

void			SetScrollIndentSize(FileRecHndl frHndl, short newh, short newv);
	/* This function is used to set the size of the scrollbar indention.  The scrollbar
	** indentnion allows you to put status information or document display related
	** tool icons in line with the scrollbar.  They are considered part of the frame,
	** as document scrollbars, the grow icon, and sidebars are.  The scrollbar indent value
	** should initially be set in File.c, in the same fashion as sidebar values are set.
	** If you wish to change only one of the two scrollbar indent, send in a value of
	** kwNoChange for the one that is not to change. */

FileRecHndl		GetNextDocument(WindowPtr window, OSType sftype);
	/* This function returns the file reference for the next application window
	** of the designated kind.  If the window paramater is passed in as nil, it
	** finds the top-most window.  If the window parameter is passed in as non-nil,
	** it returns the next window.  If there is no next window found, it returns
	** nil.  The sftype parameter restricts the finding of a window to a particular
	** type.  If 0 is passed in for sftype, then any application window will match. */

WindowPtr		GetNextWindow(WindowPtr window, OSType sftype);
	/* This function behaves the same as GetNextDocument, but returns a window pointer
	** instead of a file reference. */ 

WindowPtr		GetPreviousWindow(WindowPtr window);
	/* Returns the window in front of the window passed in.  If there is no window
	** in front, it returns -1, not nil.  -1 is typically used to indicate the front
	** of the window list, whereas nil is used to indicate the back.  This is done to
	** stay consistent with the expectations of the toolbox. */

void			DoZoomWindow(WindowPtr window, EventRecord *event, short zoomDir);
	/* This function handles zooming of the document window.  It zooms it to the
	** current monitor, up to the size of the document data. */

RgnHandle		DoCalcFrameRgn(WindowPtr window);
	/* This function calculates the region that encompasses the frame area of the document.
	** The frame area consists of the document scrollbars, growIcon, sidebars, and an
	** optional application-defined frame area.  The region is generated in global coordinates.
	** Since the frame region may encompass more than the DTS.framework-supported scrollbars and
	** growIcon, a procedure is first called to see if there is anything additional
	** in the frame region.  The field calcFrameRgnProc holds the procedure pointer
	** that contributes any extra to the frame region.  This function is passed an
	** empty region.  If there is no additional contribution to the frame region,
	** then the region should be left empty.  Once this procedure is returned from,
	** the remaining frame portion is added to this region.  The remaining portion
	** would consist of DTS.framework document scrollbars and a growIcon, if there
	** are any for this window.  The field calcFrameRgnProc is initialized to the
	** default value CalcFrameRgn.  If you wish an alternate drawFrameProc, then you
	** can replace the default in the function InitDocument, as the default is
	** already established at this point. */

RgnHandle		DoCalcScrollRgn(WindowPtr window);
	/* This function calculates the region that encompasses the document scrollbars
	** and growIcon (if any).  The region is generated in global coordinates. */

void			DoContentClick(WindowPtr window, EventRecord *event, Boolean firstClick);
	/* This function is called whenever the content portion of a window is clicked in.
	** It simply calls the procedure pointer stored in the field contentClickProc.
	** The field contentClickProc is initialized to ContentClick.  If you wish
	** an alternate contentClickProc, then you can replace the default in the function
	** InitDocument, as the default is already established at this point.  The
	** boolean firstClick is true if you chose this window to handle first clicks, and
	** if the click is actually a first click in the window.  A first click means that
	** the window content was clicked on, but the window was not the front window.  The
	** window has already been brought to the front, but you may wish the click to also
	** be handled as a content click. */

void			DoDragWindow(WindowPtr window, EventRecord *event, Rect bounds);
	/* This function is used to drag a window.  We can’t use the toolbox function DragWindow,
	** as the DTS.framework supports palettes.  Since we are supporting palettes, we have to
	** be able to drag a window that isn’t the front, and bring it to the front of windows
	** of its kind.  There is no way to coerce DragWindow to do this. */

void			DoDrawFrame(WindowPtr window, Boolean activate);
	/* This function may be called when an update event occurs for the window.
	** If the update region intersects the frame region (calculated by DoCalcFrameRgn),
	** then a frame update occurs and this function is called.  It redraws the
	** document scrollbars and growIcon (if any) and then calls the procedure stored
	** in the field drawFrameProc, which has a default value of DrawFrame.  If you wish
	** an alternate drawFrameProc, then you can replace the default in the function
	** InitDocument, as the default is already established at this point. */

OSErr			DoFreeDocument(FileRecHndl frHndl);
	/* This is called to generically call the document’s freeing procedure.  This document
	** is being disposed of, and any custom memory usage needs to be deallocated.  The
	** frHndl itself will be disposed of, but any handle references that it contains
	** need to be freed within the document’s freeing procedure.  The default freeing
	** procedure is called FreeDocument(). */

OSErr			DoFreeWindow(FileRecHndl frHndl, WindowPtr window);
	/* This is called to generically call the document’s window freeing procedure.
	** The window is going to be disposed of, and there may be related tasks to disposing
	** of the window.  A document may have related windows or views.  This is where you
	** would dispose of the related windows.  The default window freeing procedure is called
	** FreeWindow(). */

OSErr			DoImageDocument(FileRecHndl frHndl);
	/* This function is called whenever the content portion of a window needs to be
	** updated or printed.  It simply calls the procedure pointer stored in the field
	** imageProc.  The field imageProc is initialized to ImageDocument.  If you wish
	** an alternate imageProc, then you can replace the default in the function
	** InitDocument, as the default is already established at this point.
	** Note that when the document's imageProc is called, only the content can be
	** drawn to.  BeginContent() is called prior to calling the imageProc, and
	** EndContent() is called upon return. */

OSErr			DoInitContent(FileRecHndl frHndl, WindowPtr window);
	/* The window has been created, and is about to be displayed.  At this time, this
	** function is called.  It generically calls the window content initialization procedure
	** indicated within the frHndl.  The default window content initialization procedure is
	**  called InitContent(). */

Boolean			DoKeyDown(EventRecord *event);
	/* DoKeyDown is first called by the application.  If the key is a menu key, the
	** application function DoMenuCommand() is called.  If the key isn’t a menu
	** key, DoKeyDown starts walking through the window list, giving each window an
	** opportunity to handle the key.  Windows can handle it, eat it, or pass the key
	** through to the next window.
	** It gives each window a chance to handle the key by calling the key handling procedure
	** stored in the frHndl.  The default procedure is called KeyDown().  Here are the
	** rules for the window key handling procedure:
	**
	** 1) If it handles the key, it returns true.  This completes the key handling.
	** 2) If it doesn’t handle the key, it returns false.  However, there are two
	**    situations for not handling the key:
	**      a) The window wants windows behind it to try handling the key.
	**      b) The window wants nobody else to look at the key.
	**    This is what the boolean passThrough is for.  If the procedure wishes the next
	**    window to have a look at the key, it should set the boolean passThrough to true.
	**    passThrough is already initialized to false prior to calling the procedure, which
	**    is the common case, so the window key handling procedure only has to worry about
	**    setting it true.
	**
	** If the window never processes keys and always passes them through to the next window,
	** the contentKeyProc field in the frHndl should be set to nil.  This will indicate to
	** DoKeyDown() that all keys should be passed through this window.  DTS.Draw has
	** such a window.  The palette window doesn’t accept keys.  They are passed through
	** to document windows that are behind the palette. */

void			DoMouseDown(EventRecord *event);
	/* Call this whenever a mouse down event occurs in the application.  Everything is
	** handled.  Here’s what DoMouseDown() may do, and what it depends on:
	** It handles:
	**     inContent
	**     inDrag
	**     inGoAway
	**     inGrow
	**     inMenuBar
	**     inSysWindow
	**     inZoomIn
	**     inZoomOut
	**
	** inContent:
	**     a) If the window clicked on is a DA window, then bring the window to the front.
	**     b) If the window is not the top-most of its kind (palette,dialog,document), then
	**        it is made the top-most of its kind.  If the window has the kwDoFirstClick bit
	**        set, then DoContentClick is called, indicating that it is a first click.
	**
	** inDrag:
	**     The window is dragged.  When released, if the command key was not held down at the
	**     time of the click, the window is made the top-most window of its kind.
	**
	** inGoAway:
	**     The go-away is tracked.  If the document is dirty, then the user is asked if the
	**     document should first be saved.  The user can save, discard, or cancel.  All cases
	**     are handled.
	**
	** inGrow:
	**     The window is grown.  Scrollbar adjustments are handled as they are in the 7.0 finder.
	**
	** inMenuBar:
	**     MenuSelect() is called, then the application function DoMenuCommand() is called
	**     with the result of MenuSelect().
	**
	** inSysWindow:
	**     SystemClick() is called.
	**
	** inZoomIn:
	** inZoomOut:
	**     The window is grown, according to the human-interface guidelines for zooming.
	**     The window is zoomed on the monitor that contains most of the window.  The zoom
	**     size is limited by the document size.  All of these details are handled. */

short			MapMItem(short menuID, short menuItem);
	/* This function converts a menu item hard-id (one returned by the toolbox) to a
	** soft-id (defined in the 'STR#' resource associated with the menu.  If there is
	** a 'STR#' resource defined with the same id as the menu, it is assumed to be
	** for the purpose of converting hard-id values to soft-id values. */

short			UnmapMItem(short menuID, short menuItem);
	/* This function is the logical reverse of MapMItem(). */

OSErr			DoReadDocument(FileRecHndl frHndl);
	/* DoReadDocument() calls the specific read document procedure for the document.
	** The specific procedure is stored in the frHndl field readDocumentProc.  The
	** default value for readDocumentProc is ReadDocument().  It is the responsibility
	** of the readDocument procedure to call the readDocumentHeader procedure.  This is
	** done by calling DoReadDocumentHeader() from within the readDocumentProc. */

OSErr			DoReadDocumentHeader(FileRecHndl frHndl);
	/* DoReadDocumentHeader() calls the specific read document header procedure for the
	** document.  The specific procedure is stored in the frHndl field readDocumentHeaderProc.
	** The default value for readDocumentHeaderProc is DefaultReadDocumentHeader(). */

OSErr			DefaultReadDocumentHeader(FileRecHndl frHndl);
	/* This function reads in the default header for a file.  The header information is
	** described by the structure DocHeaderInfo.  The typedef for this structure is in the
	** file DTS.Lib.h.  This block of header information is saved at the beginning of the file.
	** It is written to the data fork.  If you want the header information saved in the resource
	** fork, you will have to have a custom readDocumentHeaderProc and writeDocumentHeaderProc.
	** You can then simply read and write using the resource fork, instead of the data fork, as
	** the defaults do. */

OSErr			DoWriteDocument(FileRecHndl frHndl);
	/* DoWriteDocument() calls the specific write document procedure for the document.
	** The specific procedure is stored in the frHndl field writeDocumentProc.  The
	** default value for writeDocumentProc is WriteDocument().  It is the responsibility
	** of the writeDocument procedure to call the writeDocumentHeader procedure.  This is
	** done by calling DoWriteDocumentHeader() from within the writeDocumentProc. */

OSErr			DoWriteDocumentHeader(FileRecHndl frHndl);
	/* DoWriteDocumentHeader() calls the specific write document header procedure for the
	** document.  The specific procedure is stored in the frHndl field writeDocumentHeaderProc.
	** The default value for writeDocumentHeaderProc is DefaultWriteDocumentHeader(). */

OSErr			DefaultWriteDocumentHeader(FileRecHndl frHndl);
	/* This function writes out the default header for a file.  The header information is
	** described by the structure DocHeaderInfo.  The typedef for this structure is in the
	** file DTS.Lib.h.  This block of header information is saved at the beginning of the file.
	** It is written to the data fork.  If you want the header information saved in the resource
	** fork, you will have to have a custom readDocumentHeaderProc and writeDocumentHeaderProc.
	** You can then simply read and write using the resource fork, instead of the data fork, as
	** the defaults do. */

void			DoResizeContent(WindowPtr window, short oldh, short oldv);
	/* This function is called when a window has been resized.  It is possible that window
	** contents have to be adjusted to match the new window size.  DoResizeContent() handles
	** this.  DoResizeContent() uses a procedure stored in the frHndl field resizeContentProc.
	** If resizeContentProc is not nil, then the procedure is called.  The default value for
	** resizeContentProc is ResizeContent(). */

void			DoScrollFrame(WindowPtr window, long dx, long dy);
	/* Some applications may need to scroll the "frame" of the document along with the document
	** contents.  This is common for applications with rulers, or other similar sidebar items.
	** DoScrollFrame is called when document scrolling has occured.  DoScrollFrame() uses a
	** procedure stored in the frHndl field scrollFrameProc.  If scrollFrameProc is not nil,
	** then the procedure is called.  The default value for scrollFrameProc is ScrollFrame(). */

void			DoUndoFixup(FileRecHndl frHndl, Point contOrg, Boolean afterUndo);
	/* This function is called by the hierarchical document package in response to an undo/redo
	** operation.  It is called prior to any undo information being applied to the document so
	** that you can prepare the document for an undo.  It is also called after all undo tasks
	** are performed on the document.  This last call is a chance for any additional cleanup
	** that might have to occur.  Commonly this second call is used to reimage the document to
	** show the document undone/redone.  DoUndoFixup() doesn’t actually do the work, as it doesn’t
	** know what kind of document it was called for.  It simply looks in the frHndl at the field
	** undoFixupProc.  If undoFixupProc is not nil, then the procedure is called.  The default
	** value for undoFixupProc is UndoFixup(). */

void			CleanSendBehind(WindowPtr window, WindowPtr afterWindow);
	/* This function is exactly what it would seem by the name.  SendBehind() has some problems
	** in that it causes too much repainting of windows.  This function allows you to change the
	** layer of a window very cleanly.  It also calls HiliteWindows(), which walks the window
	** list and adjusts window hilighting for the various types of windows.  The top-most of a
	** type is hilited, and all other windows of that type are unhilited. */

void			CleanSendInFront(WindowPtr window, WindowPtr beforeWindow);
	/* Again, this is exactly what it would seem.  See CleanSendBehind() for more information. */

void			HiliteWindows(void);
	/* This function is called to adjust the hilites of all windows.  Since DTS.framework
	** supports palettes, there is possibly more than one hilited window.  The window manager
	** doesn’t want to play this game, so certain additional functions had to be written.
	** Basically, if you are using palettes, don’t make any window manager calls that change
	** window hiliting.  Use CleanSendBehind() and CleanSendInFront().  These take care of
	** window shuffling correctly.  Of course, there are calls you can’t avoid, such as
	** closing a window.  If you do these operations directly, call HiliteWindows() afterwards. */

void			UnhiliteWindows(void);
	/* This is called to unhilite all windows.  DTS.framework allows for multiple hilited windows.
	** All of them have to be unhilited prior to bringing up a modal dialog or alert.  Call this
	** to unhilite all windows, do the modal dialog or alert, and then call HiliteWindows() to
	** set the hiliting back to normal. */

void			DoUpdate(WindowPtr window);
	/* This is called when an update event is received for a window.  First, the
	** updateRgn is separated into two parts.  Part 1 holds the window frame area,
	** if any.  This is the area that might hold the scrollbars, grow icon, and
	** any other application-specific frame parts.  This is drawn first.  Once
	** this is done, the remainder of the updateRgn is drawn.  This allows us to
	** handle all of the frame clipping without using the clipRgn.  By freeing up
	** the clipRgn, we allow the application to use it without having to share. */

void			DoSetCursor(Cursor *cursor);
	/* Call this function to correctly set the cursor and to inform DTS.framework that
	** you have specifically set the cursor.  This is used when you temporarily want to
	** set the cursor, such as just before a slow operation.  For a slow operation, you
	** may want to put up the wait cursor.  Use DoSetCursor() for this, and then when the
	** operation is over and program control returns to the main event loop, the cursor
	** will be recalculated to the current cursor for the mouse position. */

CursPtr			DoSetResCursor(short crsrID);
	/* This function serves the same purpose as DoSetCursor, except that you pass in
	** a resID, instead of a cursor pointer.  The resource is loaded, the cursor is then
	** copied into permanent memory, and then DoSetCursor is called with a pointer to
	** the cursor image. */

void			DoWindowCursor(void);
	/* Call this function to calculate what the cursor should be for various windows.
	** The result of this function is to set the cursor based on the current mouse position.
	** In addition to setting the cursor, the cursor region is calculated.  The cursor
	** region is kept in the global variable gCursorRgn.
	** This function walks the window list, and for each document window, it calls the
	** window’s cursor handling procedure.  The cursor handling procedure is stored in
	** the frHndl field windowCursorProc.
	** Here are the rules for cursor and gCursorRgn determination:
	**
	** 1) See if the mouse position is currently inside the gCursorRgn.  If so, leave.
	** 2) Since the mouse position is outside the current gCursorRgn, we need to recalculate
	**    the cursor.  Set the gCursorRgn to wide-open.  From now on, we will eliminate areas
	**    from gCursorRgn that don’t apply to the new mouse location and new cursor.
	** 3) For each visible window (starting with the front window):
	**    a) If the windowCursorProc is nil and the mouse position is over the structure region
	**       of the window, set the cursor to an arrow and intersect the gCursorRgn with the
	**       structure region of the window.  This limits the cursor to the area of the window
	**       that is visible.
	**    b) If the windowCursorProc is nil and the mouse position is outside the structure region
	**       of the window, diff out the structure region from gCursorRgn and proceed to the next
	**       visible window in the window list.
	**    c) If the windowCursorProc is not nil, call the procedure.  Note that the procedure is
	**       called whether or not the mouse location is over the window.  This is to allow the
	**       procedure to determine if it should be the last window checked.
	**       The proc’s job is as follows:
	**       1) If the cursor is over a position that is determined by the window, then
	**          the proc removes other areas from gCursorRgn.  Note that it should not
	**          simply set the area to what it "thinks" is the correct area.  This window
	**          may not be the front-most.  Other windows will have already been subtracted
	**          from gCursorRgn.  The resultant gCursorRgn is the correct cursor area,
	**          and should be passed to WaitNextEvent calls in the application.  Also,
	**          the cursor should be set to the correct cursor, of course.
	**          You should also return true, as the cursor has been determined.
	**          The rule of thumb for what you should do to the gCursorRgn is that you should
	**          calculate the cursor region as if the window was the top window.  Once this
	**          is done, intersect the gCursorRgn with this region.  The result should be
	**          stored in gCursorRgn.
	**          Since you determined a cursor and gCursorRgn in this case, you should return
	**          true.  Returning true indicates to DoWindowCursor() that the cursor has been
	**          determined, and that it should stop processing windows.
	**       2) If the cursor is not over a position for this window, then you should
	**          return.  You will either pass back true or false.  If you don’t wish
	**          windows behind this window to have a shot at cursor determination, then
	**          return true.  This states that the cursor is "determined".  It is, in the
	**          sense that no further determination will occur.  If you return false, then
	**          other windows get a shot at determining the cursor.  If there are no other windows,
	**          then the cursor is set to an arrow, and gCursorRgn is set to the area that is outside
	**          all windows for the application.
	**          (Common case:)  If you don’t want windows behind this one to determine the cursor:
	**          a) Set the cursor to an arrow.  Since you are outside this window, the cursor
	**             should be an arrow.  The cursor may be over the desktop or menubar, or some
	**             other window that isn’t the top-most window.  All of these cases should have
	**             an arrow cursor.  Also, you need to diff out the window’s structure region from
	**             gCursorRgn.  By diffing it out, you will get mouse-moved events when the
	**             cursor is moved back over this window.
	**          b) Return true.  This tells DoWindowCursor() that the cursor has been determined.
	**          (Uncommon case:)  If you want windows behind this one to possibly determine the cursor:
	**             Return false.  That’s it.  DTS.framework will automatically remove the structure
	**             region for this window from gCursorRgn if you return false.  If you return false,
	**             DTS.framework proceeds to the next window, if there is one.  If there are no more
	**             windows behind this one, then DTS.framework sets the cursor to an arrow, and
	**             the resultant gCursorRgn will have all of the structure regions for the windows
	**             removed from it. */

WindowPtr		FrontWindowOfType(long wkind, Boolean firstVis);
	/* Since DTS.framework supports three distinct categories of windows (document/palette/dialog),
	** it is often necessary to get the front-most window of a certain type.  Use this function
	** to accomplish this.  Basically, this takes the place of FrontWindow() if you have more
	** than one category of window in your application. */

short			HCenteredAlert(short alertID, WindowPtr relatedWindow, ModalFilterUPP filter);
	/* This function gets an alert, and handles hiliting of windows correctly.
	** The reason for this function is that there may be more than one hilited
	** window due to the possibility of floating palettes.  The calls to UnhiliteWindows
	** and HiliteWindows make sure that while the alert is up, there are no other
	** hilited windows. */

OSErr			GetWindowFormats(void);
	/* This function gets the application window formats that were created with
	** the AppsToGo application editor.  The window formats are stored in the resource
	** 'WFMT' id #128.  They are first read in, and then they are unflattened
	** by calling HReadWindowFormats(). */

OSErr			HReadWindowFormats(Handle wfmt);
	/* This function is called to unflatten a window-format handle into separate
	** hierarchical document objects.  The assumption is that there is only one
	** of these multiple window definitions, and therefore if there is already
	** one in the global gWindowFormats, it is disposed of.  This is exactly the
	** behavior needed by the AppsToGo application editor. */

OSErr			GetSeparateWFMT(OSType sftype, short *numAdded);
	/* This function is called to add (or remove) a window-format resource definition
	** to the global gWindowFormats.  The purpose of this is to be able to break up the
	** single 'WFMT' id #128 resource, which may get quite large for some applications.
	** NewDocumentWindow() and AddControlSet() automatically call GetSeparateWFMT() 
	** for you.  If the document definition is in a separate 'WFMT' resource,
	** then that definition is added to gWindowFormats long enough to be used, and then
	** it is removed.  The 'WFMT' resource can be of any id other than 128, and must be
	** named with the DocType, such as ABOT for the about box.  (The name must always be
	** 4 characters.)  Passing in 0 for the DocType (OSType) disposes of however many
	** were added.  The number added is returned from the first time it is called. */

OSErr			AddControlSet(WindowPtr window, OSType sftype, short visMode,
							  short xoffset, short yoffset, CObjCtlHndl cco);
	/* This function adds a set of controls (and sets referenced by that set) to the
	** window.  The control sets are created with the AppsToGo application editor. */

ControlHandle	MakeControl(WindowPtr window, TreeObjHndl cobj,
							short visMode, short xoffset, short yoffset);
	/* This function is used to create a control based on the control definition object.
	** The control definition objects are created with the AppsToGo application editor. */

CObjCtlHndl		GetControlSet(WindowPtr window, OSType sftype, ControlHandle *retDataCtl);
	/* This function is called to return the handle of the Data control that has
	** a reference to all of the controls in the control set.  Once you get the
	** Data control, you can then look at the data in the control to get the handle
	** of the controls within the control set. */

void			DisplayControlSet(WindowPtr window, OSType sftype, short visMode);
	/* This function is used to show or hide a set of controls. */

void			DrawControlSet(WindowPtr window, OSType sftype);
	/* This function is used to draw a set of controls. */

void			DisposeControlSet(WindowPtr window, OSType sftype);
	/* This function is used to dispose a set of controls. */

Boolean			DoAdjustMBARMenus(WindowPtr window, short menuBarID);
	/* This fuction is called to adjust all of the menus in the designated MBAR. 
	** The functions gets each menu handle, and then disables all of the menu items
	** for that menu.  It then calls the application to give the application the
	** chance to enable the appropriate menu items. */

OSErr			OpenRuntimeOnlyAutoNewWindows(void);
	/* This function is used to open all of the windows that are correctly designated
	** with the AppsToGo application editor.  You should call this in your application
	** at startup time if your application is editable with the AppsToGo application editor. */

OSErr			NewDocumentWindow(FileRecHndl *frHndl, OSType sftype, Boolean incTitleNum);
	/* This call can be done as two separate calls.  However, this function does both
	** functions of creating the document, and then giving the document a window.  It
	** also handles errors and puts up an error window if something goes wrong. */

OSErr			OpenDocumentWindow(FileRecHndl *frHndl, FSSpecPtr fileToOpen, char permission);
	/* This call can be done as two separate calls.  However, this function does both
	** functions of creating the document, and then giving the document a window.  It
	** also handles errors and puts up an error window if something goes wrong. */



/************** Window.c **************/

/* •• DTS.Lib..framework calls these. •• */
/* See the sample application AppWannabe for an explanation of these functions. */

void			CalcFrameRgn(FileRecHndl frHndl, WindowPtr window, RgnHandle rgn);
void			ContentClick(WindowPtr window, EventRecord *event, Boolean firstCLick);
Boolean			ContentKey(WindowPtr window, EventRecord *event, Boolean *passThrough);
void			DrawFrame(FileRecHndl frHndl, WindowPtr window, Boolean activate);
OSErr			FreeDocument(FileRecHndl frHndl);
OSErr			FreeWindow(FileRecHndl frHndl, WindowPtr window);
OSErr			ImageDocument(FileRecHndl frHndl);
OSErr			InitContent(FileRecHndl frHndl, WindowPtr window);
OSErr			ReadDocument(FileRecHndl frHndl);
void			ResizeContent(WindowPtr window, short oldh, short oldv);
void			ScrollFrame(FileRecHndl frHndl, WindowPtr window, long dh, long dv);
void			UndoFixup(FileRecHndl frHndl, Point contOrg, Boolean afterUndo);
Boolean			WindowCursor(FileRecHndl frHndl, WindowPtr window, Point globalPt);
void			WindowGoneFixup(WindowPtr window);
OSErr			WriteDocument(FileRecHndl frHndl);
OSErr			DoOpenApplication(void);
Boolean			AdjustMenuItems(WindowPtr window, short menuID);
Boolean			DoMenuItem(WindowPtr window, short menuID, short menuItem);



/************** WindowDialog.c **************/

/* •• DTS.Lib..framework calls these. •• */
/* See the sample application AppWannabe for an explanation of these functions. */

void			DialogCalcFrameRgn(FileRecHndl frHndl, WindowPtr window, RgnHandle rgn);
void			DialogContentClick(WindowPtr window, EventRecord *event, Boolean firstCLick);
Boolean			DialogContentKey(WindowPtr window, EventRecord *event, Boolean *passThrough);
void			DialogDrawFrame(FileRecHndl frHndl, WindowPtr window, Boolean activate);
OSErr			DialogFreeDocument(FileRecHndl frHndl);
OSErr			DialogFreeWindow(FileRecHndl frHndl, WindowPtr window);
OSErr			DialogImageDocument(FileRecHndl frHndl);
OSErr			DialogInitContent(FileRecHndl frHndl, WindowPtr window);
void			DialogResizeContent(WindowPtr window, short oldh, short oldv);
void			DialogScrollFrame(FileRecHndl frHndl, WindowPtr window, long dh, long dv);
void			DialogUndoFixup(FileRecHndl frHndl, Point contOrg, Boolean afterUndo);
Boolean			DialogWindowCursor(FileRecHndl frHndl, WindowPtr window, Point globalPt);
void			DialogWindowGoneFixup(WindowPtr window);
Boolean			DialogAdjustMenuItems(WindowPtr window, short menuID);
Boolean			DialogDoMenuItem(WindowPtr window, short menuID, short menuItem);


/************** WindowPalette.c **************/

/* •• DTS.Lib..framework calls these. •• */
/* See the sample application AppWannabe for an explanation of these functions. */

void			PaletteCalcFrameRgn(FileRecHndl frHndl, WindowPtr window, RgnHandle rgn);
void			PaletteContentClick(WindowPtr window, EventRecord *event, Boolean firstCLick);
Boolean			PaletteContentKey(WindowPtr window, EventRecord *event, Boolean *passThrough);
void			PaletteDrawFrame(FileRecHndl frHndl, WindowPtr window, Boolean activate);
OSErr			PaletteFreeDocument(FileRecHndl frHndl);
OSErr			PaletteFreeWindow(FileRecHndl frHndl, WindowPtr window);
OSErr			PaletteImageDocument(FileRecHndl frHndl);
OSErr			PaletteInitContent(FileRecHndl frHndl, WindowPtr window);
void			PaletteResizeContent(WindowPtr window, short oldh, short oldv);
void			PaletteScrollFrame(FileRecHndl frHndl, WindowPtr window, long dh, long dv);
void			PaletteUndoFixup(FileRecHndl frHndl, Point contOrg, Boolean afterUndo);
Boolean			PaletteWindowCursor(FileRecHndl frHndl, WindowPtr window, Point globalPt);
void			PaletteWindowGoneFixup(WindowPtr window);



#endif
