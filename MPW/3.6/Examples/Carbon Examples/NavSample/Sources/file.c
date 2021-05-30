/*
	File:		file.c

	Contains:	NavSample's code for saving text and picture documents

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

#ifdef TARGET_API_MAC_OS8
#include <StandardFile.h>
#endif

#ifndef Common_Defs
#include "Common.h"
#endif

#ifdef __MRC__
#include <Resources.h>
#include <Sound.h>
#endif	// __MRC__

#ifndef __DOCUMENT__
#include "document.h"
#endif

#include "file.h"

const long kPictHeaderSize = 512;

extern Document* 	gDocumentList[kMaxDocumentCount];
extern Boolean 		gNavServicesExists;


// prototypes:
short ReadFile( Document* theDocument );
short WriteFile( Document* theDocument );
short WriteNewFile( Document* theDocument, FSSpec* newFileSpec );
short DoSaveAsDocument( Document* theDocument );

void DoWriteAlert( OSErr err );
void DoReadAlert( void );

OSErr DoFSRefSave( Document* theDocument, NavReplyRecord* reply );
OSErr DoFSSpecSave( Document* theDocument, NavReplyRecord* reply );


#if !TARGET_API_MAC_CARBON
	// we want to have StdFile as an option in case Nav is not avail:
	short DoSaveAsDocumentOldWay( Document* theDocument );
	OSErr DoOpenDocumentTheOldWay( void );
#endif


// *****************************************************************************
// *
// * 	DoWriteAlert( )
// *
// *****************************************************************************
void DoWriteAlert( OSErr err )
{
	Str255 errorStr;
	if ( err == dskFulErr )
		GetIndString( errorStr, rAppStringsID, sDiskFullErr );
	else
	{
		if ( err == fBsyErr )
			GetIndString( errorStr, rAppStringsID, sWriteToBusyFileErr );
		else
			GetIndString( errorStr, rAppStringsID, sWriteErr );
	}
		
	ParamText( (ConstStr255Param)&errorStr, (ConstStr255Param)"\p", (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
	NoteAlert( rGenericAlertID, 0L );
}


// *****************************************************************************
// *
// * 	DoReadAlert( )
// *
// *****************************************************************************
void DoReadAlert( )
{
	Str255 errorStr;
	GetIndString( errorStr, rAppStringsID, sReadErr );
	ParamText( (ConstStr255Param)&errorStr, (ConstStr255Param)"\p", (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
	NoteAlert( rGenericAlertID, 0L );
}


// *****************************************************************************
// *
// * 	DoFSRefSave( )
// *
// *****************************************************************************
OSErr DoFSRefSave( Document* theDocument, NavReplyRecord* reply )
{
	OSErr 	err = noErr;
	FSRef 	fileRefParent;
   	AEDesc	actualDesc;
   		
	if ((err = AECoerceDesc( &reply->selection, typeFSRef, &actualDesc )) == noErr)
	{
		if ((err = AEGetDescData( &actualDesc, &fileRefParent, sizeof( FSRef ) )) == noErr )
		{
			// get the name data and its length:	
			HFSUniStr255	nameBuffer;
			UniCharCount 	sourceLength = 0;
			
			sourceLength = (UniCharCount)CFStringGetLength( reply->saveFileName );
			
			CFStringGetCharacters( reply->saveFileName, CFRangeMake( 0, sourceLength ), (UniChar*)&nameBuffer.unicode );
			
			if ( sourceLength > 0 )
			{	
				if ( reply->replacing )
				{
					// delete the file we are replacing:
					FSRef fileToDelete;
			       	if ((err = FSMakeFSRefUnicode( &fileRefParent, sourceLength, nameBuffer.unicode, kTextEncodingUnicodeDefault, &fileToDelete )) == noErr )
			        {
			        	err = FSDeleteObject( &fileToDelete );
			        	if ( err == fBsyErr )
							DoReadAlert( );
					}
				}
				
				if ( err == noErr )
				{
					// create the file based on Unicode, but we can write the file's data with an FSSpec:
					FSSpec newFileSpec;
		
					// get the FSSpec back so we can write the file's data
					if ((err = FSCreateFileUnicode( 	&fileRefParent,
														sourceLength,
														nameBuffer.unicode,
			                                 			kFSCatInfoNone,
			                                 			NULL,
			                                 			NULL,	
			                                 			&newFileSpec )) == noErr)
					{
						// now that we have the FSSpec, we can proceed with the save operation:
						FInfo fileInfo;
						if (( err = FSpGetFInfo( &newFileSpec, &fileInfo )) == noErr )
						{	
							if ( theDocument->theTE != NULL )	// which document type is it?
								fileInfo.fdType = kFileType;
							else
								fileInfo.fdType = kFileTypePICT;
							fileInfo.fdCreator = kFileCreator;
							
							if (( err = FSpSetFInfo( &newFileSpec, &fileInfo )) == noErr )
							{
								if (( err = WriteNewFile( theDocument, &newFileSpec )) == noErr )
									err = NavCompleteSave( reply, kNavTranslateInPlace );
								else
								{
									// an error ocurred saving the file, so delete the copy left over:
									err = FSpDelete( &newFileSpec );
									DoWriteAlert( err );
								}
									
							}
						}
					}
				}
			}
		}
		AEDisposeDesc( &actualDesc );
	}
				
	return err;
}


// *****************************************************************************
// *
// * 	DoFSSpecSave( )
// *
// *****************************************************************************
OSErr DoFSSpecSave( Document* theDocument, NavReplyRecord* reply )
{
	OSErr 	err = noErr;
	AEDesc	actualDesc;
	
	if ((err = AECoerceDesc( &reply->selection, typeFSS, &actualDesc )) == noErr)
	{	
  		FSSpec fileSpec;
 		if ((err = AEGetDescData( &actualDesc, &fileSpec, sizeof( FSSpec ) )) == noErr )
 		{
   			OSType 		fileTypeToSave;
			CFStringRef fileName = NULL;
			
			if ( theDocument->theTE != NULL )	// which document type is it?
				fileTypeToSave = kFileType;
			else
				fileTypeToSave = kFileTypePICT;
			
			fileName = NavDialogGetSaveFileName( theDocument->fNavigationDialog );
	  		if ( fileName != NULL )
	  		{
	  			err = CFStringGetPascalString( fileName, &fileSpec.name[0], sizeof( fileSpec.name ), CFStringGetSystemEncoding( ) );
	  			if ((err = FSpCreate( &fileSpec, kFileCreator, fileTypeToSave, smSystemScript )) == noErr )
				{
					if ((err = WriteNewFile( theDocument, &fileSpec )) == noErr )
						err = NavCompleteSave( reply, kNavTranslateInPlace );
					else
					{
						// an error ocurred saving the file, so delete the copy left over:
						err = FSpDelete( &fileSpec );
						DoWriteAlert( err );
					}
				}	
				CFRelease( fileName );
			}	
		}
		AEDisposeDesc( &actualDesc );
	}
	
	return err;
}


#if TARGET_API_MAC_CARBON
// *****************************************************************************
// *
// * 	DoModernSaveCopy( )
// *
// * 	Used after calling the modern save dialog "NavCreatePutFileDialog"
// *
// *	Note regarding Mac OS 9.x and Mac OS X compatibility -
// *
// *	In order for this sample app to work on both 9.x and X, we need to take
// *	into account that the returned selection data from NavCreatePutFileDialog()
// *	can return an FSRef-based object for Mac OS X, or an FSSpec-based object
// *	for Mac OS 9.x.
// *
// *	We can test this notion by coercing the selection field in the NavReplyRecord
// *	as an FSRef or an FSSpec.
// *	1) If the corecion works for FSRef, then we proceed to use the FSRef and
// *		call the HFS+ API to save the file.
// *	2) If the coercion works for FSSpec, then we save the file based on the FSSpec.
// *
// *****************************************************************************
OSErr DoModernSaveCopy( Document* theDocument )
{
   	OSErr err = noErr;
 	
	if ( theDocument != NULL )
    { 
        NavReplyRecord 	reply;
        AEDesc			actualDesc;
        
        SetCursor( *(Cursor**)GetCursor( watchCursor ));
        
        if ((err = NavDialogGetReply( theDocument->fNavigationDialog, &reply )) == noErr)
        {
           	if ((err = AECoerceDesc( &reply.selection, typeFSRef, &actualDesc )) == noErr)
			{	
              	// the coercion succeeded as an FSRef, so use HFS+ APIs to save the file:
				err = DoFSRefSave( theDocument, &reply );
				AEDisposeDesc( &actualDesc );
            }
            else
            {
            	// the coercion failed as an FSRef, so get the FSSpec and save the file:
              	err = DoFSSpecSave( theDocument, &reply );
            }
            err = NavDisposeReply( &reply );
        }
        
        InitCursor( );
    }    
    return err;
}
#endif // TARGET_API_MAC_CARBON


// *****************************************************************************
// *
// * 	DoActualSaveCopy( )
// *
// *****************************************************************************
OSErr DoActualSaveCopy( NavReplyRecord* reply, FSSpec* saveSpec, Document* theDocument )
{
	OSErr theErr = noErr;

	if ( reply->replacing )
		theErr = FSpDelete( saveSpec );
		
	if ( theErr == noErr )
	{
		OSType fileTypeToSave;
		if ( theDocument->theTE != NULL )	// which document type is it?
			fileTypeToSave = kFileType;
		else
			fileTypeToSave = kFileTypePICT;
					
		if ( (theErr = FSpCreate( saveSpec, kFileCreator, fileTypeToSave, smSystemScript )) == noErr )
			if ( (theErr = WriteNewFile( theDocument, saveSpec )) == noErr )	// use this document's data to write to our new copy
			{
				// translation may be needed for file we are saving a copy of,
				// when you save a copy, you should always "translate in place":
				theErr = NavCompleteSave( reply, kNavTranslateInPlace );
			}
			else
			{
				FSpDelete( saveSpec );	// do not leave the file around if a write error:
				DoWriteAlert( theErr );
			}
	}
	else
		if ( theErr == fBsyErr )
			DoReadAlert( );
	return theErr;
}


// *****************************************************************************
// *
// *	ReadFile( )
// *
// *****************************************************************************
short ReadFile( Document* theDocument )
{	
	long		count;
	short		theResult;
	char		buffer[256];
	TextStyle	theStyle;

	SetCursor( *GetCursor( watchCursor ) );

	if ( theDocument->theTE != NULL )
	{
		TESetSelect( 0, (**(theDocument->theTE)).teLength, theDocument->theTE );
		TEDelete( theDocument->theTE );

		theResult = SetFPos( theDocument->fRefNum, fsFromStart, 0 );
		if ( theResult != noErr )
			return theResult;

		do
		{
			count = 256;
			theResult = FSRead( theDocument->fRefNum, &count, &buffer );
			TEInsert( &buffer, count, theDocument->theTE );
		}
		while (theResult == noErr);

		if ( theResult == eofErr )
			theResult = noErr;
	
		TESetSelect( 0, 32767, theDocument->theTE );
		theStyle.tsFont = 21;
		theStyle.tsSize = 12;
		TESetStyle( doFont + doSize,&theStyle,true,theDocument->theTE );
		TESetSelect( 0, 0, theDocument->theTE );
	}
	else
	{
		long	fileSize = 0;
		long	headerSize = 0;
		long	pictSize = 0;

		SetCursor( *(Cursor**)GetCursor( watchCursor ) );
		
		theResult = SetFPos( theDocument->fRefNum, fsFromStart, 0 );
		if ( theResult != noErr )
			return theResult;

		theResult = GetEOF( theDocument->fRefNum, &fileSize );
		
		theDocument->fPictLength = fileSize;
		theDocument->fPictLength -= kPictHeaderSize;
		theDocument->fPict = NewHandle( theDocument->fPictLength );
		theDocument->fHeader = NewHandle( kPictHeaderSize );
		if ( theDocument->fPict == NULL || theDocument->fPict == NULL )
			return memFullErr;
			
		headerSize = kPictHeaderSize;
		pictSize = theDocument->fPictLength;

		theResult = FSRead( theDocument->fRefNum, &headerSize, *theDocument->fHeader );
		theResult = FSRead( theDocument->fRefNum, &pictSize, *theDocument->fPict );
	}

	theDocument->dirty = false;

	if ( theResult != noErr )
		DoReadAlert( );
	
	InitCursor( );
	
	return theResult;
}


// *****************************************************************************
// *
// *	WriteFile( )
// *
// *****************************************************************************
short WriteFile( Document* theDocument )
{	
	short	theResult;
	long	length;
	char*	bufPtr;

	SetCursor( *GetCursor( watchCursor ) );

	if ( !theDocument->fRefNum )
		return fnOpnErr;

	theResult = SetFPos( theDocument->fRefNum, fsFromStart, 0 );
	if ( theResult != noErr )
		return theResult;

	if ( theDocument->theTE != NULL )
	{
		length = (**(theDocument->theTE)).teLength;
		bufPtr = *((**(theDocument->theTE)).hText);

		theResult = FSWrite( theDocument->fRefNum, &length, bufPtr );
		if ( theResult == noErr )
			theResult = SetEOF( theDocument->fRefNum, length );
	}
	else
	{
		long headerSize = kPictHeaderSize;
		long pictSize = theDocument->fPictLength;

		if ((theResult = FSWrite( theDocument->fRefNum,&headerSize,*theDocument->fHeader )) == noErr )
		{
			if ((theResult = FSWrite( theDocument->fRefNum, &pictSize, *theDocument->fPict )) == noErr )
				theResult = SetEOF( theDocument->fRefNum, headerSize + pictSize );
		}
	}

	InitCursor( );
	
	return theResult;
}


// *****************************************************************************
// *
// *	WriteNewFile( )
// *
// *****************************************************************************
short WriteNewFile( Document* theDocument, FSSpec* newFileSpec )
{	
	short	theResult;
	short	refNum = 0;

	SetCursor( *GetCursor(watchCursor ) );

	theResult = FSpOpenDF( newFileSpec, fsRdWrPerm, &refNum );
	if ( refNum != -1 )
	{
		theResult = SetFPos( refNum, fsFromStart, 0 );
		if ( theResult != noErr )
			return( theResult );

		if ( theDocument->theTE != NULL )
		{
			long	length;
			char*	bufPtr;
			length = (**(theDocument->theTE)).teLength;
			bufPtr = *((**(theDocument->theTE)).hText);

			if ((theResult = FSWrite( refNum, &length, bufPtr )) == noErr)
				theResult = SetEOF( refNum, length );
		}
		else
		{
			long headerSize = kPictHeaderSize;
			long pictSize = theDocument->fPictLength;

			if ((theResult = FSWrite( refNum, &headerSize, *theDocument->fHeader )) == noErr)
				if ((theResult = FSWrite( refNum, &pictSize, *theDocument->fPict )) == noErr)
					theResult = SetEOF( refNum, headerSize + pictSize );
		}

		FSClose( refNum );
	}
	
	InitCursor( );
	
	return theResult;
}


// *****************************************************************************
// *
// *	DoNewDocument( )
// *
// *****************************************************************************
void DoNewDocument( Boolean newDocAsPICT )
{	
	Document* theDocument = NULL;
	theDocument = NewDocument( newDocAsPICT );
	if ( theDocument != NULL && theDocument->theWindow != NULL )
		ShowWindow( theDocument->theWindow );
}


// *****************************************************************************
// *
// *	DoOpenFile( )
// *
// *****************************************************************************
OSErr DoOpenFile( FSSpec* theFile, Boolean openAsPICT )
{	
	OSErr 	result = noErr;
	short 	refNum = 0;
	Str255	errorStr;
	SInt8 	permission = fsRdWrPerm;
	Boolean	fileLocked = false;
	
	if ( openAsPICT )
		permission = fsRdPerm;	// we don't allow writing to picture files
		
	result = FSpOpenDF( theFile, permission, &refNum );
	if ( !openAsPICT )
	{
		// file locked alert, but only for text documents:
		if ( result == fLckdErr || result == afpAccessDenied || result == permErr )
		{
			GetIndString( errorStr, rAppStringsID, sFileLocked );
			ParamText( (ConstStr255Param)&errorStr, (ConstStr255Param)"\p", (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
			NoteAlert( rGenericAlertID, 0L );
			
			fileLocked = true;
				
			result = FSpOpenDF( theFile, fsRdPerm, &refNum );
		}
	}

	if ( result == noErr )
	{
		Document* theDocument = NULL;
		theDocument = NewDocument( openAsPICT );
		if ( theDocument != NULL )
		{
			theDocument->fRefNum = refNum;
			
			theDocument->fileLocked = fileLocked;	// flag this so the File menu won't allow saving
			
			if ((result = ReadFile( theDocument )) == noErr )
			{
				SetWTitle( theDocument->theWindow,theFile->name );
				SizeDocWindow( theDocument );

				AdjustScrollBar( theDocument );
				ShowWindow( theDocument->theWindow );
			}
		}
		else
		{
			FSClose( refNum );
			result = memFullErr;
		}
	}

	if ( result != noErr )
	{
		if ( result == opWrErr )
			GetIndString( errorStr, rAppStringsID, sBusyOpen );
		else
			if ( result == memFullErr )
				GetIndString( errorStr, rAppStringsID, sLowMemoryErr );
			else
				GetIndString( errorStr, rAppStringsID, sOpeningErr );

		ParamText( (ConstStr255Param)&errorStr,(ConstStr255Param)"\p", (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
		NoteAlert( rGenericAlertID, 0L );
	}

	return result;
}


// *****************************************************************************
// *
// *	myFilterProc( )
// *
// *****************************************************************************
pascal Boolean myFilterProc( AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode )
{
#pragma unused( callBackUD, filterMode )

	Boolean display = true;
	NavFileOrFolderInfo* theInfo = (NavFileOrFolderInfo*)info;
	
	if ( theItem->descriptorType == typeFSS )
	{
		if ( !theInfo->isFolder )
		{
			// use:
			// 'theInfo->fileAndFolder.fileInfo.finderInfo.fdType'
			// to check for the file type you want to filter.
		}
	}
	return display;
}


// *****************************************************************************
// *
// *	myEventProc( )	
// *
// *****************************************************************************
pascal void myEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD )
{
	WindowPtr	pWindow = NULL;
	Document**	docList;
	Document*	theDoc = NULL;
	short 		index = 0;

	if ( callBackUD != 0 && callBackParms != NULL )
	{
		switch( callBackSelector )
		{
			case kNavCBEvent:
			{
				docList = (Document**)callBackUD;
				if ( docList != NULL )
					switch ( callBackParms->eventData.eventDataParms.event->what )
					{
						case nullEvent:
							break;
							
						case updateEvt:
							pWindow = (WindowPtr)callBackParms->eventData.eventDataParms.event->message;
							theDoc = docList[index];
							if ( theDoc != NULL && pWindow != NULL )
							{
								while ( theDoc->theWindow != pWindow && docList[index] != NULL )
								{
									index++;
									if ( docList[index] != NULL )
										theDoc = docList[index];
								}
								theDoc = docList[index];
								if ( theDoc != NULL )
									UpdateWindow( theDoc );
							}
							break;

						case activateEvt:
							break;

						default:
							break;
					}
				break;
			}
		}
	}
}


#if !TARGET_API_MAC_CARBON
// *****************************************************************************
// *
// *	DoOpenDocumentTheOldWay( )
// *
// *****************************************************************************
OSErr DoOpenDocumentTheOldWay( )
{	
	OSErr 				theErr = noErr;
	SFTypeList			theTypeList;
	StandardFileReply	theReply;

	theTypeList[0] = kFileType;
	theTypeList[1] = kFileTypePICT;
	StandardGetFile( 0L, 2, theTypeList, &theReply );

	if ( theReply.sfGood )
	{
		if ( theReply.sfType == kFileType )
			DoOpenFile( &theReply.sfFile, false );
		else
			DoOpenFile( &theReply.sfFile, true );
	}
	return theErr;
}
#endif // !TARGET_API_MAC_CARBON


// *****************************************************************************
// *
// *	DoOpenDocument( )
// *
// *****************************************************************************
OSErr DoOpenDocument( )
{	
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	OSErr				theErr = noErr;
	NavTypeListHandle	openList = NULL;
	long				count = 0;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	NavObjectFilterUPP	filterUPP = NewNavObjectFilterUPP( myFilterProc );
	
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );

	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );
	
	openList = (NavTypeListHandle)GetResource( kOpenRsrcType, kOpenRsrcID );

	dialogOptions.preferenceKey = kOpenPrefKey;

	dialogOptions.dialogOptionFlags += kNavDontAutoTranslate;	// we will do the translation ourselves later:

	theErr = NavGetFile( 	NULL,		// use system's default location
							&theReply,
							&dialogOptions,
							eventUPP,
							NULL,		// no custom previews
							filterUPP,
							openList,
							(NavCallBackUserData)&gDocumentList );

	DisposeNavEventUPP( eventUPP );
	DisposeNavObjectFilterUPP( filterUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		// since we allow for multiple objects to be returned,
		// grab the target FSSpecs from 'theReply.fileRef' list for opening:	
		FSSpec	finalFSSpec;	
		FInfo	fileInfo;

		// in the case we didn't want built in translation:
		if ( (dialogOptions.dialogOptionFlags & kNavDontAutoTranslate) != 0 )
			if ( theReply.translationNeeded )
			{
				// if we didn't want built in translation it was for the following reasons:
				//		1) we wanted to do it ourselves
				//		2) or we wanted to defer it	
				// things to remember if auto-translation is turned off:
				// 		1) the AEDesc list contains the original file specs the user had chosen.
				//		2) the 'fileTranslation' field for each object that needs translation has filled in for you.
				
				// put your own code here to perform your own translation.
				// - or -
				// we can simply call this to perform the translation manually:
				Str255 	errorStr;

				if ((theErr = NavTranslateFile( &theReply, kNavTranslateCopy )) != noErr )
				{
					if ( theErr == vLckdErr || theErr == afpVolLocked || theErr == wPrErr || theErr == permErr )
						GetIndString( errorStr, rAppStringsID, sTranslationLockedErr );
					else
						GetIndString( errorStr, rAppStringsID, sTranslationErr );
					ParamText( (ConstStr255Param)&errorStr, (ConstStr255Param)"\p", (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
					NoteAlert( rGenericAlertID, 0L );
				}
			}

		if ( theErr == noErr )
		{
			long index;

			// we are ready to open the document(s), grab information about each file for opening:
			theErr = AECountItems( &(theReply.selection), &count );
			for ( index=1; index<=count; index++ )
			{
				AEKeyword 	keyWord;
				DescType 	typeCode;
				Size 		actualSize = 0;

				if (( theErr = AEGetNthPtr( &(theReply.selection), index, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
				{
					// decide if the doc we are opening is a 'PICT' or 'TEXT':
					if (( theErr = FSpGetFInfo( &finalFSSpec, &fileInfo )) == noErr )
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
			}
		}
		
		theErr = NavDisposeReply( &theReply );	// clean up after ourselves	
	}

	if ( openList != NULL )
		ReleaseResource( (Handle)openList );

	return theErr;
}


#if !TARGET_API_MAC_CARBON
// *****************************************************************************
// *
// *	SaveACopyDocumentTheOldWay( )
// *
// *****************************************************************************
OSErr SaveACopyDocumentTheOldWay( Document* theDocument )
{
	OSErr				theErr = noErr;
	Str255				thePrompt, theName;
	StandardFileReply	theReply;

	if ( !theDocument )
		return false;

	GetIndString( (unsigned char*)&thePrompt, rAppStringsID, sSaveCopyMessage );
	GetWTitle( theDocument->theWindow, (unsigned char*)&theName);
	StandardPutFile( (unsigned char*)&thePrompt, (unsigned char*)&theName, &theReply );

	if ( theReply.sfGood )
	{
		if ( theReply.sfReplacing )
			theErr = FSpDelete( &theReply.sfFile );

		if ((theErr = FSpCreate( &theReply.sfFile, kFileCreator, kFileType, smSystemScript )) == noErr)
			theErr = WriteNewFile( theDocument, &theReply.sfFile );	// use this document's data to write to our new copy:
		
		if ( theErr == fBsyErr )
			DoWriteAlert( theErr );
	}
	else
		return false;
		
	return true;
}
#endif // !TARGET_API_MAC_CARBON


// *****************************************************************************
// *
// *	SaveACopyDocument( )
// *
// *****************************************************************************
OSErr SaveACopyDocument( Document* theDocument )
{	
	OSErr				theErr = noErr;
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	OSType				fileTypeToSave;
	short				strSize;
	Str255				copyStr;
	
	// default behavior for browser and dialog:
	theErr = NavGetDefaultDialogOptions( &dialogOptions );

	// user might want to translate the saveed doc into another format
	dialogOptions.dialogOptionFlags -= kNavDontAddTranslateItems;

	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );

	// setup the saved file name:
	GetWTitle( theDocument->theWindow, dialogOptions.savedFileName );
	GetIndString( copyStr, rAppStringsID, sNameCopy );
	strSize = dialogOptions.savedFileName[0] + copyStr[0];
	BlockMoveData( copyStr + 1, dialogOptions.savedFileName + dialogOptions.savedFileName[0] + 1, copyStr[0] );
	dialogOptions.savedFileName[0] = strSize;
		
	if ( theDocument->theTE != NULL )	// which document type is it?
		fileTypeToSave = kFileType;
	else
		fileTypeToSave = kFileTypePICT;

	dialogOptions.preferenceKey = kSavePrefKey;

	theErr = NavPutFile( 	NULL,		// use Nav's or last saved default location
							&theReply,
							&dialogOptions,
							eventUPP,
							fileTypeToSave,
							kFileCreator,
							(NavCallBackUserData)&gDocumentList );

	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// retrieve the returned selection:
		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &theReply.selection, 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
			theErr = DoActualSaveCopy( &theReply, &finalFSSpec, theDocument );

		theErr = NavDisposeReply( &theReply );
	}
	
	return theErr;
}


// *****************************************************************************
// *
// *	DoSaveAsDocument( )
// *
// *****************************************************************************
short DoSaveAsDocument( Document* theDocument )
{
	OSErr				theErr = noErr;
	short				result = true;
	NavReplyRecord		theReply;
	NavDialogOptions	dialogOptions;
	NavEventUPP			eventUPP = NewNavEventUPP( myEventProc );
	OSType				fileTypeToSave;

	// default behavior for browser and dialog:
	NavGetDefaultDialogOptions(&dialogOptions);

	// user might want to translate the saveed doc into another format
	dialogOptions.dialogOptionFlags -= kNavDontAddTranslateItems;

	GetWTitle( theDocument->theWindow,dialogOptions.savedFileName );
	GetIndString( (unsigned char*)&dialogOptions.clientName, rAppStringsID, sApplicationName );
			
	if ( theDocument->theTE != NULL )	// which document type is it?
		fileTypeToSave = kFileType;
	else
		fileTypeToSave = kFileTypePICT;

	dialogOptions.preferenceKey = kSavePrefKey;

	theErr = NavPutFile(	NULL,	// use system's default location
							&theReply,
							&dialogOptions,
							eventUPP,
							fileTypeToSave,
							kFileCreator,
							(NavCallBackUserData)&gDocumentList );
	DisposeNavEventUPP( eventUPP );

	if ( theReply.validRecord && theErr == noErr )
	{
		FSSpec		finalFSSpec;	
		AEKeyword 	keyWord;
		DescType 	typeCode;
		Size 		actualSize = 0;

		// retrieve the returned selection:
		// there is only one selection here we get only the first AEDescList:
		if (( theErr = AEGetNthPtr( &(theReply.selection), 1, typeFSS, &keyWord, &typeCode, &finalFSSpec, sizeof( FSSpec ), &actualSize )) == noErr )
		{
			if ( !theReply.replacing )
			{
				result = FSpCreate( &finalFSSpec, kFileCreator, fileTypeToSave, theReply.keyScript );
				if ( result )
				{
					SysBeep( 5 );
					return false;
				}
			}
				
			if ( theDocument->fRefNum )
				result = FSClose( theDocument->fRefNum );
			
			result = FSpOpenDF( &finalFSSpec,fsRdWrPerm, &theDocument->fRefNum );
			if ( result )
			{
				SysBeep( 5 );
				return false;
			}

			result = WriteFile( theDocument );
			if ( result != noErr )
				return false;

			theErr = NavCompleteSave( &theReply, kNavTranslateInPlace );

			SetWTitle( theDocument->theWindow, (unsigned char*)finalFSSpec.name );
			theDocument->dirty = false;
		}

		NavDisposeReply( &theReply );
	}
	else
		return false;

	return result;
}


#if !TARGET_API_MAC_CARBON

// *****************************************************************************
// *
// *	DoSaveAsDocumentOldWay( )
// *
// *****************************************************************************
short DoSaveAsDocumentOldWay( Document* theDocument )
{	
	short				theResult;
	Str255				thePrompt, theName;
	StandardFileReply	theReply;
	OSType				fileTypeToSave;

	if ( !theDocument )
		return false;

	GetIndString( (unsigned char*)&thePrompt, rAppStringsID, slSavePromptIndex );
	GetWTitle( theDocument->theWindow, (unsigned char*)&theName );
	StandardPutFile( (unsigned char*)&thePrompt, (unsigned char*)&theName, &theReply );

	if ( theDocument->theTE != NULL )	// which document type is it?
		fileTypeToSave = kFileType;
	else
		fileTypeToSave = kFileTypePICT;

	if ( theReply.sfGood )
	{
		if ( !theReply.sfReplacing )
		{
			theResult = FSpCreate( &theReply.sfFile, kFileCreator, fileTypeToSave, theReply.sfScript );
			if ( theResult )
			{
				SysBeep( 5 );
				return false;
			}
		}
			
		if ( theDocument->fRefNum )
			theResult = FSClose( theDocument->fRefNum );
		
		theResult = FSpOpenDF( &theReply.sfFile, fsRdWrPerm, &theDocument->fRefNum );
		if ( theResult )
		{
			SysBeep( 5 );
			return false;
		}

		theResult = WriteFile( theDocument );
		if ( theResult != noErr )
		{
			SysBeep( 5 );
			return false;
		}

		SetWTitle( theDocument->theWindow, (unsigned char*)theReply.sfFile.name );
		theDocument->dirty = false;
	}
	else
		return false;
		
	return true;
}
#endif // !TARGET_API_MAC_CARBON


// *****************************************************************************
// *
// *	DoSaveDocument( )
// *
// *****************************************************************************
short DoSaveDocument( Document* theDocument )
{
	short theErr = noErr;
	if ( theDocument != NULL )
	{
		if ( theDocument->fRefNum )
		{
			if ( WriteFile( theDocument ) )
			{
				SysBeep( 5 );
				return false;
			}
			else
				theDocument->dirty = false;
			theErr = true;
		}
		else
		{
#if TARGET_API_MAC_CARBON
			theErr = DoSaveAsDocument( theDocument );
#else
			// need to save file for the first time:
			if ( gNavServicesExists )
				theErr = DoSaveAsDocument( theDocument );
			else
				theErr = DoSaveAsDocumentOldWay( theDocument );

			if ( theErr == memFullErr )
				theErr = DoSaveAsDocumentOldWay( theDocument );
#endif
		}
	}
	return theErr;
}


// *****************************************************************************
// *
// *	DoRevertDocument( )
// *
// *****************************************************************************
void DoRevertDocument( Document* theDocument )
{	
	if ( theDocument != NULL && theDocument->fRefNum )
	{
		OSErr 						theErr = noErr;
		NavEventUPP					eventUPP = NewNavEventUPP( myEventProc );
		NavAskDiscardChangesResult 	reply;
		NavDialogOptions			dialogOptions;

		NavGetDefaultDialogOptions( &dialogOptions );

		GetWTitle( theDocument->theWindow,dialogOptions.savedFileName );
		theErr = NavAskDiscardChanges(	&dialogOptions,
										&reply,
										eventUPP,
										(NavCallBackUserData)&gDocumentList );
		DisposeNavEventUPP( eventUPP );

		switch( reply )
		{
			case kNavAskDiscardChanges:		
			{
				(void)ReadFile( theDocument );
				break;
			}
		}
	}
}


// *****************************************************************************
// *
// *	DoRevertDocumentTheOldWay( )
// *
// *****************************************************************************
void DoRevertDocumentTheOldWay( Document* theDocument )
{	
	if ( !theDocument )
		return;

	if ( theDocument->fRefNum )
	{
		Str255 theName;
		GetWTitle( theDocument->theWindow, (unsigned char*)&theName );
		ParamText( (ConstStr255Param)&theName, (ConstStr255Param)"\p", (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
		if ( Alert( rRevertID, 0L ) == ok )
			(void)ReadFile( theDocument );
	}
}


// *****************************************************************************
// *
// *	GetFSSpecInfo( )
// *
// *	Given a generic AEDesc, this routine returns the FSSpec of that object.
// *	Otherwise it returns an error.
// *	
// *****************************************************************************
OSStatus GetFSSpecInfo( AEDesc* fileObject, FSSpec* returnSpec )
{
	OSStatus 	theErr = noErr;
	AEDesc		theDesc;
	
	if ((theErr = AECoerceDesc( fileObject, typeFSS, &theDesc )) == noErr)
	{
		theErr = AEGetDescData( &theDesc, returnSpec, sizeof ( FSSpec ) );
		AEDisposeDesc( &theDesc );
	}
	else
	{
		if ((theErr = AECoerceDesc( fileObject, typeFSRef, &theDesc )) == noErr)
		{
			FSRef ref;
			if ((theErr = AEGetDescData( &theDesc, &ref, sizeof( FSRef ) )) == noErr)
				theErr = FSGetCatalogInfo( &ref, kFSCatInfoGettableInfo, NULL, NULL, returnSpec, NULL );
			AEDisposeDesc( &theDesc );
		}
	}

	return theErr;
}
