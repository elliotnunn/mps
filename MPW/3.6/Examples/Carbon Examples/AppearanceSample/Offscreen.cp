/*
	File:		Offscreen.cp

	Contains:	Class to help with offscreen drawing.

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
#include <Appearance.h>
#endif	// __MRC__
#include "Offscreen.h"

Offscreen::Offscreen()
{
	fWorld = nil;
	fSavePort = nil;
	fSaveDevice = nil;
	SetRect( &fBounds, 0, 0, 0, 0 );
}

Offscreen::~Offscreen()
{
}

void
Offscreen::StartDrawing( const Rect& bounds, Boolean copyDest )
{
	QDErr				err;
	Rect				globalRect;
	ThemeDrawingState	state;
	
	fBounds = bounds;
	
	GetGWorld( &fSavePort, &fSaveDevice );
	
	globalRect = fBounds;
	
	LocalToGlobal( &topLeft( globalRect ) );
	LocalToGlobal( &botRight( globalRect ) );

	err = NewGWorld( &fWorld, 0, &globalRect, nil, nil, 0 );
	if ( err == noErr )
	{
		GetThemeDrawingState( &state );
		SetGWorld( fWorld, nil );
		SetOrigin( fBounds.left, fBounds.top );
		SetThemeDrawingState( state, true );
		
		LockPixels( GetGWorldPixMap( fWorld ) );
		EraseRect( &fBounds );
		TextFont( GetPortTextFont( fSavePort ) );
		TextSize( GetPortTextSize( fSavePort ) );
		TextFace( GetPortTextFace( fSavePort ) );
		TextMode( GetPortTextMode( fSavePort ) );
		
		if ( copyDest )
		{
			Rect		portRect;
			
			GetPortBounds( fWorld, &portRect );	
			CopyBits( (BitMap*)*GetPortPixMap( fSavePort ), (BitMap*)*GetPortPixMap( fWorld ),
				&fBounds, &portRect, srcCopy, nil );
		}
	}
	else
		fWorld = nil; // make sure
}

void
Offscreen::EndDrawing()
{
	ThemeDrawingState	state;
  	Rect				portRect;
	
	if ( fWorld == nil ) return;
	
	SetOrigin( 0, 0 );
	SetGWorld( fSavePort, fSaveDevice );

	GetThemeDrawingState( &state );
	NormalizeThemeDrawingState();
				
	GetPortBounds( fWorld, &portRect );	
	CopyBits( (BitMap*)*GetPortPixMap( fWorld ), (BitMap*)*GetPortPixMap( fSavePort ),
			&portRect, &fBounds, srcCopy, NULL );

	UnlockPixels( GetGWorldPixMap( fWorld ) );
	DisposeGWorld( fWorld );
	
	fWorld = nil;
	
	SetThemeDrawingState( state, true );
}

void
Offscreen::EndDrawingAndBlend( const RGBColor& opColor )
{
	ThemeDrawingState	state;
	Rect				portRect;

	if ( fWorld == nil ) return;
	
	SetOrigin( 0, 0 );
	SetGWorld( fSavePort, fSaveDevice );

	GetThemeDrawingState( &state );
	NormalizeThemeDrawingState();
	
	OpColor( &opColor );
	GetPortBounds( fWorld, &portRect );	
	CopyBits( (BitMap*)*GetPortPixMap( fWorld ), (BitMap*)*GetPortPixMap( fSavePort ),
			&portRect, &fBounds, blend, NULL );

	UnlockPixels( GetGWorldPixMap( fWorld ) );
	DisposeGWorld( fWorld );
	
	fWorld = nil;
	
	SetThemeDrawingState( state, true );
}

