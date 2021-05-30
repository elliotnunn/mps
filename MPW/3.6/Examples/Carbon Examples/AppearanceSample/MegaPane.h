/*
	File:		MegaPane.h

	Contains:	Base class for panes in our MegaDialog example.

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

#ifdef __MRC__
#include <Dialogs.h>
#endif	// __MRC__

class MegaPane
{
	public:
			MegaPane( DialogPtr dialog, SInt16 origItems );
		virtual ~MegaPane();
		
		virtual void	ItemHit( SInt16 item );
		virtual void	Idle();
	
	protected:
		DialogPtr		fDialog;
		SInt16			fOrigItems;
};
