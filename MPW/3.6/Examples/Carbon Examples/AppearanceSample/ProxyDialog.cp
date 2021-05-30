/*
	File:		ProxyDialog.cp

	Contains:	xxx put contents here xxx

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

#ifdef __MRC__
#include <Quickdraw.h>
#include <ControlDefinitions.h>
#include <Dialogs.h>
#include <Folders.h>
#include <MacWindows.h>
#include <StandardFile.h>
#include <Icons.h>
#include <Aliases.h>
#include <Errors.h>
#include <Navigation.h>
#endif	// __MRC__
#include "ProxyDialog.h"
//#define _DEBUG 1
#include "Assertions.h"

#define kObjectProxyDialogKind	2001

static Boolean GetAFile(FSSpec *fileSpec);

void HandleProxyDrag(WindowPtr theWindow, EventRecord *event)
{
	if (event->modifiers & shiftKey)  // we'll do it the hard way to show you how to do it if you have special needs..
		{
			RgnHandle outlineRegion = NewRgn();
			DragReference theDragRef;
			
			if (outlineRegion)
				{
					OSStatus theError;
				
					theError = BeginWindowProxyDrag(theWindow, &theDragRef, outlineRegion);
					ASSERT(theError == noErr);
					
					theError = TrackWindowProxyFromExistingDrag(theWindow, event->where, theDragRef, outlineRegion);
					ASSERT((theError == noErr) || (theError == userCanceledErr));

					theError = EndWindowProxyDrag(theWindow, theDragRef);
					ASSERT(theError == noErr);
					
					DisposeRgn(outlineRegion);
				}
		}
	else // Life is simple -- let them do the work for us!!!
		TrackWindowProxyDrag(theWindow, event->where);
}

ProxyDialog::ProxyDialog(SInt16 resID) : BaseDialog(resID)
{
}

void ProxyDialog::DoDragClick(EventRecord *event)
{
	SInt32 ignoreMenuResult;
	Boolean isPathSelect;
	OSStatus pathSelectResult;
	Rect		tempRect;
	
	isPathSelect = 	IsWindowPathSelectClick(fWindow, event);

	if (isPathSelect)
		pathSelectResult = WindowPathSelect(fWindow, nil, &ignoreMenuResult);

	if (!isPathSelect || (pathSelectResult == errUserWantsToDragWindow))
		DragWindow( fWindow, event->where, GetRegionBounds( GetGrayRgn(), &tempRect ) );
}	

ProxyDialog::~ProxyDialog()
{
	if ( fWindow )
	{
		DisposeDialog( fDialog );
		fWindow = nil;
	}
}

static Boolean GetAFile(FSSpec *fileSpec)
{
	NavReplyRecord		reply;
	OSErr				err;
	NavDialogOptions	options;
	Boolean				result = false;
	
	NavGetDefaultDialogOptions( &options );

	options.dialogOptionFlags &= ~kNavAllowMultipleFiles;

	err = NavGetFile( NULL, &reply, &options,
								NULL, NULL, NULL, NULL, NULL);
	
	if ( (err == noErr) && reply.validRecord )
	{
		AEDesc		fileSpecDesc = { typeNull, nil };
		AEKeyword	unusedKeyword;

		err = AEGetNthDesc( &reply.selection, 1, typeFSS, &unusedKeyword, &fileSpecDesc );

		if ( err == noErr )
			AEGetDescData(&fileSpecDesc, fileSpec, sizeof(FSSpec) );
//			BlockMoveData( *fileSpecDesc.dataHandle, fileSpec, sizeof( FSSpec ) );

		AEDisposeDesc( &fileSpecDesc );
	
		result = true;
	}

	NavDisposeReply( &reply );

	return result;
}

void ProxyDialog::UpdateContentIcon(void)
{
	ControlHandle theImageWell;
	IconRef theIcon;
	ControlButtonContentInfo myContentInfo;
	OSStatus theError = noErr;
	ControlContentType myType = kControlContentIconRef;

	GetDialogItemAsControl( fDialog, 5, &theImageWell);

	theError = SetControlData(theImageWell, kControlImageWellPart, kControlImageWellContentTag, sizeof(myType), (Ptr) &myType);
	ASSERT(theError == noErr);

	theError = GetWindowProxyIcon(fWindow, &theIcon);

	if (theError == noErr)
		{
			myContentInfo.contentType = kControlContentIconRef;
			myContentInfo.u.iconRef = theIcon;
		
			theError = SetImageWellContentInfo(theImageWell, &myContentInfo);
			ASSERT(theError == noErr);
		}
}

void ProxyDialog::DoAddProxyIcon(Boolean fromAlias)
{
	FSSpec fileSpec={0,0,"\p"};
	OSErr theError;
	
	if (GetAFile(&fileSpec))
		{
			if (!fromAlias)
				{
					theError = SetWindowProxyFSSpec(fWindow, &fileSpec);
					ASSERT(theError == noErr);
				}
			else
				{
					AliasHandle theAlias;
				
					// In the real world you'd already have an alias.. but we're just converting
					// the FSSpec we just got *into* an alias, and using the alternate call.	
					if (NewAliasMinimal(&fileSpec,&theAlias) == noErr)
						{
							theError = SetWindowProxyAlias(fWindow,theAlias);
							ASSERT(theError == noErr);
						}
				}

			UpdateContentIcon();
		}
}

void
ProxyDialog::HandleItemHit( short itemHit )
{
	OSStatus theError = noErr;
	ControlHandle modifiedCheckbox;
	
	enum{
		kRemoveProxy	= 1,
		kAddFSSpec		= 2,
		kAddProxyAlias	= 3,
		kSetIcon		= 4,
		kWindowModified = 7
	};

	switch(itemHit)
		{
			case kRemoveProxy:
				theError = RemoveWindowProxy(fWindow);  // not exported yet
				break;
			case kAddFSSpec:
			case kAddProxyAlias:
				DoAddProxyIcon( itemHit == kAddProxyAlias);
				break;
			case kSetIcon:
				theError = SetWindowProxyCreatorAndType(fWindow, 'ttxt','TEXT',kOnSystemDisk);
				UpdateContentIcon();
				break;
			case kWindowModified:
				GetDialogItemAsControl( fDialog, kWindowModified, &modifiedCheckbox);
				SetWindowModified(fWindow,GetControlValue(modifiedCheckbox));
				break;
		}
	ASSERT(theError == noErr);
}
