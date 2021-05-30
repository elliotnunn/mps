/*
	File:		Common.c

	Contains:	commonly used code for NavSample

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

#ifndef __DOCUMENT__
#include "document.h"
#endif


extern short gInBackground;

// routines used for getting file path names:
OSErr PPrepend( StringPtr dst,StringPtr src );
void PAppend( StringPtr dst, StringPtr src );

short NumToolboxTraps( void );
pascal Boolean modernAlertFilter( DialogPtr theDialog, EventRecord* theEvent, DialogItemIndex* itemHit );


// *****************************************************************************
// *	modernAlertFilter
// *****************************************************************************
pascal Boolean modernAlertFilter( DialogPtr theDialog, EventRecord* theEvent, DialogItemIndex* itemHit )
{
    Boolean 		result = false;
    char 			charTyped = (char)theEvent->message & charCodeMask;
    AlertParmPtr	myAlertParms = NULL;
    
    // keep track of the client's settings:
    myAlertParms = (AlertParmPtr)GetWRefCon( GetDialogWindow( theDialog ) );
    if ( myAlertParms == NULL )
        return result;
        
    switch( theEvent->what )
    {
        case keyDown:
        {
            // check for command-key
            if ( (theEvent->modifiers & (cmdKey)) == cmdKey )
            {
                if ( charTyped == kPeriodChar && myAlertParms->useCancelButton )
                {
                    // check for command-period:
                    hiliteTheButton( theDialog, kAlertStdAlertCancelButton );
                    *itemHit = kAlertStdAlertCancelButton;
                    result = true;
                }
                else
                {
                    // check for command-D:
                    if ( (charTyped == kUpperDChar || charTyped == kLowerDChar) && myAlertParms->useDiscardButton ) 
                    {
                        hiliteTheButton( theDialog, kAlertStdAlertOtherButton );
                        *itemHit = kAlertStdAlertOtherButton;
                        result = true;
                    }
                }
            }
            else
            {
              	if ( charTyped == kCrChar || charTyped == kEnterChar )
                {
                    // check for enter/return:
                    hiliteTheButton( theDialog, kAlertStdAlertOtherButton );
                    *itemHit = kAlertStdAlertOtherButton;
                    result = true;
                }
                else
                    if ( charTyped == kEscKey && myAlertParms->useCancelButton )
                    {
                        // check for escape:
                        hiliteTheButton( theDialog, kAlertStdAlertCancelButton );
                        *itemHit = kAlertStdAlertCancelButton;
                        result = true;
                    }
                    else
                    {
                        // check for D and d chars:
                        if ( (charTyped == kUpperDChar || charTyped == kLowerDChar) && myAlertParms->useDiscardButton )                     			{
                            hiliteTheButton( theDialog, kAlertStdAlertOtherButton );			
                            *itemHit = kAlertStdAlertOtherButton;
                            result = true;
                        }
                    }
            }
            break;
        }
    }
    return result;
}


// *****************************************************************************
// *	DoModernAlert
// *
// *   	example:
// *		DialogItemIndex itemHit;
// *        	AlertParm param = {true,true,rAppStringsID,sApplicationName,rAppStringsID,sApplicationName};
// *        	itemHit = DoModernAlert( &param );
// *
// *****************************************************************************
DialogItemIndex	DoModernAlert( AlertParmPtr myAlertParamRec )
{
    DialogItemIndex			itemHit = 0;
    OSStatus 				theErr = noErr;
    AlertStdCFStringAlertParamRec 	rec;
    
    // initialize our alert parameters first:
    if ((theErr = GetStandardAlertDefaultParams( &rec, kStdCFStringAlertVersionOne )) == noErr)	
    {
        ModalFilterUPP	filterProc = NewModalFilterUPP( modernAlertFilter );
        Str255 		str;
	DialogPtr 	dialog;
	CFStringRef 	inExplanation;
	CFStringRef 	inError;

        rec.movable = true;
        rec.position = kWindowCenterParentWindow;
        
        if ( myAlertParamRec->useCancelButton )
        {
            GetIndString( str, rAppStringsID, sCancelTitle );
            rec.cancelText = CFStringCreateWithPascalString( NULL, str, CFStringGetSystemEncoding( ) );                    
        }
        if ( myAlertParamRec->useDiscardButton )
        {
            GetIndString( str, rAppStringsID, sDontSaveTitle );
            rec.otherText = CFStringCreateWithPascalString( NULL, str, CFStringGetSystemEncoding( ) );
        }
                            
        if ( myAlertParamRec->messageStrListID != 0 )
        {
            GetIndString( str, myAlertParamRec->messageStrListID, myAlertParamRec->messageStrItem );
            inError = CFStringCreateWithPascalString( NULL, str, CFStringGetSystemEncoding( ) );                    
        }
        if ( myAlertParamRec->explainStrListID != 0 )
        {
            GetIndString( str, myAlertParamRec->explainStrListID, myAlertParamRec->explainStrItem );
            inExplanation = CFStringCreateWithPascalString( NULL, str, CFStringGetSystemEncoding( ) ); 
        }
            
        if ((theErr = CreateStandardAlert( kAlertCautionAlert, inError, inExplanation, &rec, &dialog )) == noErr)
        {
            SetWRefCon( GetDialogWindow( dialog ), (long)myAlertParamRec );
            theErr = RunStandardAlert( dialog, filterProc, &itemHit );
        }

        if ( rec.cancelText != NULL )
            CFRelease( rec.cancelText );
        if ( rec.otherText != NULL )
            CFRelease( rec.otherText );
       
        CFRelease( inError );
        CFRelease( inExplanation );
        DisposeModalFilterUPP( filterProc );
    }
    return itemHit;
}
    
        
// *****************************************************************************
// *
// *	FSpGetDirID( )
// *	Neat little routine that returns the actual folderID from the FSSpec.
// *	
// *****************************************************************************
long FSpGetDirID( FSSpec* theSpec )
{
	CInfoPBRec	rec;
	long		dirID = 0;

	rec.hFileInfo.ioCompletion = nil;
	rec.hFileInfo.ioNamePtr = theSpec->name;
	rec.hFileInfo.ioVRefNum = theSpec->vRefNum;
	rec.hFileInfo.ioDirID = theSpec->parID;
	rec.hFileInfo.ioFDirIndex = 0;
	if ( !PBGetCatInfoSync( &rec ) )
		dirID = rec.hFileInfo.ioDirID;
	else
		dirID = 0;
	return dirID;
}


// ********************************************************************************
// *	ConcatPP( )
// ********************************************************************************
unsigned char* ConcatPP( unsigned char* a, unsigned char* b )
{
	short i;	
	for ( i = 1;i <= b[0]; i++ )
		a[++a[0]] = b[i];		
	return (a);
}


// ********************************************************************************
// *	FSSpecsEq( )
// ********************************************************************************
Boolean FSSpecsEq( FSSpec* a,FSSpec* b )
{
	if ( a->vRefNum != b->vRefNum )
		return false;
		
	if ( a->parID != b->parID )
		return false;
		
	if ( EqualString( a->name, b->name, true, true ) )
		return false;

	return true;
}


// ********************************************************************************
// *	RandTween( )
// *	Returns an 8-bit number between low and high.
// ********************************************************************************
short RandTween( short low, short high )
{
	short result;
	
	result = Random( ) % (high + 1 - low);
	if ( result < 0 )
		result = -result;
	result += low;
	return result;
}
	

// ********************************************************************************
// *	GetItemStr( )
// ********************************************************************************
unsigned char* GetItemStr( DialogPtr theDialog, short theItem, unsigned char* theString )
{
	Handle ahandle;
	Rect arect;
	short atype;
	
	GetDialogItem( theDialog, theItem, &atype, &ahandle, &arect );
	GetDialogItemText( ahandle, theString );
	return theString;
}


// ********************************************************************************
// *	PokeItemStr( )
// ********************************************************************************
void PokeItemStr( DialogPtr theDialog, short theItem, unsigned char* theString )
{
	Handle 	ahandle;
	Rect 	arect;
	short 	atype;
	
	GetDialogItem( theDialog, theItem, &atype, &ahandle, &arect );
	SetDialogItemText( ahandle, theString );
}


// ********************************************************************************
// *	PokeCtlVal( )
// ********************************************************************************
void PokeCtlVal( DialogPtr theDialog, short theItem, short value )
{
	Handle 	ahandle;
	Rect 	arect;
	short	atype;
	
	GetDialogItem( theDialog, theItem, &atype, &ahandle, &arect );
	SetControlValue( (ControlHandle)ahandle, value );
}


// ********************************************************************************
// *	PokeCtlHilite( )
// ********************************************************************************
void PokeCtlHilite( DialogPtr theDialog, short theItem, short value )
{
	Handle 	ahandle;
	Rect 	arect;
	short 	atype;
	
	GetDialogItem( theDialog, theItem, &atype, &ahandle, &arect );
	HiliteControl( (ControlHandle)ahandle, value );
}


// ********************************************************************************
// *	MyP2CCopy( )
// ********************************************************************************
char* MyP2CCopy( unsigned char* psrc, char* ctarget )
{
	short i;
	for( i = 0; i < psrc[0]; i++ )
		ctarget[i] = psrc[i + 1];	
	ctarget[i] = 0;
	return ctarget;
}


// ********************************************************************************
// *	MyC2PStr( )
// ********************************************************************************
unsigned char* MyC2PStr( char* theStr )
{
	short i,length;

	for( i = 0; theStr[i]; i++ )
		;
	length = i;
	while(i)
	{
		theStr[i] = theStr[i - 1];
		i--;
	}
	((unsigned char*)theStr)[0] = length;
	return ( (unsigned char *)theStr );
}


// ********************************************************************************
// *	MyP2CStr( )
// ********************************************************************************
char* MyP2CStr( unsigned char* theStr )
{
	short i,length;
	length = theStr[0];
	for( i = 0; i < length; i++ )
		theStr[i] = theStr[i + 1];
	theStr[length] = 0;
	return ( (char *)theStr );
}


// ********************************************************************************
// *	myDebugCStr( )
// ********************************************************************************
void myDebugCStr( char* msg )
{
	MyC2PStr( msg );
	DebugStr( (unsigned char*)msg );
	MyP2CStr( (unsigned char*)msg );
}


// ********************************************************************************
// *	Str2OSType( )
// *	C strings only.
// ********************************************************************************
OSType Str2OSType( Str255 theStr )
{
	OSType num = 0;
	num =  theStr[3] + (theStr[2] << 8) + (theStr[1] << 16) + (theStr[0] << 24);
	return num;	
}

// ********************************************************************************
// *	MyStrLen( )
// *	C strings only.
// ********************************************************************************
long MyStrLen( char* s )
{
	long count=0;
	while (*s++ != '\0') count++;
	return count;
}


// ********************************************************************************
// *	myStringToLong( )
// *	C strings only.
// ********************************************************************************
long myStringToLong( char* s )
{
	long n = 0;
	short i;
	
	for ( i=0; s[i]>='0' && s[i]<='9'; i++ )
		n = 10*n + (s[i]-'0');
	return n;
}


// ********************************************************************************
// *	myStringToShort( )
// *	C strings only.
// ********************************************************************************
short myStringToShort( char* s )
{
	short n = 0;
	short i;
	
	for( i=0; s[i]>='0' && s[i]<='9'; i++ )
		n = 10*n + (s[i]-'0');
	return n;
}


// ********************************************************************************
// *	myStrCpy( )
// *	C strings only.
// ********************************************************************************
void myStrCpy( char* dst, char* src )
{
	while( *src != '\0' )
		*dst++ = *src++;
	*dst = '\0';
}


// ********************************************************************************
// *	myStrCat( )
// ********************************************************************************
void myStrCat( char* dst, char* src )
{
	dst = dst + MyStrLen( dst );
	myStrCpy( dst, src );
}


// *****************************************************************************
// *	SetItemEnable( )
// *****************************************************************************
void SetItemEnable( MenuHandle theMenu, short theItem, short enable )
{	
    if ( enable )
        EnableMenuItem( theMenu, theItem );
    else
        DisableMenuItem( theMenu, theItem );
}


// ********************************************************************************
// *	flag routines for KeyDown events..
// ********************************************************************************
Boolean OptionDown( )	{ return ModifierDown( optionKey, true ); }
Boolean ShiftDown( ) 	{ return ModifierDown( shiftKey, true); }
Boolean CommandDown( )	{ return ModifierDown( cmdKey, true); }
Boolean ControlDown( )	{ return ModifierDown( controlKey, true); }


// *****************************************************************************
// *	ModifierDown( )
// *****************************************************************************
Boolean ModifierDown( long keyMask, Boolean exactMatch )
{
	EventRecord event;
	Boolean 	match;
	
	EventAvail( nullEvent, &event );	
	if ( exactMatch == true )
		match = (event.modifiers & keyMask) == keyMask;
	else
		match = (event.modifiers & keyMask) != 0;
	
	return match;
}


// *****************************************************************************
// *	hiliteTheButton( )
// *****************************************************************************
void hiliteTheButton( DialogPtr theDialog, short whichItem )
{
	short		itemType = 0;
	Handle		itemHdl;
	Rect		itemRect;
	long int 	startTick;

	GetDialogItem( theDialog, whichItem, &itemType, &itemHdl, &itemRect );
	HiliteControl( (ControlHandle)itemHdl, 1 );
	for ( startTick=TickCount( ); TickCount( ) - startTick<kDelayTick; )
		{} // do nothing...
	HiliteControl( (ControlHandle)itemHdl, kActive );
}


// *****************************************************************************
// *	AdornButton( )	
// *****************************************************************************
void AdornButton( DialogPtr theDialog, short whichItem )
{
    OSErr 	theErr = noErr;
    long	version = 0;
	
	theErr = Gestalt( gestaltSystemVersion, &version );
	if ( version >= 0x0800 )
	{
		Boolean def = true;
		ControlHandle itemH;
		GetDialogItemAsControl( theDialog, whichItem, &itemH );
		SetControlData( itemH, kControlNoPart, kControlPushButtonDefaultTag, sizeof( def ), (Ptr)&def );
	}
	else
	{
		// do it ourselves since default button adornment is not supported in 7.x systems:
		GrafPtr	oldPort;
		Handle	itemH;
		short	itemType;
		Rect	itemRect;
                WindowPtr window;
                
		GetPort( &oldPort );	
		window = GetDialogWindow( theDialog );	
		SetPort( (GrafPtr)GetWindowPort( window ));
		
		GetDialogItem( theDialog, whichItem, &itemType, &itemH, &itemRect );
		PenSize( 3, 3 );
		InsetRect( &itemRect, -4, -4 );
		FrameRoundRect( &itemRect, 14, 14 );
		
		PenNormal( );
		SetPort( oldPort );
	}
}


// *****************************************************************************
// *
// *	DrawIconSuite()
// *
// *	This routine draws the appropriate icon into 'destRect' based on the
// *	'resID' of the icon suite.  The caller must set its port before calling
// *	this routine.
// *	
// *****************************************************************************
void DrawIconSuite( short resID, Rect destRect )
{ 
	IconSelectorValue	iconType;
	IconAlignmentType	align;
	IconTransformType	transform;
	OSErr				theErr = noErr;
	Handle				iconSuiteHdl;
	
	iconType = svAllAvailableData;
	theErr = GetIconSuite( &iconSuiteHdl, resID, iconType );
	if ( theErr == noErr && iconSuiteHdl != NULL )
	{
		align = atAbsoluteCenter;
		transform = ttNone;
		theErr = PlotIconSuite( &destRect, align, transform, iconSuiteHdl );
	}
}


// *****************************************************************************
// *	PAppend( )	
// *****************************************************************************
void PAppend( StringPtr dst, StringPtr src )
{
	BlockMove( src + 1, dst + *dst + 1, *src );
	*dst += *src;
}



// ********************************************************************************
// *
// *	PPrepend()
// *		or "Path Append": add 'src' to the end of 'dst'.
// *	- Pascal strings only.
// *
// ********************************************************************************	
OSErr PPrepend( StringPtr dst,StringPtr src )
{
	if ( *dst + *src > 255 )
		return -1;
	
	BlockMove( dst + 1, dst + *src + 1, *dst );
	BlockMove( src + 1, dst + 1, *src );
	*dst += *src;
	
	return 0;
}


// ********************************************************************************
// *
// *	PathNameFromDirID()
// *
// *	Creates a full or partial path name of a given file.
// *	- Inputs 'dirID' and 'vRefNum' and outputs 'fullPathName'.
// *	- fullPathLength = num characters requested.
// *	- full = flag to make full path, rather than just the item name.
// *
// ********************************************************************************	
OSErr PathNameFromDirID( long dirID,
						short vRefNum,
						StringPtr fullPathName,
						short maxPathLength,
						short full )
{
	DirInfo	block;
	Str255	directoryName;
	OSErr 	theErr;

	fullPathName[0] = 0;

	block.ioDrParID = dirID;
	block.ioNamePtr = directoryName;
	do
	{
		block.ioVRefNum = vRefNum;
		block.ioFDirIndex = -1;
		block.ioDrDirID = block.ioDrParID;
		theErr = PBGetCatInfoSync( (CInfoPBPtr)&block );
		if ( theErr )
			return theErr;
		
		PAppend( directoryName, (StringPtr)"\p:" );
		
		if ( fullPathName[0] + directoryName[0] >= maxPathLength )
			return -1;	// actual path name too long for the requested path name size
			
		PPrepend( fullPathName, directoryName );
	}
	while ((block.ioDrDirID != 2) && (full));
		
	return(0);
}


// *****************************************************************************
// *	AdjustCursor( )	
// *****************************************************************************
void AdjustCursor( Point theLoc, RgnHandle theRgn )
{	
	WindowPtr	theWindow = NULL;
	Document*	theDocument;
	RgnHandle	arrowRgn, iBeamRgn, hiliteRgn;
	Rect		theRect;
	Point		thePoint;

	if ( gInBackground )
		return;

	arrowRgn = NewRgn( );
	MacSetRectRgn( arrowRgn, -32767, -32767, 32767, 32767 );

	theWindow = FrontWindow( );
	theDocument = IsDocumentWindow( theWindow );
	
	if ( theWindow != NULL && theDocument != NULL && theDocument->theTE != NULL )
	{
		SetPort( (GrafPtr)GetWindowPort( theWindow ) );

		iBeamRgn = NewRgn( );
		hiliteRgn = NewRgn( );

		theRect = (**(theDocument->theTE)).viewRect;
		LocalToGlobal( (Point*)&(theRect.top) );
		LocalToGlobal( (Point*)&(theRect.bottom) );
		RectRgn( iBeamRgn, &theRect );

		CopyRgn( theDocument->hiliteRgn,hiliteRgn );
		thePoint.h = thePoint.v = 0;
		LocalToGlobal( &thePoint );
		OffsetRgn( hiliteRgn, thePoint.h, thePoint.v );

		DiffRgn( arrowRgn, hiliteRgn, arrowRgn );
		DiffRgn( arrowRgn, iBeamRgn, arrowRgn );

		DiffRgn( iBeamRgn, hiliteRgn, iBeamRgn );

		if ( PtInRgn( theLoc, iBeamRgn ) )
		{
			SetCursor( *GetCursor( iBeamCursor ) );
			CopyRgn( iBeamRgn, theRgn );
		}
		else
		{
			InitCursor( );
			if ( PtInRgn( theLoc, hiliteRgn ) )
				CopyRgn( hiliteRgn, theRgn );
			else
				CopyRgn( arrowRgn, theRgn );
		}
		
		DisposeRgn( iBeamRgn );
		DisposeRgn( hiliteRgn );
	}
	else
	{
		InitCursor( );
		CopyRgn( arrowRgn, theRgn );
	}

	DisposeRgn( arrowRgn );
}


// *****************************************************************************
// *	DoLowMemAlert( )	
// *****************************************************************************
void DoLowMemAlert( )
{
	Str255 message;
	GetIndString( message, rAppStringsID, sLowMemoryErr );
	ParamText( (ConstStr255Param)message, "\p", "\p", "\p" );
	InitCursor( );
	(void)NoteAlert( rGenericAlertID, 0L );
}


// *****************************************************************************
// *
// *	myAEGetDescData( )
// *
// *****************************************************************************
OSErr myAEGetDescData( 	const AEDesc* desc,
						DescType* typeCode,
						void* dataBuffer,
						ByteCount maximumSize,
						ByteCount* actualSize )
{
    OSErr 		theErr = noErr;
	ByteCount	dataSize;
#if !OPAQUE_TOOLBOX_STRUCTS
	Handle 		h;
	ByteCount 	size;
#endif
	
	if ( typeCode != NULL && desc != NULL )
		*typeCode = desc->descriptorType;

#if OPAQUE_TOOLBOX_STRUCTS
	// if we are opaque with AppleEvent descriptors, use AEGetDescData()

	dataSize = AEGetDescDataSize( desc );
	if ( actualSize )
		*actualSize = dataSize;

	if ( dataSize > 0 && maximumSize > 0 )
		theErr = AEGetDescData( desc, dataBuffer, maximumSize );
#else

	// if we are non-opaque with AppleEvent descriptors, do it ourselves:
	
	h = (Handle)desc->dataHandle;
	dataSize = GetHandleSize( h );
	
	if ( dataSize > maximumSize )
		size = maximumSize;
	else
		size = dataSize;
	
	BlockMoveData( *h, dataBuffer, size );
	if ( actualSize != NULL )
		*actualSize = size;
                
#endif // OPAQUE_TOOLBOX_STRUCTS
    
    return theErr;
}

// *****************************************************************************
// *
// *	DoStdAlert( )	
// *
// *****************************************************************************
OSErr DoStdAlert( unsigned char* title, short* itemHit )
{
	OSErr 					theErr = noErr;
	AlertStdAlertParamRec	alertParamRec;
	
	*itemHit = 0;	
	
	alertParamRec.movable = false;				// Make alert movable modal
	alertParamRec.helpButton = false;			// Is there a help button?
	alertParamRec.filterProc = NULL;			// event filter
	alertParamRec.defaultText = NULL;			// Text for button in OK position
	alertParamRec.cancelText = NULL;			// Text for button in cancel position
	alertParamRec.otherText = NULL;				// Text for button in left position
	alertParamRec.defaultButton = 1;			// Which button behaves as the default
	alertParamRec.cancelButton = 0;				// Which one behaves as cancel (can be 0)
	alertParamRec.position = kWindowAlertPositionParentWindow;	// Position (kWindowDefaultPosition in this case

	SysBeep( 5 );
	theErr = StandardAlert( kAlertStopAlert, title, NULL, &alertParamRec, itemHit );
	return theErr;
}


// *****************************************************************************
// *
// *	RightJustifyPict( )
// *
// *	Used in two examples of Nav Services customization.
// *
// *****************************************************************************
void RightJustifyPict( NavCBRecPtr callBackParms )
{
	UInt16 	firstControl = 0;
	OSErr	theErr = noErr;
	
	if ((theErr = NavCustomControl( callBackParms->context, kNavCtlGetFirstControlID, &firstControl )) == noErr)
	{
		Rect 		finalRect;
		Handle 		controlH;
		Rect 		itemRect;
		short 		itemType, width, height;
		short 		pictItem = firstControl + kPictItem;
			
		GetDialogItem( GetDialogFromWindow( callBackParms->window ), pictItem, &itemType, &controlH, &itemRect );		
		width = itemRect.right - itemRect.left;
		height = itemRect.bottom - itemRect.top;
		SetRect( &finalRect, callBackParms->customRect.right - width,
							 callBackParms->customRect.top,
							 callBackParms->customRect.right,
							 callBackParms->customRect.top + height );

		MoveDialogItem( GetDialogFromWindow( callBackParms->window ), pictItem,
						finalRect.left,
						itemRect.top );
	}
}


// *****************************************************************************
// *
// *	HandleCommandPopup( )
// *	
// *****************************************************************************
void HandleCommandPopup( ControlHandle thePopup, NavDialogRef navDialog )
{
	OSErr 	theErr = noErr;
	short 	selection = 0;
	
	selection = GetControlValue( thePopup ) - 1;
	switch( selection )
	{								
		case kNavCtlShowDesktop:
		case kNavCtlScrollHome:
		case kNavCtlScrollEnd:
		case kNavCtlPageUp:
		case kNavCtlPageDown:
		case kNavCtlShowSelection:
		case kNavCtlCancel:
		case kNavCtlAccept:
		case kNavCtlTerminate:
		case kNavCtlGotoParent:
		case kNavCtlBrowserRedraw:
		case kNavCtlBrowserSelectAll:
			theErr = NavCustomControl( navDialog, selection, NULL );
			break;
	
		case kNavCtlNewFolder:
		{
			Str255 newFolderName = "\puntitled folder";
			theErr = NavCustomControl( navDialog, kNavCtlNewFolder, &newFolderName );
			break;
		}
		
		case kNavCtlOpenSelection:
		{
			AEDesc itemToOpen;
			if (( theErr = NavCustomControl( navDialog, kNavCtlGetSelection, &itemToOpen )) == noErr )
			{
				theErr = NavCustomControl( navDialog, kNavCtlOpenSelection, &itemToOpen );
				AEDisposeDesc( &itemToOpen );
			}
			break;
		}
	}
}


// *****************************************************************************
// *
// *	HandleCustomControls( )
// *
// *	Used in two examples of Nav Services customization.
// *
// *****************************************************************************
Boolean	HandleCustomControls( WindowRef window, NavDialogRef navDialog, ControlRef whichControl, short baseItem, short itemNum )
{
 	Boolean handledIt = false;
 	
 	if ( whichControl != NULL )
	{
		ControlRef controlH;
		
		switch( itemNum )
		{
			case kPopupCommand:
			{
				HandleCommandPopup( whichControl, navDialog );
				handledIt = true;
				break;
			}
				
			case kAllowDismissCheck:
			{
				SetControlValue( whichControl, !GetControlValue( whichControl ));
				handledIt = true;
				break;
			}

			case kRadioOneItem:
			{
				SetControlValue( whichControl, true );
				
				GetDialogItemAsControl( GetDialogFromWindow( window ), baseItem + kRadioTwoItem, &controlH );
				SetControlValue( controlH, false );
				
				handledIt = true;
				break;
			}
				
			case kRadioTwoItem:
			{
				SetControlValue( whichControl, true );
				
				GetDialogItemAsControl( GetDialogFromWindow( window ), baseItem + kRadioOneItem, &controlH );
				SetControlValue( controlH, false );
				
				handledIt = true;
				break;
			}
				
			case kButtonItem:
			{
				Str255 errorStr;
				short itemHit;
				GetIndString( errorStr, rAppStringsID, sAlertMessage );
				DoStdAlert( errorStr, &itemHit );
				
				handledIt = true;
				break;
			}
		}
	}
	
	return handledIt;
}