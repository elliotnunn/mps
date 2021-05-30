/*
	File:		SideUtilityWindow.h

	Contains:	Demonstration of side title bar utility windows.

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

#ifndef _SIDEUTILITYWINDOW_H
#define _SIDEUTILITYWINDOW_H

#include "UtilityWindow.h"
#include "Appearance.h"

class SideUtilityWindow : public UtilityWindow
{
	public:
			SideUtilityWindow();
		virtual ~SideUtilityWindow();
};

#endif // _SIDEUTILITYWINDOW_H
