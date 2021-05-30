/*
	File:		ClassicPane.h

	Contains:	Class to drive our classic pane, showing new versions of old favorites.

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

#pragma once

#include "MegaPane.h"
#include "Appearance.h"
#include <ControlDefinitions.h>

class ClassicPane : public MegaPane
{
	public:
			ClassicPane( DialogPtr dialog, SInt16 items );
		virtual ~ClassicPane();
		
		virtual void		ItemHit( SInt16 item );
	
	private:
		static pascal void	ScrollingFeedbackProc( ControlHandle control, SInt16 part );
		static pascal void	DrawPictureProc( ControlHandle control, SInt16 part );

		static ControlActionUPP	fScrollBarProc;
		static ControlUserPaneDrawUPP fDrawProc;

		ControlHandle		fVerticalScrollBar;
		ControlHandle		fHorizontalScrollBar;
		ControlHandle		fUserItem;
		Point				fPictOffset;
		SInt16				fPictWidth;
		SInt16				fPictHeight;
		PicHandle			fPicture;
		SInt16				fUserItemHeight;
		SInt16				fUserItemWidth;
};