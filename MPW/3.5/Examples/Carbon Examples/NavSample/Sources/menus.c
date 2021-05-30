/*
	File:		menus.c

	Contains:	Menu code for NavSample

	Version:	1.4

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

	Copyright © 1996-2001 Apple Computer, Inc., All Rights Reserved
*/
	
#ifndef Common_Defs
#include "Common.h"
#endif

#ifdef __MRC__
#include <Sound.h>
#include <Scrap.h>
#include <ToolUtils.h>
#include <Resources.h>
#include <Folders.h>
#if !TARGET_API_MAC_CARBON
#include <Devices.h>
#endif
#endif	// __MRC__

#include "modern.h"
#ifndef __myFILE__
#include "file.h"
#endif


void AdjustClassicMenu( void );
void AdjustModernMenu( Document* theDocument );

// common utility prototypes:
short DoPaste( void );
void DoAbout( void );

// 1) Simple examples:
OSErr DoSelectDictionary( void );
OSErr DoSelectDirectory( void );
OSErr DoSelectObject( void );
OSErr DoSelectVolume( void );
OSErr DoCreateFolder( void );

// 2) Choose application example:
OSErr DoSelectApp( void );	// choose application (both apps and packages)								

// 3) open customization example:
void RightJustifyPict( NavCBRecPtr callBackParms );
OSErr DoCustomOpen( void );

// 4) for add/remove example:
OSErr DoCustomAddRemove( void );

// 5) for Custom Show Popup Example:
OSErr DoCustomShow( Boolean partialCustomize );

// 6) for Custom Show Format Example:
OSErr DoCustomFormat( Boolean partialCustomize );

// 7) for New File Example:
OSErr DoNewFileExample( void );


// ==================================================================================================

// custom dialog items:
#define kControlListID			134
#define kControlListIDInset		132
#define kPopupCommand 			1
#define kAllowDismissCheck		2
#define kPictItem				3
#define kRadioOneItem			6
#define kRadioTwoItem			7
#define kButtonItem				8

// new file dialog items:
#define kNewFileListID			135
#define kNewFileListIDInset		136
#define kNewFileButton			1

// add remove dialog items:
#define kAddRemoveControlListID	133
#define iList					1
#define iRemoveButton			2
#define iRemoveAllButton		3
#define iDoneButton				4
#define iAddAllButton			5

#define kAddRemoveH			

extern short		gAppResRef;
extern Document* 	gDocumentList[kMaxDocumentCount];
extern short		gDocumentCount;
extern short		gCanUndoDrag;
extern short		gQuit, gQuitting;
extern Boolean		gNavServicesExists;
extern NavDialogRef	gAppNavDialog;

// customization globals:
Handle 		gDitlList;
short 		gLastTryWidth;
short 		gLastTryHeight;
ListHandle	gListItem;
long		gNumItems;
Rect		gOriginalRect;
Boolean		gCanDismiss;


// ==================================================================================================
// for Show/Format Custom Popup examples:
// custom menu item creator/types:
const	OSType	kCustomType1 	= 'txt1';
const	OSType	kCustomType2 	= 'txt2';
const	OSType	kCustomType3 	= 'txt3';

OSType 		gCurrentType;		// keep track of our popup selection
Boolean		gFullCustomPopup;	// signifies we are fully customizing our show/type popup


//==============================================================================
#pragma mark	• Utilities •
//==============================================================================



// *****************************************************************************
// *
// *	AdjustModernMenu( )
// *
// *****************************************************************************
void AdjustModernMenu( Document* theDocument )
{
	MenuRef theMenu = GetMenuHandle( idModernMenu );
	 
#if !TARGET_API_MAC_CARBON
#pragma unused( theDocument )
	SetItemEnable( theMenu, 0, false );	// for non-Carbon builds, this menu is inaccessible
#else
    Boolean	disableEntireMenu = false;
     
    if ( gNavServicesExists )
    {
    	OSErr	err = noErr;
       	long 	carbonVersion = 0;

        // grab the current Carbon version:
        err = Gestalt( gestaltCarbonVersion, &carbonVersion );
		if ( err == noErr && carbonVersion >= 0x0110 )
		{
			SetItemEnable( theMenu, iCreateConfirm, (theDocument != NULL && theDocument->fNavigationDialog == NULL ));
            SetItemEnable( theMenu, iCreateOpen, gAppNavDialog == NULL );
            SetItemEnable( theMenu, iCreateSave, (theDocument != NULL && theDocument->fNavigationDialog == NULL ));
            SetItemEnable( theMenu, iCreateChoose, gAppNavDialog == NULL );
            SetItemEnable( theMenu, iCreateNewFolder, gAppNavDialog == NULL );
            SetItemEnable( theMenu, iCustomShowPopup, gAppNavDialog == NULL );
            SetItemEnable( theMenu, iCustomCarbonEvents, gAppNavDialog == NULL );   
		}
		else
			SetItemEnable( theMenu, 0, false );
  	}
  	else
  		SetItemEnable( theMenu, 0, false );
#endif // !TARGET_API_MAC_CARBON
}


// *****************************************************************************
// *
// *	AdjustClassicMenu( )
// *
// *****************************************************************************
void AdjustClassicMenu( )
{
	MenuHandle theMenu = GetMenuHandle( idClassicMenu );
	
    SetItemEnable( theMenu, iSelectDir, gNavServicesExists );
    SetItemEnable( theMenu, iSelectVol, gNavServicesExists );
    SetItemEnable( theMenu, iSelectObject, gNavServicesExists );
    SetItemEnable( theMenu, iSelectApp, gNavServicesExists );
    SetItemEnable( theMenu, iCreateFolder, gNavServicesExists );
    SetItemEnable( theMenu, iCustomOpen, gNavServicesExists );
    SetItemEnable( theMenu, iAddFiles, gNavServicesExists );
    SetItemEnable( theMenu, iCustShow, gNavServicesExists );
    SetItemEnable( theMenu, iFullyCustShow, gNavServicesExists );
    SetItemEnable( theMenu, iCustFormat, gNavServicesExists );
    if ( gNavServicesExists )
    {
    	UInt32 version = NavLibraryVersion( );
   
   		if ( version == 0x02008000 )	// this example is for Nav v2.0 only
      		SetItemEnable( theMenu, iNewFile, true );
       	else
    		SetItemEnable( theMenu, iNewFile, false );
                    
     	// this example is available only in Nav v2.0 or greator:
      	if ( version >= 0x02008000 )
      		SetItemEnable( theMenu, iFullyCustFormat, true );
    	else
     		SetItemEnable( theMenu, iFullyCustFormat, false );
    }
    else
    {
    	SetItemEnable( theMenu, 0, false );
    }
}


// *****************************************************************************
// *
// *	AdjustMenus( )
// *
// *****************************************************************************
void AdjustMenus( )
{	
    MenuHandle	theMenu;
    Document*	theDocument = NULL;
    short		teSelection = 0;
    Str255		theStr;
    WindowPtr 	theWindow = NULL;
    
    theWindow = FrontWindow( );
    if ( theWindow != NULL )
    {
        theDocument = IsDocumentWindow( theWindow );
        if ( theDocument != NULL )
            if ( theDocument->theTE != NULL )
                teSelection = (theDocument) && ((**(theDocument->theTE)).selStart != (**(theDocument->theTE)).selEnd);
    }
    
    theMenu = GetMenuHandle( idFileMenu );

    SetItemEnable( theMenu, NewItem, gDocumentCount < kMaxDocumentCount );
    SetItemEnable( theMenu, OpenItem, gDocumentCount < kMaxDocumentCount );

    SetItemEnable( theMenu, CloseItem, theDocument != NULL );
    if ( theDocument != NULL )
   	{
   		if ( theDocument->fileLocked )
   			SetItemEnable( theMenu, SaveItem, false );	// don't allow saving on a locked file
   		else
   			SetItemEnable( theMenu, SaveItem, theDocument && theDocument->dirty );
   	}
    else
   		SetItemEnable( theMenu, SaveItem, false );
            
    SetItemEnable( theMenu, PrintItem, false );	// no printing supported yet
    
    if ( theDocument != NULL )
  		SetItemEnable( theMenu, RevertItem, theDocument && theDocument->dirty && theDocument->fRefNum );
    else
 		SetItemEnable( theMenu, RevertItem, false );
            
    SetItemEnable( theMenu, SaveACopyItem, theDocument != NULL );

    SetItemEnable( theMenu, DictionaryItem, gNavServicesExists );

    theMenu = GetMenuHandle( idEditMenu );

    GetIndString( theStr, MenuStringsID, gCanUndoDrag );
    SetMenuItemText( theMenu, iUndo, theStr );
    SetItemEnable( theMenu, iUndo, gCanUndoDrag != slCantUndo );

    SetItemEnable( theMenu, iCut, teSelection );
    SetItemEnable( theMenu, iCopy, teSelection );
    SetItemEnable( theMenu, iPaste, theDocument != NULL );
    SetItemEnable( theMenu, iClear, teSelection );
    SetItemEnable( theMenu, iSelectAll, theDocument != NULL );

   	AdjustClassicMenu( );
    AdjustModernMenu( theDocument );
    
    InvalMenuBar( );
}




//==============================================================================
#pragma mark	• Menu Items •
//==============================================================================


// *****************************************************************************
// *
// *	DoPaste( )
// *
// *****************************************************************************
short DoPaste( )
{	
#if TARGET_API_MAC_CARBON

	// use the Carbon Scrap Manager:
	OSStatus theErr = noErr;
	ScrapRef scrapRef;
	
	theErr = GetCurrentScrap( &scrapRef );
	if ( theErr != noTypeErr && theErr != memFullErr )	
	{
		ScrapFlavorType 	flavorType = 'UPRC';
		ScrapFlavorFlags	flavorFlags;
		Size				byteCount;
		Handle				theData;
		
		if (( theErr = GetScrapFlavorFlags( scrapRef, flavorType, &flavorFlags )) == noErr)
		{
			if (( theErr = GetScrapFlavorSize( scrapRef, flavorType, &byteCount )) == noErr)
			{
				theData = NewHandle( byteCount );
				if (( theErr = GetScrapFlavorData( scrapRef, flavorType, &byteCount, &theData )) == noErr)
					theErr = PutScrapFlavor( NULL, 'test', kScrapFlavorMaskNone, byteCount, *theData );
				DisposeHandle( theData );
			}
		}
	}
	return theErr;
	
#else

	// use the 8.x Scrap Manager:
	long	size, offset;
	Handle	theData;

	size = GetScrap( 0L, 'UPRC', &offset );

	if ( size <= 0 )
		return( 0 );

	theData = NewHandle( size );
	GetScrap( theData, 'UPRC', &offset );

	HLock( theData );
	PutScrap( size, 'test', *theData );

	HUnlock( theData );
	DisposeHandle( theData );

	return noErr;
	
#endif // TARGET_API_MAC_CARBON
}


// *****************************************************************************
// *
// *	DoAbout( )
// *	
// *****************************************************************************
void DoAbout( )
{
	GrafPtr		savePort;
	DialogPtr	aboutDialog;
	short		itemHit = 0;
	Handle		itemH;
	short		itemType;
	Rect		itemRect;
	WindowPtr 	window;
	
	InitCursor( );
	aboutDialog = GetNewDialog( rAboutID, NULL, (WindowRef)-1 );
	
	GetPort( &savePort );

	window = GetDialogWindow( aboutDialog );	
	SetPort( (GrafPtr)GetWindowPort( window ) );

	AdornButton( aboutDialog, dOK );

	GetDialogItem( aboutDialog, iIconSuite, &itemType, &itemH, &itemRect );
	DrawIconSuite( rIconSuite, itemRect );
					
	do ModalDialog( NULL, &itemHit );

	while( itemHit != dOK );
	
	SetPort( savePort );
	DisposeDialog( aboutDialog );
}


// *****************************************************************************
// *
// *	DoMenuCommand( )
// *
// *****************************************************************************
void DoMenuCommand( long select )
{	
	OSStatus	theErr = noErr;
	short		theMenuID, theItem;
	MenuHandle	theMenu;
	WindowPtr	theWindow = NULL;
	Document*	theDocument = NULL;

	gCanUndoDrag = slUndoDrag;
	AdjustMenus( );
	
	theWindow = FrontWindow( );
	if ( theWindow != NULL )
		theDocument = IsDocumentWindow( theWindow );

	theItem   = LoWord( select );
	theMenuID = HiWord( select );
	theMenu   = GetMenuHandle( theMenuID );
	
	switch( theMenuID )
	{
		case idAppleMenu:
		{
			switch( theItem )
			{
				case AboutItem:
				{
					DoAbout( );
					break;
				}
					
#if !TARGET_API_MAC_CARBON
				default:
				{
					Str255 theName;
					GetMenuItemText( GetMenuHandle( idAppleMenu ), theItem, (unsigned char*)&theName );
					OpenDeskAcc( theName );
					break;
				}
#endif
			}
			break;
		}
			
		case idFileMenu:
		{
			switch( theItem )
			{
				case NewItem:
				{
					DoNewDocument( false );
					AdjustMenus( );
					break;
					
				case OpenItem:
#if TARGET_API_MAC_CARBON
					theErr = DoOpenDocument( );	// use NavServices to open
#else
					// branch to StdFile if necessary:
					if ( gNavServicesExists )
						theErr = DoOpenDocument( );
					else	
						(void)DoOpenDocumentTheOldWay( );
#endif // TARGET_API_MAC_CARBON
					AdjustMenus( );		
					break;
				}
					
				case CloseItem:
				{
					if ( theDocument != NULL )
					{
						CloseDocument( theDocument, false );
						AdjustMenus( );
						DrawMenuBar( );
					}
					break;
				}
					
				case SaveItem:
				{
					if ( theDocument != NULL )
						DoSaveDocument( theDocument );
					break;
				}
				
				case SaveACopyItem:
				{
					if ( theDocument != NULL )
					{
#if TARGET_API_MAC_CARBON
						theErr = SaveACopyDocument( theDocument );	// use NavServices to save
#else
						// branch to StdFile if necessary:
						if ( gNavServicesExists )
							theErr = SaveACopyDocument( theDocument );
						else
							(void)SaveACopyDocumentTheOldWay( theDocument );
						
						if ( theErr == memFullErr )
						{
							(void)SaveACopyDocumentTheOldWay( theDocument );
							theErr = noErr;
						}
#endif // TARGET_API_MAC_CARBON
					}
					break;
				}
	
				case RevertItem:
				{
					DisableUndoDrag( );
					if ( theDocument != NULL )
					{
						if ( gNavServicesExists )
							DoRevertDocument( theDocument );			// use NavServices
						else
							DoRevertDocumentTheOldWay( theDocument );	// use StdFile
					}
					break;
				}

				case DictionaryItem:
				{
					theErr = DoSelectDictionary( );
					break;
				}

				case QuitItem:
				{
					gQuitting = true;
					theWindow = FrontWindow( );
					if ( theWindow != NULL )
					{
						theDocument = IsDocumentWindow( theWindow );
						while ( gQuitting && theDocument != NULL )
						{
							if ( theDocument != NULL )
								CloseDocument( theDocument, true );
							theWindow = FrontWindow( );
							if ( theWindow != NULL )
								theDocument = IsDocumentWindow( theWindow );
							else
								theDocument = NULL;
						}
					}
					if ( gQuitting )
						gQuit = true;
					break;
				}
			}
			break;
		}
			
		case idEditMenu:
			switch( theItem )
			{
				case iUndo:
					DoUndoDrag( );
					break;
					
				case iCut:
					if ( theDocument != NULL && theDocument->theTE != NULL )
					{
						DisableUndoDrag( );
						myTECut( theDocument->theTE );
					}
					break;
					
				case iCopy:
					if ( theDocument != NULL )
						TECopy( theDocument->theTE );
					break;
					
				case iPaste:
					if ( theDocument != NULL && theDocument->theTE != NULL )
						if ( !DoPaste( ) )
						{
							DisableUndoDrag( );
							myTEPaste( theDocument->theTE, 0L, 0L );
						}
					break;
					
				case iClear:
					if ( theDocument != NULL && theDocument->theTE != NULL )
					{
						DisableUndoDrag( );
						TEDelete( theDocument->theTE );
					}
					break;
					
				case iSelectAll:
					if ( theDocument != NULL && theDocument->theTE != NULL )
						DoSelectAllDocument( theDocument );
					break;
			}
			break;

		case idClassicMenu:
			switch( theItem )
			{
				case iSelectDir:
					theErr = DoSelectDirectory( );
					break;
				case iSelectVol:
					theErr = DoSelectVolume( );
					break;
				case iSelectObject:
					theErr = DoSelectObject( );
					break;
				case iSelectApp:
					theErr = DoSelectApp( );
					break;
				case iCreateFolder:
					theErr = DoCreateFolder( );
					break;
				case iCustomOpen:
					theErr = DoCustomOpen( );
					break;
				case iAddFiles:
					theErr = DoCustomAddRemove( );
					break;
				case iCustShow:
					theErr = DoCustomShow( true );
					break;
				case iFullyCustShow:
					theErr = DoCustomShow( false );
					break;
				case iCustFormat:
					theErr = DoCustomFormat( true );
					break;
				case iFullyCustFormat:
					theErr = DoCustomFormat( false );
					break;
				case iNewFile:
					theErr = DoNewFileExample( );
					break;
			}
			break;

#if TARGET_API_MAC_CARBON			
		case idModernMenu:
			switch( theItem )
			{
				case iCreateConfirm:
					DoCreateConfirmPanel( theDocument );
					break;
					
				case iCreateOpen:
					if ( gAppNavDialog == NULL )
						DoCreateOpenPanel( );
					break;
					
				case iCreateSave:
					DoCreateSavePanel( theDocument );
					break;
					
				case iCreateChoose:
					if ( gAppNavDialog == NULL )
						DoCreateChoosePanel( );
					break;
					
				case iCreateNewFolder:
					if ( gAppNavDialog == NULL )
						DoCreateNewFolderPanel( );
					break;
					
				case iCustomShowPopup:
					if ( gAppNavDialog == NULL )
						DoCreateCustomShowPanel( );
					break;
					
				case iCustomCarbonEvents:
					if ( gAppNavDialog == NULL )
						DoCreateCustomCarbonEventPanel( );
					break;
			}
			break;
#endif
	}		

	if ( theErr == memFullErr )
		DoLowMemAlert( );
	
	theWindow = FrontWindow( );
	if ( theWindow != NULL )
	{
		theDocument = IsDocumentWindow( theWindow );
		if ( theDocument != NULL )
			if ( theDocument->theTE != NULL )
				TEGetHiliteRgn( theDocument->hiliteRgn, theDocument->theTE );
	}

	HiliteMenu( 0 );
	
	gCanUndoDrag = slCantUndo;
}


//==============================================================================
#pragma mark	• Simple Examples •
//==============================================================================


// *****************************************************************************
// *
// *	DoSelectDictionary( )
// *	
// *****************************************************************************
OSErr DoSelectDictionary( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	NavTypeListHandle	openList = NULL;
	
	// use the default location for the dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );

	GetIndString( dialogOptions.message, rAppStringsID, sChooseFile );

	dialogOptions.preferenceKey = kSelectFilePrefKey;
	
	openList = (NavTypeListHandle)GetResource( kOpenRsrcType, kOpenRsrcID2 );
		
	theErr = NavChooseFile(	NULL,
							&theReply,
							&dialogOptions,
							eventUPP,
							NULL,
							NULL,
							openList,
							(NavCallBackUserData)&gDocumentList );
	
	DisposeNavEventUPP( eventUPP );
	
	if ( theReply.validRecord && theErr == noErr )
	{
		// grab the target FSSpec from the AEDesc:
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// retrieve the returned selection:
		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
		{
			// 'finalFSSpec' is the chosen file…
		}
		
		theErr = NavDisposeReply( &theReply );
	}
	
	if ( openList != NULL )
		DisposeHandle( (Handle)openList );
		
	return theErr;
}


// *****************************************************************************
// *
// *	DoSelectDirectory( )
// *	
// *****************************************************************************
OSErr DoSelectDirectory( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	GetIndString( dialogOptions.message, rAppStringsID, sChooseFolder );
	
	dialogOptions.preferenceKey = kSelectFolderPrefKey;
	
	theErr = NavChooseFolder(	NULL,
								&theReply,
								&dialogOptions,
								eventUPP,
								NULL,
								(NavCallBackUserData)&gDocumentList );
	
	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr)
	{
		// grab the target FSSpec from the AEDescList:	
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )		
		{
			// 'finalFSSpec' is the selected directory…
		}
		
		theErr = NavDisposeReply( &theReply );
	}
		
	return theErr;
}


// *****************************************************************************
// *
// *	DoSelectObject( )
// *	
// *****************************************************************************
OSErr DoSelectObject( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	GetIndString( dialogOptions.message, rAppStringsID, sChooseObject );
	
	dialogOptions.preferenceKey = kSelectObjectPrefKey;
	
	theErr = NavChooseObject(	NULL,
								&theReply,
								&dialogOptions,
								eventUPP,
								NULL,
								(NavCallBackUserData)&gDocumentList );
	
	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		// grab the target FSSpec from the AEDescList:	
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
		{
			// 'finalFSSpec' is the selected directory…
		}
		
		theErr = NavDisposeReply( &theReply );
	}
		
	return theErr;
}


// *****************************************************************************
// *
// *	DoSelectVolume( )
// *	
// *****************************************************************************
OSErr DoSelectVolume( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	
	// use the default location for the dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	GetIndString( dialogOptions.message, rAppStringsID, sChooseVolume );

	dialogOptions.preferenceKey = kSelectVolumePrefKey;
	
	theErr = NavChooseVolume(	NULL,
								&theReply,
								&dialogOptions,
								eventUPP,
								NULL,
								(NavCallBackUserData)&gDocumentList );
	if ( theReply.validRecord && theErr == noErr )
	{
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )	
		{
			// 'finalFSSpec' is the chosen volume…
		}

		theErr = NavDisposeReply( &theReply );
	}
		
	DisposeNavEventUPP( eventUPP );
	
	return theErr;
}


// *****************************************************************************
// *
// *	DoCreateFolder( )
// *	
// *****************************************************************************
OSErr DoCreateFolder( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	
	// use the default location for the dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	GetIndString( dialogOptions.message, rAppStringsID, sCreateFolder );

	dialogOptions.preferenceKey = kNewFolderPrefKey;
	
	theErr = NavNewFolder(	NULL,
							&theReply,
							&dialogOptions,
							eventUPP, 
							(NavCallBackUserData)&gDocumentList );
	if ( theReply.validRecord )
	{
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )	
		{
			// 'finalFSSpec' is the newly created folder…
		}
		
		theErr = NavDisposeReply( &theReply );
	}
		
	return theErr;
}


//==============================================================================
#pragma mark	• Choose Application Example •
//==============================================================================

pascal Boolean myChooseAppFilterProc( AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode );
pascal void myChooseAppEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
void HandleChooseAppStartEvent( NavCBRecPtr callBackParms );


// *****************************************************************************
// *
// *	myChooseAppFilterProc( )
// *
// *****************************************************************************
pascal Boolean myChooseAppFilterProc(AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode )
{
#pragma unused ( callBackUD, filterMode )

	Boolean 		display = false;
	NavFileOrFolderInfo* 	theInfo = (NavFileOrFolderInfo*)info;
	
	if ( theItem->descriptorType == typeFSS )
		if ( theInfo->isFolder )
		{
			if ( theInfo->fileAndFolder.folderInfo.folderType == '????' &&
				( theInfo->fileAndFolder.folderInfo.folderCreator == '????' ))
				display = true;	// it's a normal folder so allow it
			else
				if ( theInfo->fileAndFolder.folderInfo.folderType == 'APPL' )
					display = true;	// it's a package application so allow it
		}
		else
			// it's a file:
			if ( theInfo->fileAndFolder.fileInfo.finderInfo.fdType == 'APPL' )
				display = true;
				
	return display;
}


// *****************************************************************************
// *
// *	DoSelectApp( )
// *
// *	This examples shows you how to use Nav Services to choose an application,
// *	allowing for Mac OS 9.x, Carbon and Mac OS X applications.
// *	
// *****************************************************************************
OSErr DoSelectApp( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	NavObjectFilterUPP	filterUPP = NewNavObjectFilterUPP( myChooseAppFilterProc );
	UInt32 				version = NavLibraryVersion( );

	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	GetIndString( dialogOptions.windowTitle, rAppStringsID, sChooseApp );
	
	dialogOptions.preferenceKey = kSelectAppPrefKey;
	
	// this feature only available in v2.0 or greator: don't show the bevel box
	if ( version >= 0x02008000 )
		dialogOptions.dialogOptionFlags += kNavSupportPackages;
		
	theErr = NavChooseObject(	NULL,
								&theReply,
								&dialogOptions,
								eventUPP,
								filterUPP,
								(NavCallBackUserData)&gDocumentList );
	
	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		// grab the target FSSpec from the AEDescList:	
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
		{
			// 'finalFSSpec' is the selected application…
		}
		
		theErr = NavDisposeReply( &theReply );
	}
	
	DisposeNavObjectFilterUPP( filterUPP );
		
	return theErr;
}


//==============================================================================
#pragma mark	• Custom Add/Remove Example •
//==============================================================================

pascal void myCustomAddRemoveEventProc(	NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
void HandleAddRemoveCustomize( NavCBRecPtr callBackParms );
void HandleAddRemoveNormalEvents( NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
void HandleAddRemoveStartEvent( NavCBRecPtr callBackParms );
void HandleAddRemoveCustomMouseDown( NavCBRecPtr callBackParms );
Boolean DoListMouseDown( NavCBRecPtr callBackParms );
void UpdateListControl( NavCBRecPtr callBackParms );
void HandleAdd( NavCBRecPtr callBackParms, AEDescList fileList );
void HandleRemove( NavCBRecPtr callBackParms );
void HandleRemoveAll( NavCBRecPtr callBackParms );
Boolean DoAddItem( unsigned char* theData, short size, NavCBRecPtr callBackParms );
Boolean DoSearch( AEDesc searchDesc );


// *****************************************************************************
// *
// *	UpdateListControl( )	
// *
// *****************************************************************************
void UpdateListControl( NavCBRecPtr callBackParms )
{
	ControlRef 	listCtl;
	UInt16 		firstItem;
	
	NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem );	// ask NavServices for our first control ID
	GetDialogItemAsControl( GetDialogFromWindow( callBackParms->window ), firstItem + iList + 1, &listCtl );
	Draw1Control( listCtl );
}
	

// *****************************************************************************
// *
// *	DoAddItem( )	
// *
// *****************************************************************************
Boolean DoAddItem( unsigned char* theData, short size, NavCBRecPtr callBackParms )
{
	if ( theData != NULL && gListItem != NULL )
	{ 
  		Cell 		theCell	= { 0, 0 };
		short  		theRow;
		
		MyP2CStr( (StringPtr)theData );
					
		if ( LGetSelect( true, &theCell, gListItem ) )		// de-select all the currently selected items
		{
			LSetSelect( false, theCell, gListItem );		// deselect the first old item
				
			theCell.v++;									// move down one cell
			
			while ( LGetSelect( true, &theCell, gListItem ) )	// find current selected item
			{
				if ( LGetSelect( true, &theCell, gListItem ) )
					LSetSelect( false, theCell, gListItem );// deselect the next old item
				theCell.v++;
			}
		}
		
		// insert data into (col 0, row x), and add the item:
		theRow = LAddRow( 1, 256, gListItem );				// insert item into the new row
		theCell.h = 0;
		theCell.v = theRow;
		LSetCell( theData, size, theCell, gListItem );
		gNumItems++;
		
		//SetThemeBackground( kThemeBrushDialogBackgroundActive, GetDeviceDepth( gd ), IsDeviceColor( gd ) );
		UpdateListControl( callBackParms );
		
		MyC2PStr( (Ptr)theData );
		
		LSetSelect( true, theCell, gListItem );				// select the newly added item		
		LAutoScroll( gListItem );							// scroll if necessary
					
		return true;
	}
	else
		return false;
}


// *****************************************************************************
// *
// *	DoSearch( )	
// *
// *****************************************************************************
Boolean DoSearch( AEDesc searchDesc )
{
	Boolean		found = false;
	FSSpec		finalSpec;
	Cell 		theCell = { 0, 0 };
	short 		theLen;
	DescType	type = typeFSS;
	
	myAEGetDescData( &searchDesc, &type, &finalSpec, sizeof( FSSpec ), NULL );
	theLen = finalSpec.name[0];
	MyP2CStr( (StringPtr)finalSpec.name );
	if ( gListItem != NULL )
		if ( LSearch( (Ptr)finalSpec.name, theLen, NULL, &theCell, gListItem ))
			found = true;
	MyC2PStr( (Ptr)finalSpec.name );

	return found;
}


// *****************************************************************************
// *
// *	HandleAdd( )	
// *
// *****************************************************************************
void HandleAdd( NavCBRecPtr callBackParms, AEDescList theSelectionList )
{
	OSErr	theErr = noErr;
	long	count = 0;
	FSSpec	finalSpec;
	UInt16 	firstItem = 0;
	Cell	beforeCell = {0,0};
	long 	index;
	Boolean	itemFound = false;
	GrafPtr savePort;
					
	GetPort( &savePort );
	SetPort( (GrafPtr)GetWindowPort( callBackParms->window ) );
	
	if ((theErr = AECountItems( &theSelectionList, &count )) == noErr)
		for ( index = 1; index <= count; index++ )
		{
			AEKeyword 	keyWord;	
			AEDesc 		theItemDesc;
			
			if ((theErr = AEGetNthDesc( &theSelectionList, index, typeFSS, &keyWord, &theItemDesc )) == noErr)
			{		
				DescType 	typeCode;
				Size 		actualSize = 0;

				if (( theErr = AEGetNthPtr( &theSelectionList, index, typeFSS, &keyWord, &typeCode, &finalSpec, sizeof( FSSpec ), &actualSize )) == noErr )
					if (!DoSearch( theItemDesc ))
					{
						if ( finalSpec.name[0] == 0 )
							// the object is a folder (name is blank), so copy the name:
							FSMakeFSSpec( finalSpec.vRefNum, finalSpec.parID, NULL, &finalSpec );
						
						DoAddItem( finalSpec.name, finalSpec.name[0], callBackParms );
						
						if (LGetSelect( true, &beforeCell, gListItem ))
						{
							// adjust the remove buttons:
							if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr)
							{
								ControlRef	itemH;
								DialogPtr	theDialog = GetDialogFromWindow( callBackParms->window );
								
								GetDialogItemAsControl( theDialog, firstItem + iRemoveButton + 1, &itemH );
								HiliteControl( itemH, 0 );
								Draw1Control( itemH );
								 
								GetDialogItemAsControl( theDialog, firstItem + iRemoveAllButton + 1, &itemH );
								HiliteControl( itemH, 0 );
								Draw1Control( itemH );
								
								GetDialogItemAsControl( theDialog, firstItem + iDoneButton + 1, &itemH );
								HiliteControl( itemH, 0 );
								Draw1Control( itemH );
							}
						}
					}
					else
						itemFound = true;
						
				AEDisposeDesc( &theItemDesc );
			}
			else
				SysBeep( 5 );	// item is not an HFS object
		}
	
	if ( itemFound )
	{
		// item(s) are already in list:
		Str255		errorStr;
		OSErr 		theErr = noErr;
		short 		itemHit = 0;
		
		GetIndString( errorStr, rAppStringsID, sAlreadyInList );
		theErr = DoStdAlert( errorStr, &itemHit );
	}
	
	SetPort( savePort );
}


// *****************************************************************************
// *
// *	HandleRemoveAll( )	
// *
// *****************************************************************************
void HandleRemoveAll( NavCBRecPtr callBackParms )
{
	OSErr	theErr = noErr;
	UInt16 	firstItem = 0;
	GrafPtr savePort;
					
	GetPort( &savePort );
	SetPort( (GrafPtr)GetWindowPort( callBackParms->window ) );
	
	if ( gListItem != NULL )
	{			
		LDelRow( 0, 0, gListItem );
		
		gNumItems = 0;
		
		// adjust the Remove Buttons
		if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr)
		{
			ControlRef	itemH;
			DialogPtr 	theDialog = GetDialogFromWindow( callBackParms->window );
			
			GetDialogItemAsControl( theDialog, firstItem + iRemoveButton + 1, &itemH );
			HiliteControl( itemH, 255 );
			Draw1Control( itemH );
			
			GetDialogItemAsControl( theDialog, firstItem + iRemoveAllButton + 1, &itemH );
			HiliteControl( itemH, 255 );
			Draw1Control( itemH );
		}
	}
	
	UpdateListControl( callBackParms );
		
	SetPort( savePort );
}


// *****************************************************************************
// *
// *	HandleRemove( )	
// *
// *****************************************************************************
void HandleRemove( NavCBRecPtr callBackParms )
{
	OSErr	theErr 	= noErr;
	Cell	theCell = {0,0};
	UInt16 	firstItem = 0;
	GrafPtr savePort;
					
	GetPort( &savePort );
	SetPort( (GrafPtr)GetWindowPort( callBackParms->window ) );
	
	if ( gListItem != NULL )
	{
		LGetSelect( true, &theCell,gListItem );			// find the first selected item
		LDelRow( 1, theCell.v, gListItem );
		gNumItems--;
					
		while (LGetSelect( true, &theCell, gListItem ))	// find next selected item
		{
			LDelRow( 1, theCell.v, gListItem );
			gNumItems--;
		}
		
		// adjust the "Remove Button":
		if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr)
		{
			ControlRef	removeH;
			
			GetDialogItemAsControl( GetDialogFromWindow( callBackParms->window ), firstItem + iRemoveButton + 1, &removeH );		
			theCell.v = 0;
			theCell.h = 0;
			LSetSelect( true, theCell, gListItem );
			if ( LGetSelect( true, &theCell, gListItem ) )	
			{
				HiliteControl( removeH, 0 );
				Draw1Control( removeH );
			}
			else
			{
				HiliteControl( removeH, 255 );
				Draw1Control( removeH );
			}
		}	
		
		UpdateListControl( callBackParms );	
	}
	
	SetPort( savePort );
}


// *****************************************************************************
// *
// *	DoListMouseDown( )	
// *
// *****************************************************************************
Boolean DoListMouseDown( NavCBRecPtr callBackParms )
{
	Cell 		whichCell={0,0}, beforeCell={0,0};
	Point 		myPt = callBackParms->eventData.eventDataParms.event->where;
	Boolean		result = true;
	ControlRef	removeH;
	UInt16 		firstItem = 0;
	OSErr		theErr = noErr;
	Boolean 	doubleClick;
	GrafPtr 	savePort;
					
	GetPort( &savePort );
	SetPort( (GrafPtr)GetWindowPort( callBackParms->window ) );
	
	GlobalToLocal( &myPt );
				
	doubleClick = LClick( myPt, callBackParms->eventData.eventDataParms.event->modifiers, gListItem );
	whichCell = LLastClick( gListItem );
	
	// adjust the "Remove Button":
	if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr)
		GetDialogItemAsControl( GetDialogFromWindow( callBackParms->window ), firstItem + iRemoveButton + 1, &removeH );
		
	if (LGetSelect( true, &beforeCell, gListItem ))
	{
		HiliteControl( removeH, 0 );
		Draw1Control( removeH );
	}
	else
	{
		HiliteControl( removeH, 255 );
		Draw1Control( removeH );
	}
	
	SetPort( savePort );
	return result;
}


// *****************************************************************************
// *
// *	HandleAddRemoveCustomMouseDown( )	
// *
// *****************************************************************************
void HandleAddRemoveCustomMouseDown( NavCBRecPtr callBackParms )
{
	OSErr			theErr = noErr;
	ControlHandle	whichControl = NULL;		
	Point 			where;	
	short			theItem = 0;	
	UInt16 			firstItem = 0;
	short			realItem = 0;
	short			partCode = 0;
	UInt32 			version = NavLibraryVersion( );
	
	// check for version 1.0, the 'itemHit' param field is not available in version 1.0:
	if ( version < 0x01108000 )
	{					
		GetMouse( &where );	// use the current mouse coordinates for proper tracking:
		theItem = FindDialogItem( GetDialogFromWindow( callBackParms->window ), where );	// get the item number of the control
	}
	else
	{
		// use the event data to obtain the mouse coordinates:
		theItem = callBackParms->eventData.itemHit - 1;	// Nav 1.1 givies us the "itemHit"
		where = callBackParms->eventData.eventDataParms.event->where;
		GlobalToLocal( &where );
	}
	
	partCode = FindControl( where, callBackParms->window, &whichControl );	// finally get the control itself
		
	// ask NavServices for the first custom control's ID:
	if ( callBackParms->context != 0 &&
		((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr))	// always check to see if the context is correct
	{		
		short 	testItem = 0;
				
		// test if the user clicked in the list:
		testItem = firstItem + iList + 1;		
	
		realItem = theItem - firstItem;		// map it to our DITL constants:
		switch ( realItem )
		{					
			case iList:
			{
				DoListMouseDown( callBackParms );
				break;
			}
			
			case iRemoveButton:
			{
				HandleRemove( callBackParms );
				break;
			}
				
			case iRemoveAllButton:
			{
				HandleRemoveAll( callBackParms );
				break;
			}
				
			case iAddAllButton:
			{
				AEDescList theList;	
				if (( theErr = NavCustomControl( callBackParms->context, kNavCtlBrowserSelectAll, NULL )) == noErr )
					if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetSelection, &theList )) == noErr )	
						HandleAdd( callBackParms, theList );
				break;
			}
			
			case iDoneButton:
			{
				theErr = NavCustomControl( callBackParms->context, kNavCtlTerminate, NULL );	
				break;
			}
		}
			
		// did the user remove the last item in the list?
		if ( realItem == iRemoveButton || realItem == iRemoveAllButton )
			if ( gNumItems == 0 )
			{
				// there are no items in our list, disable "Remove" and "Done":
				ControlRef 	itemH;
				DialogPtr 	theDialog = GetDialogFromWindow( callBackParms->window );
				
				GetDialogItemAsControl( theDialog, firstItem + iDoneButton + 1, &itemH );
				HiliteControl( itemH, 255 );
				Draw1Control( itemH );
				
				GetDialogItemAsControl( theDialog, firstItem + iRemoveAllButton + 1, &itemH );
				HiliteControl( itemH, 255 );
				Draw1Control( itemH );
			}
	}
}


// *****************************************************************************
// *
// *	HandleAddRemoveStartEvent( )	
// *
// *****************************************************************************
void HandleAddRemoveStartEvent( NavCBRecPtr callBackParms )
{
	OSErr 	theErr = noErr;
	UInt16 	firstItem = 0;	
	short	realItem = 0;
	short	itemType;
	Rect	itemRect;
	Handle	itemH;
	GrafPtr savePort;
					
	GetPort( &savePort );
	SetPort( (GrafPtr)GetWindowPort( callBackParms->window ) );
	
	// add the rest of the custom controls via the DITL resource list:
	gDitlList = GetResource( 'DITL', kAddRemoveControlListID );
	if ( gDitlList != NULL && ResError( ) == noErr )
	{
		if ((theErr = NavCustomControl( callBackParms->context, kNavCtlAddControlList, gDitlList )) == noErr )
		{
			DialogPtr theDialog = GetDialogFromWindow( callBackParms->window );
			
			// ask NavServices for our first control ID:
			if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr)
			{		
				ControlRef 	controlH;
				ControlRef 	listCtl;
				Size 		outActualSize;
							
				realItem = firstItem + iList + 1;
				GetDialogItem( GetDialogFromWindow( callBackParms->window ), realItem, &itemType, &itemH, &itemRect );

				GetDialogItemAsControl( GetDialogFromWindow( callBackParms->window ), realItem, &listCtl );
				GetControlData( listCtl, kControlEntireControl, kControlListBoxListHandleTag, sizeof( gListItem ), &gListItem, &outActualSize );
			
				if ( gListItem != NULL )
				{
					// set the list's boundary:
					Rect listBounds;
					GetControlBounds( listCtl, &listBounds );
					listBounds.right -= 15;
					SetListViewBounds( gListItem, &listBounds );
		
					gNumItems = 0;
					
					SetListSelectionFlags( gListItem, lNoNilHilite + lUseSense );						

					LSetDrawingMode( false, gListItem );
				}
						
				// disable the "Remove All Button":
				GetDialogItemAsControl( theDialog, firstItem + iRemoveAllButton + 1, &controlH );
				HiliteControl( controlH, 255 );
				Draw1Control( controlH );
						
				// disable the "Remove Button":
				GetDialogItemAsControl( theDialog, firstItem + iRemoveButton + 1, &controlH );
				HiliteControl( controlH, 255 );
				Draw1Control( controlH );
				
				// since we don't have any items in our list yet, disable "Done" until there are some: 
				GetDialogItemAsControl( theDialog, firstItem + iDoneButton + 1, &controlH );
				HiliteControl( controlH, 255 );
				Draw1Control( controlH );
			}
		}
	}
	SetPort( savePort );
}				

				
// *****************************************************************************
// *
// *	HandleAddRemoveNormalEvents( )	
// *
// *****************************************************************************
void HandleAddRemoveNormalEvents( NavCBRecPtr callBackParms, NavCallBackUserData callBackUD )
{
	WindowPtr	pWindow = (WindowPtr)callBackParms->eventData.eventDataParms.event->message;
	
	// for managing our windows:
	Document**	docList;
	Document*	theDoc = NULL;
	
	switch ( callBackParms->eventData.eventDataParms.event->what )
	{
		case mouseDown:
		{
			HandleAddRemoveCustomMouseDown( callBackParms );
			break;
		}
		
		case updateEvt:
			if ( pWindow != NULL && pWindow != callBackParms->window )
			{
				short index = 0;	
				docList = (Document**)callBackUD;
				if ( docList != NULL )
				{
					theDoc = docList[index];
					if ( theDoc != NULL )
					{
						while ( theDoc->theWindow != pWindow && docList[index] != NULL )
						{
							index++;
							theDoc = docList[index];
						}
						theDoc = docList[index];
						if ( theDoc != NULL )
							UpdateWindow( theDoc );
					}
				}
			}
			break;
	}			
}


// *****************************************************************************
// *
// *	HandleAddRemoveCustomize( )
// *
// *	In this example, it shows how to use the 'DLOG' resource in determining
// *	the needed size of the custom area.
// *
// *****************************************************************************
void HandleAddRemoveCustomize( NavCBRecPtr callBackParms )
{								
	DialogTHndl DLOG;
	short		neededHeight, neededWidth;
	
	// here are the desired dimensions for our custom area:
	DLOG = (DialogTHndl)GetResource( 'DLOG', kAddRemoveControlListID );
	neededHeight = callBackParms->customRect.top + ((**DLOG).boundsRect.bottom - (**DLOG).boundsRect.top);
	neededWidth = callBackParms->customRect.left + ((**DLOG).boundsRect.right - (**DLOG).boundsRect.left);
		
	// check to see if this is the first round of negotiations:
	if ( callBackParms->customRect.right == 0 && callBackParms->customRect.bottom == 0 )
	{
		// it is, so tell NavServices what dimensions we want:
		callBackParms->customRect.right = neededWidth;
		callBackParms->customRect.bottom = neededHeight;
	}
	else
	{
		// we are in the middle of negotiating:
		if ( gLastTryWidth != callBackParms->customRect.right )
			if ( callBackParms->customRect.right < neededWidth )	// is NavServices width too small for us?
				callBackParms->customRect.right = neededWidth;

		if ( gLastTryHeight != callBackParms->customRect.bottom )	// is NavServices height too small for us?
			if ( callBackParms->customRect.bottom < neededHeight )
				callBackParms->customRect.bottom = neededHeight;
	}
	
	// remember our last size so the next time we can re-negotiate:
	gLastTryWidth = callBackParms->customRect.right;
	gLastTryHeight = callBackParms->customRect.bottom;
}


// *****************************************************************************
// *
// *	myCustomAddRemoveEventProc( )	
// *
// *****************************************************************************
pascal void myCustomAddRemoveEventProc(	NavEventCallbackMessage callBackSelector, 
										NavCBRecPtr callBackParms, 
										NavCallBackUserData callBackUD )
{
	OSErr	theErr = noErr;

#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	UInt32 	version = NavLibraryVersion( );
	THz		saveZone;
	short 	saveResRef;

	if ( version < 0x01108000 )
	{
		// set the proper heap zone and resource file:
		saveZone = GetZone( );
		SetZone( ApplicationZone( ) );
		saveResRef = CurResFile( );
		UseResFile( gAppResRef );					
	}
#endif
		
	if ( callBackUD != 0 && callBackParms != NULL )
		switch ( callBackSelector )
		{
			case kNavCBEvent:
			{
				HandleAddRemoveNormalEvents( callBackParms, callBackUD );
				break;
			}
			
			case kNavCBCustomize:
			{
				HandleAddRemoveCustomize( callBackParms );
				break;
			}
					
			case kNavCBOpenSelection:
			{
				NavActionState 	navState = kNavDontOpenState + kNavDontChooseState;
				AEDesc* 		theDesc = (AEDesc*)callBackParms->eventData.eventDataParms.param;
				AEKeyword 		keyWord;
				DescType 		typeCode;
				Size 			actualSize = 0;
				FSSpec			finalFSSpec;
				
				// grab the first item in the selection list:
				if (( theErr = AEGetNthPtr( callBackParms->eventData.eventDataParms.param, 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
					// check if the first item is a folder:
					if ( finalFSSpec.name[0] != 0 )				// only add files, not folders
					{
						HandleAdd( callBackParms, *theDesc );	// finally add the selection to our secondary list:
					
						// tell Nav to block this kNacCBOpenSelection event:
						NavCustomControl( callBackParms->context, kNavCtlSetActionState, &navState );
					}
					else
					{
						long selDirID = 0;
						short sysVRefNum = 0;
						long sysDirID = 0;
						
						selDirID = FSpGetDirID( &finalFSSpec );
						
						// check if the user is opening the system folder:
						if ((theErr = FindFolder( -1, kSystemFolderType, false, &sysVRefNum, &sysDirID )) == noErr)
							if ( finalFSSpec.vRefNum == sysVRefNum && finalFSSpec.parID == sysDirID )
							{
								// item(s) are already in list:
								Str255	errorStr;
								OSErr 	theErr = noErr;
								short 	itemHit = 0;
								
								GetIndString( errorStr, rAppStringsID, sCantOpenSysFolder );
								theErr = DoStdAlert( errorStr, &itemHit );
		
								// tell Nav to block this kNacCBOpenSelection event:
								NavCustomControl( callBackParms->context, kNavCtlSetActionState, &navState );
							}
					}
				break;
			}
			
			case kNavCBStart:
				HandleAddRemoveStartEvent( callBackParms );
				break;
				
			case kNavCBTerminate:
				if ( gDitlList != NULL )
					ReleaseResource( gDitlList );
					
				gListItem = NULL;
				gNumItems = 0;
				break;
		}
			
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	if ( version < 0x01108000 )
	{
		UseResFile( saveResRef );
		SetZone( saveZone );
	}
#endif
}


// *****************************************************************************
// *
// *	DoCustomAddRemove()
// *
// *	This is a "primitive" example of how you would add an Add/Remove
// *	human interface to NavGetFile().
// *
// *	Also shows off how clients can block kNavCBOpenSelection.
// *	
// *****************************************************************************
OSErr DoCustomAddRemove( )
{
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr			theErr = noErr;
	long			count = 0;
	NavEventUPP		eventUPP = NewNavEventUPP( myCustomAddRemoveEventProc );
		
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );

	GetIndString( (unsigned char*)&dialogOptions.windowTitle, rAppStringsID, sAddRemoveTitle );
	GetIndString( (unsigned char*)&dialogOptions.actionButtonLabel, rAppStringsID, sAddTitle );
	
	dialogOptions.dialogOptionFlags += kNavNoTypePopup;
	
        if ( dialogOptions.dialogOptionFlags & kNavAllowPreviews )
            dialogOptions.dialogOptionFlags -= kNavAllowPreviews;
            
	dialogOptions.dialogOptionFlags += kNavDontAutoTranslate;
	
	theErr = NavGetFile(	NULL,	// use system's default location
							&theReply,
							&dialogOptions,
							eventUPP,
							NULL,	// no custom previews
							NULL,
							NULL,
							(NavCallBackUserData)&gDocumentList );

	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		// since we allow for multiple objects to be returned,
		// grab the target FSSpecs from 'theReply.fileRef' list for opening:	
		FSSpec	finalFSSpec;	
		long 	index;

		// we are ready to open the document(s), grab information about each file for opening:
		theErr = AECountItems( &(theReply.selection), &count );
		for ( index=1; index<=count; index++ )
		{
			AEKeyword 	keyWord;
			DescType 	typeCode;
			Size 		actualSize = 0;

			if (( theErr = AEGetNthPtr( &theReply.selection, index, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
			{
				//..
			}
		}
		
		theErr = NavDisposeReply( &theReply );	// clean up after ourselves	
	}
	
	return theErr;
}


//==============================================================================
#pragma mark	• Custom Open Example •
//==============================================================================

pascal void myCustomEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
void HandleCustomMouseDown( NavCBRecPtr callBackParms );

void HandleOpenSelection( NavCBRecPtr callBackParms );
void HandleNormalEvents( NavCBRecPtr callBackParms );
void HandleStartEvent( NavCBRecPtr callBackParms );
void HandleCustomizeEvent( NavCBRecPtr callBackParms );



// *****************************************************************************
// *
// *	HandleCustomMouseDown()	
// *
// *****************************************************************************
void HandleCustomMouseDown( NavCBRecPtr callBackParms )
{
	OSErr			theErr = noErr;
	ControlHandle	whichControl = NULL;			
	Point 			where;	
	short			theItem = 0;	
	UInt16 			firstItem = 0;
	short			realItem = 0;
	short			partCode = 0;
	UInt32 			version = NavLibraryVersion( );
	
	// check for version 1.0, the 'itemHit' param field is not available in version 1.0:
	if ( version < 0x01108000 )
	{					
		GetMouse( &where );	// use the current mouse coordinates for proper tracking:
		theItem = FindDialogItem( GetDialogFromWindow( callBackParms->window ), where );	// get the item number of the control
	}
	else
	{
		// use the event data to obtain the mouse coordinates:
		theItem = callBackParms->eventData.itemHit - 1;	// Nav 1.1 givies us the "itemHit"
		where = callBackParms->eventData.eventDataParms.event->where;
		GlobalToLocal( &where );
	}
	partCode = FindControl( where, callBackParms->window, &whichControl );	// finally get the control itself
	
	// ask NavServices for the first custom control's ID:
	if ( callBackParms->context != 0 )	// always check to see if the context is correct
	{
		theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem );	
		realItem = theItem - firstItem + 1;		// map it to our DITL constants:	
	}

	HandleCustomControls( callBackParms->window, callBackParms->context, whichControl, firstItem, realItem );
	if ( realItem == kAllowDismissCheck )
		gCanDismiss = GetControlValue( whichControl );	// allow the dialog to be dismissed
}


// *****************************************************************************
// *
// *	HandleOpenSelection( )	
// *
// *****************************************************************************
void HandleOpenSelection( NavCBRecPtr callBackParms )
{
	if ( !gCanDismiss )
	{
		Str255			errorStr;
		NavActionState 	navState = kNavDontOpenState + kNavDontChooseState;
		OSErr 			theErr = noErr;
		short 			itemHit = 0;
		
		GetIndString( errorStr, rAppStringsID, sCantDismissTitle );
		theErr = DoStdAlert( errorStr, &itemHit );

		// tell Nav to block this kNacCBOpenSelection event:
		NavCustomControl( callBackParms->context, kNavCtlSetActionState, &navState );
	}
}


// *****************************************************************************
// *
// *	HandleNormalEvents( )	
// *
// *****************************************************************************
void HandleNormalEvents( NavCBRecPtr callBackParms )
{
	switch( callBackParms->eventData.eventDataParms.event->what )
	{
		case mouseDown:
		{
			HandleCustomMouseDown( callBackParms );
			break;
		}
		
		case updateEvt:
		{
			Document* theDocument = NULL;
			WindowRef pWindow = (WindowPtr)callBackParms->eventData.eventDataParms.event->message;
            
            theDocument = IsDocumentWindow( pWindow );
            if ( theDocument != NULL )
           		UpdateWindow( theDocument );
			break;
		}
	}
}


// *****************************************************************************
// *
// *	HandleStartEvent( )	
// *
// *****************************************************************************
void HandleStartEvent( NavCBRecPtr callBackParms )
{
	OSErr	theErr = noErr;
	UInt16 	firstItem = 0;	
	UInt16 	itemToSelect = 0;
	UInt32 	version = NavLibraryVersion( );
	
	// add the rest of the custom controls via the DITL resource list:
	if ( version >= 0x02008000 )
		gDitlList = GetResource( 'DITL', kControlListID );	// for Nav versions less than 2.0, use the "inset" version of these controls
	else
		gDitlList = GetResource( 'DITL', kControlListIDInset );	// for Nav versions 2.0 or greator, use the "non-inset" version
			
	if ( gDitlList != NULL && ResError( ) == noErr )
	{
		if ((theErr = NavCustomControl( callBackParms->context, kNavCtlAddControlList, gDitlList )) == noErr)
		{
			// ask NavServices for our first control ID:
			if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem )) == noErr)	
			{
				ControlRef itemH;
				
				// set the command popup selection:
				if ( firstItem + kPopupCommand > 0 )
				{	
					MenuHandle 	popupMenu = NULL;
					Size 		outSize = 0;
					
					GetDialogItemAsControl( GetDialogFromWindow( callBackParms->window ), firstItem + kPopupCommand, &itemH );
					GetControlData( itemH, kControlEntireControl, kControlPopupButtonMenuHandleTag, sizeof( MenuHandle ), (Ptr)&popupMenu, &outSize );
					if ( popupMenu != NULL )
					{
						InsertMenu( popupMenu, -1 );
						
						// disable some of the menu item commands that won't be used in this example:
						SetItemEnable( popupMenu, kNavCtlSortBy + 1, false );
						SetItemEnable( popupMenu, kNavCtlSortOrder + 1, false );
						SetItemEnable( popupMenu, kNavCtlGetLocation + 1, false );
						SetItemEnable( popupMenu, kNavCtlSetLocation + 1, false );
						SetItemEnable( popupMenu, kNavCtlGetSelection + 1, false );
						SetItemEnable( popupMenu, kNavCtlSetSelection + 1, false );
						SetItemEnable( popupMenu, kNavCtlEjectVolume + 1, false );
						SetItemEnable( popupMenu, kNavCtlIsPreviewShowing + 1, false );
						SetItemEnable( popupMenu, kNavCtlAddControl + 1, false );
						SetItemEnable( popupMenu, kNavCtlAddControlList + 1, false );
						SetItemEnable( popupMenu, kNavCtlGetFirstControlID + 1, false );
						SetItemEnable( popupMenu, kNavCtlSelectCustomType + 1, false );
						SetItemEnable( popupMenu, kNavCtlSelectAllType + 1, false );
						SetItemEnable( popupMenu, kNavCtlGetEditFileName + 1, false );
						SetItemEnable( popupMenu, kNavCtlSetEditFileName + 1, false );
						SetItemEnable( popupMenu, kNavCtlSelectEditFileName + 1, false );
						SetItemEnable( popupMenu, kNavCtlSetActionState + 1, false );
					
						SetControlValue( itemH, 1 );
					}
				}
				
				GetDialogItemAsControl( GetDialogFromWindow( callBackParms->window ), firstItem + kRadioOneItem, &itemH );
				SetControlValue( itemH, true );
				
				RightJustifyPict( callBackParms );
			}
		}
	}
			
	gCanDismiss = false;
	
	// the dialog is starting up, let's override the default popup menu selection:
	itemToSelect = kNavAllReadableFiles;
	theErr = NavCustomControl( callBackParms->context, kNavCtlSelectAllType, &itemToSelect );
}


// *****************************************************************************
// *
// *	HandleCustomizeEvent( )	
// *
// *****************************************************************************
void HandleCustomizeEvent( NavCBRecPtr callBackParms )
{							
	DialogTHndl DLOG;
	short		neededHeight, neededWidth;
	UInt32 		version = NavLibraryVersion( );
	
	// here are the desired dimensions for our custom area:
	if ( version >= 0x02008000 )
		DLOG = (DialogTHndl)GetResource( 'DLOG', kControlListID );
	else
		DLOG = (DialogTHndl)GetResource( 'DLOG', kControlListIDInset );
		
	neededHeight = callBackParms->customRect.top + ((**DLOG).boundsRect.bottom - (**DLOG).boundsRect.top);
	neededWidth = callBackParms->customRect.left + ((**DLOG).boundsRect.right - (**DLOG).boundsRect.left);
	
	// check to see if this is the first round of negotiations:
	if ( callBackParms->customRect.right == 0 && callBackParms->customRect.bottom == 0 )
	{
		// it is, so tell NavServices what dimensions we want:
		callBackParms->customRect.right = neededWidth;
		callBackParms->customRect.bottom = neededHeight;
	}
	else
	{
		// we are in the middle of negotiating:
		if ( gLastTryWidth != callBackParms->customRect.right )
			if ( callBackParms->customRect.right < neededWidth )	// is NavServices width too small for us?
				callBackParms->customRect.right = neededWidth;

		if ( gLastTryHeight != callBackParms->customRect.bottom )	// is NavServices height too small for us?
			if ( callBackParms->customRect.bottom < neededHeight )
				callBackParms->customRect.bottom = neededHeight;
	}
	
	// remember our last size so the next time we can re-negotiate:
	gLastTryWidth = callBackParms->customRect.right;
	gLastTryHeight = callBackParms->customRect.bottom;
}


// *****************************************************************************
// *
// *	myCustomEventProc( )	
// *
// *****************************************************************************
pascal void myCustomEventProc(	NavEventCallbackMessage callBackSelector, 
								NavCBRecPtr callBackParms, 
								NavCallBackUserData callBackUD )
{
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	UInt32 	version = NavLibraryVersion( );
	THz		saveZone;
	short 	saveResRef;

	if ( version < 0x01108000 )
	{
		// set the proper heap zone and resource file:
		saveZone = GetZone( );
		SetZone( ApplicationZone( ) );
		saveResRef = CurResFile( );
		UseResFile( gAppResRef );					
	}
#endif

	if ( callBackUD != 0 && callBackParms != NULL )
		switch ( callBackSelector )
		{
			case kNavCBEvent:
				HandleNormalEvents( callBackParms );
				break;
	
			case kNavCBCustomize:
				HandleCustomizeEvent( callBackParms );
				break;
				
			case kNavCBOpenSelection:
				HandleOpenSelection( callBackParms );
				break;
			
			case kNavCBStart:
				HandleStartEvent( callBackParms );
				break;
				
			case kNavCBTerminate:
				// release our appended popup menu:
				if ( gDitlList )
					ReleaseResource( gDitlList );
				break;
				
			case kNavCBAdjustRect:
				RightJustifyPict( callBackParms );
				break;
		}
			
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	if ( version < 0x01108000 )
	{
		UseResFile( saveResRef );
		SetZone( saveZone );
	}
#endif
}


// *****************************************************************************
// *
// *	DoCustomOpen( )
// *
// *	This illustrates a simple customized NavGetFile dialog.
// *	Features:
// *		Can block dismissal/defaul button use
// *	
// *****************************************************************************
OSErr DoCustomOpen( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	long				count = 0;
	NavEventUPP			eventUPP = NewNavEventUPP( myCustomEventProc );
	UInt32 				version = NavLibraryVersion( );
	
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
		
	// this feature only available in v2.0 or greator: don't show the bevel box
	if ( version >= 0x02008000 )
		dialogOptions.dialogOptionFlags += kNavDontUseCustomFrame;
	
	dialogOptions.dialogOptionFlags -= kNavAllowPreviews;
            
	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );
	
	gCanDismiss = true;
	
	theErr = NavGetFile(	NULL,	// use system's default location
							&theReply,
							&dialogOptions,
							eventUPP,
							NULL,	// no custom previews
							NULL,
							NULL,
							(NavCallBackUserData)&gDocumentList );

	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		// since we allow for multiple objects to be returned,
		// grab the target FSSpecs from 'theReply.fileRef' list for opening:	
		FSSpec	finalFSSpec;	
		FInfo	fileInfo;
		long 	index;
		
		// we are ready to open the document(s), grab information about each file for opening:
		theErr = AECountItems( &(theReply.selection), &count );
		for ( index=1; index<=count; index++ )
		{
			AEKeyword 	keyWord;
			DescType 	typeCode;
			Size 		actualSize = 0;

			if (( theErr = AEGetNthPtr( &theReply.selection, index, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
				// decide if the doc we are opening is a 'PICT' or 'TEXT':
				if ( (theErr = FSpGetFInfo( &finalFSSpec, &fileInfo )) == noErr )
				{
					if ( fileInfo.fdType == kFileType )
						(void)DoOpenFile( &finalFSSpec, false );
					else
						if ( fileInfo.fdType == kFileTypePICT )
							(void)DoOpenFile( &finalFSSpec, true );
						else
						{
							// error:
							// if we got this far, the document is a type we can't open and
							// (most likely) built-in translation was turned off.
							// You can alert the user that this returned selection or file spec
							// needs translation.
						}
				}
		}
		
		theErr = NavDisposeReply( &theReply );	// clean up after ourselves	
	}

	return theErr;
}


//==============================================================================
#pragma mark	• Customize Partial/Full Show Popup Example •
//==============================================================================

pascal Boolean myCustomShowFilterProc(AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode );
pascal void myCustomShowEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
void ExtendShowPopup( Handle popupExtension );
void HandleShowPopupMenuSelect( NavCBRecPtr callBackParms );


// *****************************************************************************
// *
// *	myCustomShowFilterProc( )
// *
// *****************************************************************************
pascal Boolean myCustomShowFilterProc(AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode )
{
#pragma unused( callBackUD, filterMode )

	Boolean 				display = true;
	NavFileOrFolderInfo* 	theInfo = (NavFileOrFolderInfo*)info;
	
	if ( theItem->descriptorType == typeFSS )
		if ( !theInfo->isFolder )
			if ( gCurrentType != 0 )	// has the user selected our custom popup menu item?
				if ( theInfo->fileAndFolder.fileInfo.finderInfo.fdType != gCurrentType )
					display = false;
	return display;
}



// *****************************************************************************
// *
// *	HandleShowPopupMenuSelect( )
// *	
// *****************************************************************************
void HandleShowPopupMenuSelect( NavCBRecPtr callBackParms )
{
	if ( callBackParms != NULL )
	{
		NavMenuItemSpec menuItemSpec = *(NavMenuItemSpec*)callBackParms->eventData.eventDataParms.param;
		
		// sound off this event:
		if (menuItemSpec.menuType == kCustomType1 && menuItemSpec.menuCreator == kFileCreator )
			gCurrentType = kCustomType1;			
		else
			if (menuItemSpec.menuType == kCustomType2 && menuItemSpec.menuCreator == kFileCreator )
				gCurrentType = kCustomType2;
			else
				if (menuItemSpec.menuType == kCustomType3 && menuItemSpec.menuCreator == kFileCreator )
					gCurrentType = kCustomType3;
				else
					gCurrentType = 0;	// no custom menu selected		
	}
}


// *****************************************************************************
// *
// *	myCustomShowEventProc( )	
// *
// *****************************************************************************
pascal void myCustomShowEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD )
{
	OSErr 	theErr = noErr;
		
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	UInt32 	version = NavLibraryVersion( );
	THz		saveZone;
	short 	saveResRef;
	 
	if ( version < 0x01108000 )
	{
		// set the proper heap zone and resource file:
		saveZone = GetZone( );
		SetZone( ApplicationZone( ) );
		saveResRef = CurResFile( );
		UseResFile( gAppResRef );					
	}
#endif

	if ( callBackUD != 0 && callBackParms != NULL )
		switch ( callBackSelector )
		{
			case kNavCBStart:
			{
				// the dialog is starting up, let's override the default popup menu selection
				// by selecting our third custom item:
				NavMenuItemSpec menuItem;				
				Str255 			testItemName;
				
				GetIndString( testItemName, rAppStringsID, sCustomMenuTitle3 );
				BlockMoveData( testItemName, menuItem.menuItemName, testItemName[0] + 1 );
				menuItem.menuType = kCustomType3;
				menuItem.menuCreator = kFileCreator;
				menuItem.version = kNavMenuItemSpecVersion;
		
				theErr = NavCustomControl( callBackParms->context, kNavCtlSelectCustomType, &menuItem );
				break;
			}
				
			case kNavCBEvent:
				HandleNormalEvents( callBackParms );
				break;
	
			case kNavCBPopupMenuSelect:
				HandleShowPopupMenuSelect( callBackParms );
				break;
		}
			
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	if ( version < 0x01108000 )
	{
		UseResFile( saveResRef );
		SetZone( saveZone );
	}
#endif
}


// *****************************************************************************
// *
// *	ExtendShowPopup( )	
// *
// *****************************************************************************
void ExtendShowPopup( Handle popupExtension )		
{
	if ( popupExtension != NULL )
	{
		// custom menu items:
		Str255				menuTitle;
		NavMenuItemSpec 	menuItem;		
		
		menuItem.version = kNavMenuItemSpecVersion;
		
		GetIndString( menuTitle, rAppStringsID, sCustomMenuTitle1 );
		BlockMoveData( menuTitle, menuItem.menuItemName, menuTitle[0]+1 );
		menuItem.menuType = kCustomType1;
		menuItem.menuCreator = kFileCreator;
		BlockMoveData( &menuItem, *popupExtension, sizeof( NavMenuItemSpec ) );
		
		GetIndString( menuTitle, rAppStringsID, sCustomMenuTitle2 );
		BlockMoveData( menuTitle, menuItem.menuItemName, menuTitle[0]+1 );
		menuItem.menuType = kCustomType2;
		menuItem.menuCreator = kFileCreator;
		BlockMoveData( &menuItem, *popupExtension + sizeof( NavMenuItemSpec ), sizeof( NavMenuItemSpec ) );
		
		GetIndString( menuTitle, rAppStringsID, sCustomMenuTitle3 );
		BlockMoveData( menuTitle, menuItem.menuItemName, menuTitle[0]+1 );
		menuItem.menuType = kCustomType3;
		menuItem.menuCreator = kFileCreator;
		BlockMoveData( &menuItem,*popupExtension + sizeof( NavMenuItemSpec ) + sizeof( NavMenuItemSpec ), sizeof( NavMenuItemSpec ) );
	}
}


// ********************************************************************************
// *
// *	DoCustomShow( )
// *
// *	This illustrates how to customize 100% of the NavGetFile's Show popupmenu.
// *	
// ********************************************************************************
OSErr DoCustomShow( Boolean partialCustomize )
{	
	OSErr				theErr = noErr;
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	NavTypeListHandle	openList = NULL;
	NavTypeListHandle	typeList = NULL;
	NavEventUPP			eventUPP = NewNavEventUPP( myCustomShowEventProc );
	NavObjectFilterUPP	filterUPP = NewNavObjectFilterUPP( myCustomShowFilterProc );
	
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	// for the partial custom example, use a NavTypeList and show "All Documents":
	if ( partialCustomize )	
	{
		dialogOptions.dialogOptionFlags += kNavAllFilesInPopup;
                
                if ( dialogOptions.dialogOptionFlags & kNavDontAddTranslateItems )
                    dialogOptions.dialogOptionFlags -= kNavDontAddTranslateItems;
                    
		openList = (NavTypeListHandle)GetResource( kOpenRsrcType, kOpenRsrcID );
		gFullCustomPopup = false;
	}
	else
		gFullCustomPopup = true;
	
	// override the app name:
	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );
	GetIndString( dialogOptions.message, rAppStringsID, sCustomShowPrompt );
	
	// setup our 3 custom menu items to be added to "show" popup:
	dialogOptions.popupExtension = (NavMenuItemSpecArrayHandle)NewHandleClear( sizeof( NavMenuItemSpec ) * 3 );	

	// customize the show popup:
	ExtendShowPopup( (Handle)dialogOptions.popupExtension );

	theErr = NavGetFile(	NULL,		// no default location
							&theReply,
							&dialogOptions,
							eventUPP,
							NULL,		// no custom previews
							filterUPP,
							openList,
							(NavCallBackUserData)&gDocumentList );

	DisposeNavEventUPP( eventUPP );
	DisposeNavObjectFilterUPP( filterUPP );

	if ( dialogOptions.popupExtension != NULL )
		DisposeHandle( (Handle)dialogOptions.popupExtension );
		
	if ( theReply.validRecord && theErr == noErr )
	{
		//..
		theErr = NavDisposeReply( &theReply );	// clean up after ourselves	
	}

	if ( typeList != NULL )
		ReleaseResource( (Handle)typeList );
	if ( openList != NULL )
		ReleaseResource( (Handle)openList );
			
	return theErr;
}


//==============================================================================
#pragma mark	• Custom Partial/Full Format Popup Example •
//==============================================================================

OSErr DoCustomFormat( Boolean partialCustomize )
{	
	OSErr				theErr = noErr;
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSType				signature;
	NavEventUPP			eventUPP = NewNavEventUPP( myCustomShowEventProc );
		
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );

	if ( partialCustomize )
	{
		if ( dialogOptions.dialogOptionFlags & kNavDontAddTranslateItems )
                    dialogOptions.dialogOptionFlags -= kNavDontAddTranslateItems;	// show translation options
		signature = kFileCreator;
		gFullCustomPopup = false;
	}
	else
	{
		if ( dialogOptions.dialogOptionFlags & kNavAllowStationery )
                    dialogOptions.dialogOptionFlags -= kNavAllowStationery;	// remove Stationery option
		signature = kNavGenericSignature;	// a wildcard '****' signature will avoid adding Nav menu items
		gFullCustomPopup = true;
	}
	
	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );
	GetIndString( dialogOptions.message, rAppStringsID, sCustomFormatPrompt );
	GetIndString( (unsigned char*)&dialogOptions.savedFileName, rAppStringsID, sUntitled );
	
	// setup our 3 custom menu items to be added to "format" popup:
	dialogOptions.popupExtension = (NavMenuItemSpecArrayHandle)NewHandleClear( sizeof( NavMenuItemSpec ) * 3 );	

	// customize the show popup:
	ExtendShowPopup( (Handle)dialogOptions.popupExtension );
	
	theErr = NavPutFile( 	NULL,		// use system's default location
							&theReply,
							&dialogOptions,
							eventUPP,
							kFileType,	// 'TEXT'
							signature,	// 'CPAP'
							(NavCallBackUserData)&gDocumentList );

	DisposeNavEventUPP( eventUPP );

	if ( dialogOptions.popupExtension != NULL )
		DisposeHandle( (Handle)dialogOptions.popupExtension );
		
	if ( theReply.validRecord && theErr == noErr )
	{
		//..
		theErr = NavDisposeReply( &theReply );
	}
	
	return theErr;
}



//==============================================================================
#pragma mark	• New File example •
//==============================================================================

// this dialog is used offscreen when using a Nav dialog on top of another Nav dialog
DialogPtr gTempDialog = NULL;

void HandleNewFileExample( void );
void HandleNewFileStartEvent( NavCBRecPtr callBackParms );
void HandleNewFileMouseDown( NavCBRecPtr callBackParms );
void HandleNewFileNormalEvents( NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
pascal void myNewFileEventProc(	NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );
pascal void mySpecialEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD );


// *****************************************************************************
// *
// *	mySpecialEventProc( )
// *
// *	This eventProc is used when opening a Nav dialog on top of another
// *	Nav dialog.
// *	
// *****************************************************************************
pascal void mySpecialEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD )
{
#pragma unused( callBackUD )

	WindowPtr pWindow = NULL;
	
	if ( callBackParms != NULL )
	{
		switch( callBackSelector )
		{
			case kNavCBEvent:
				switch ( callBackParms->eventData.eventDataParms.event->what )
				{
					case updateEvt:
					{
						Document* theDocument = NULL;
						pWindow = (WindowPtr)callBackParms->eventData.eventDataParms.event->message;
						theDocument = IsDocumentWindow( pWindow );
	           			if ( theDocument != NULL )
	            			UpdateWindow( theDocument );
					}
				}
				break;
				
			case kNavCBTerminate:
			{
				DisposeDialog( gTempDialog );
				gTempDialog = NULL;
				break;
			}
		}
	}		
}


// *****************************************************************************
// *
// *	DoNewFileExample( )	
// *
// *****************************************************************************
void HandleNewFileExample( )
{
	BitMap 	screenBits;
	Rect 	windBounds;
	
	GetQDGlobalsScreenBits( &screenBits );
			
	// create a window offscreen to force-generate an activate event for the current Nav dialog:
	
	SetRect( &windBounds, screenBits.bounds.right + 10, screenBits.bounds.top, screenBits.bounds.right + 40, screenBits.bounds.top + 40 );
	gTempDialog = NewDialog( NULL, &windBounds, "\p", true, noGrowDocProc, (WindowPtr)-1, true, 0, NULL );
	SelectWindow( GetDialogWindow(gTempDialog) );
}


// *****************************************************************************
// *
// *	HandleNewFileStartEvent( )	
// *
// *****************************************************************************
void HandleNewFileStartEvent( NavCBRecPtr callBackParms )
{
	OSErr	theErr = noErr;
	UInt32 	version = NavLibraryVersion( );
	
	// add the rest of the custom controls via the DITL resource list:
	if ( version >= 0x02008000 )
		gDitlList = GetResource( 'DITL', kNewFileListID );	// for Nav versions less than 2.0, use the "inset" version of these controls
	else
		gDitlList = GetResource( 'DITL', kNewFileListIDInset );	// for Nav versions 2.0 or greator, use the "non-inset" version
			
	if ( gDitlList != NULL && ResError( ) == noErr )
		theErr = NavCustomControl( callBackParms->context, kNavCtlAddControlList, gDitlList );
}


// *****************************************************************************
// *
// *	HandleNewFileMouseDown( )	
// *
// *****************************************************************************
void HandleNewFileMouseDown( NavCBRecPtr callBackParms )
{
	OSErr			theErr = noErr;
	ControlHandle	whichControl = NULL;			
	Point 			where;	
	short			theItem = 0;	
	UInt16 			firstItem = 0;
	short			realItem = 0;
	short			partCode = 0;
	UInt32 			version = NavLibraryVersion( );
	
	// check for version 1.0, the 'itemHit' param field is not available in version 1.0:
	if ( version < 0x01108000 )
	{					
		GetMouse( &where );	// use the current mouse coordinates for proper tracking:
		theItem = FindDialogItem( GetDialogFromWindow( callBackParms->window ), where );	// get the item number of the control
	}
	else
	{
		// use the event data to obtain the mouse coordinates:
		theItem = callBackParms->eventData.itemHit - 1;	// Nav 1.1 givies us the "itemHit"
		where = callBackParms->eventData.eventDataParms.event->where;
		GlobalToLocal( &where );
	}
	partCode = FindControl( where, callBackParms->window, &whichControl );	// finally get the control itself
	
	// ask NavServices for the first custom control's ID:
	if ( callBackParms->context != 0 )	// always check to see if the context is correct
	{
		theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstItem );	
		realItem = theItem - firstItem + 1;		// map it to our DITL constants:	
	}

	if ( whichControl != NULL && theErr == noErr )
		switch ( realItem )
		{
			case kNewFileButton:
				HandleNewFileExample( );
				break;
		}
}


// *****************************************************************************
// *
// *	HandleNewFileNormalEvents( )	
// *
// *****************************************************************************
void HandleNewFileNormalEvents( NavCBRecPtr callBackParms, NavCallBackUserData callBackUD )
{
	Document**	docList;
	WindowPtr	pWindow = NULL;
	
	docList = (Document**)callBackUD;
	if ( docList != NULL )
		switch ( callBackParms->eventData.eventDataParms.event->what )
		{
			case mouseDown:
				HandleNewFileMouseDown( callBackParms );
				break;
			
			case updateEvt:
			{
				Document* theDocument = NULL;
               	pWindow = (WindowPtr)callBackParms->eventData.eventDataParms.event->message;
                theDocument = IsDocumentWindow( pWindow );
                if ( theDocument != NULL )
               		if ( theDocument != NULL )
                		UpdateWindow( theDocument );
				break;
			}
			
			case activateEvt:
			{
				// check if the current event's window is the current Nav dialog:
				WindowRef theWindow = (WindowRef)callBackParms->eventData.eventDataParms.event->message;
				if ( theWindow == callBackParms->window )		
				{
					if ( gTempDialog != NULL )	// did we create our offscreen window?
					{
						OSErr				theErr = noErr;
						NavReplyRecord 		reply;
						NavDialogOptions 	options;
						NavEventUPP 		eventProc = NULL;	
							
						if ((theErr = NavGetDefaultDialogOptions( &options )) == noErr)
						{	
							eventProc = NewNavEventUPP( mySpecialEventProc );	
						
							GetIndString( (unsigned char*)&options.savedFileName, rAppStringsID, sUntitled );
							GetIndString( (unsigned char*)&options.clientName, rAppStringsID, sApplicationName );
							options.dialogOptionFlags += kNavNoTypePopup;	// we don't want the format popup
							
							options.preferenceKey = TickCount( );	// this is important!
																	// this forces a set of new preferences for the following
																	// NavPutFile, we don't want to share one set of prefs  
																	// between two NavPutFile dialogs within this application
							
							theErr = NavPutFile( NULL, &reply, &options, eventProc, kFileType, kFileCreator, (NavCallBackUserData)&gDocumentList );
							//or theErr = NavGetFile( NULL, &reply, &options, eventProc, NULL, NULL, NULL, (NavCallBackUserData)&gDocumentList );
							theErr = NavDisposeReply( &reply );					
							DisposeNavEventUPP( eventProc );
						}
					}
				}
			}
						
			default:
				break;
		}
}


// *****************************************************************************
// *
// *	myNewFileEventProc( )	
// *
// *****************************************************************************
pascal void myNewFileEventProc(	NavEventCallbackMessage callBackSelector, 
                                NavCBRecPtr callBackParms, 
                                NavCallBackUserData callBackUD )
{
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	UInt32 	version = NavLibraryVersion( );
	THz		saveZone;
	short 	saveResRef;

	if ( version < 0x01108000 )
	{
		// set the proper heap zone and resource file:
		saveZone = GetZone( );
		SetZone( ApplicationZone( ) );
		saveResRef = CurResFile( );
		UseResFile( gAppResRef );					
	}
#endif

	if ( callBackUD != 0 && callBackParms != NULL )
		switch ( callBackSelector )
		{
			case kNavCBEvent:
				HandleNewFileNormalEvents( callBackParms, callBackUD );
				break;
	
			case kNavCBCustomize:
				HandleCustomizeEvent( callBackParms );
				break;
			
			case kNavCBStart:
				HandleNewFileStartEvent( callBackParms );
				break;
				
			case kNavCBTerminate:
				// release our appended popup menu:
				if ( gDitlList )
					ReleaseResource( gDitlList );
				break;
		}
			
#if !TARGET_API_MAC_CARBON	// GetZone/SetZone not in Carbon
	if ( version < 0x01108000 )
	{
		UseResFile( saveResRef );
		SetZone( saveZone );
	}
#endif
}


// *****************************************************************************
// *
// *	DoNewFileExample( )
// *
// *****************************************************************************
OSErr DoNewFileExample( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavEventUPP			eventUPP = NewNavEventUPP( myNewFileEventProc );
	UInt32 				version = NavLibraryVersion( );
	
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );
	
	// this feature only available in v2.0 or greator: don't show the bevel box
	if ( version >= 0x02008000 )
		dialogOptions.dialogOptionFlags += kNavDontUseCustomFrame;
		
	if ( dialogOptions.dialogOptionFlags & kNavAllowPreviews )
            dialogOptions.dialogOptionFlags -= kNavAllowPreviews;	// we don't want previews for this example
	
	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );
	
	theErr = NavGetFile(	NULL,	// use system's default location
							&theReply,
							&dialogOptions,
							eventUPP,
							NULL,	// no custom previews
							NULL,
							NULL,
							(NavCallBackUserData)&gDocumentList );
							
	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		//..		
		theErr = NavDisposeReply( &theReply );	// clean up after ourselves	
	}

	return theErr;
}