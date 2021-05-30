/*
	File:		UtilityWindow.h

	Contains:	Utility window tester class.

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

#ifndef _UTILITYWINDOW_H
#define _UTILITYWINDOW_H

//#include <Controls.h>
#include "BaseWindow.h"
#include "Appearance.h"

class UtilityWindow : public BaseWindow
{
	public:
			UtilityWindow();
		virtual ~UtilityWindow();
		
		virtual void		Activate( EventRecord& event );
		virtual void		Deactivate( EventRecord& event );
		virtual void		Draw();
		virtual void		Resize( SInt16 width, SInt16 height );
		virtual void		HandleClick( EventRecord& event );

	protected:
			UtilityWindow( SInt16 windID );
		
	private:
		virtual void		InvalidateScrollBars();
		virtual void		CalcHorizScrollBarRect( Rect& rect );
		virtual void		CalcVertScrollBarRect( Rect& rect );
	
		static pascal void	ScrollBarAction( ControlHandle control, SInt16 partHit );

		ControlHandle		fHorizScrollBar;
		ControlHandle		fVertScrollBar;
};

#endif // _UTILITYWINDOW_H
