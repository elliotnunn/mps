/*
	File:		BaseDialog.h

	Contains:	Base class declaration for a dialog.

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

#include "BaseWindow.h"

class BaseDialog : public BaseWindow
{
	public:
			BaseDialog();
			BaseDialog( SInt16 resID );
		virtual ~BaseDialog();
		
		virtual void		Update( EventRecord& event );
		virtual void		Deactivate( EventRecord& event );
		virtual void		Activate( EventRecord& event );
		virtual void		HandleClick( EventRecord& event );
		virtual void		HandleKeyDown( EventRecord& event );
		
	protected:
		virtual void		HandleItemHit( SInt16 item );

		DialogPtr			fDialog;		
};