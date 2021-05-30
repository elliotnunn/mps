/*
	File:		DialogWindow.h

	Contains:	Dialog example showing Appearance Manager primitives.

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

#ifndef _DIALOGWINDOW_H
#define _DIALOGWINDOW_H

#include "Appearance.h"
#include "BaseWindow.h"

class DialogWindow : public BaseWindow
{
	public:
			DialogWindow();
		virtual ~DialogWindow();
		
		virtual void		Activate( EventRecord& event );
		virtual void		Deactivate( EventRecord& event );
		virtual void		Draw();
	
	private:
		void				DrawFakeEditText( ThemeDrawState state );
		void				DrawFakeListBox( ThemeDrawState state );
		void				DrawGroups( ThemeDrawState state );
		void				DrawSeparators( ThemeDrawState state );

};

#endif // _DIALOGWINDOW_H
