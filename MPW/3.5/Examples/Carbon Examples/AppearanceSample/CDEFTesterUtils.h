/*
	File:		CDEFTesterUtils.h

	Contains:	Code to demonstrate creation of many control types.

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

#include <Appearance.h>
#include <Controls.h>

extern ControlHandle CreateBevelButton( WindowRef window );
extern ControlHandle CreateChasingArrows( WindowRef window );
extern ControlHandle CreateDivider( WindowRef window );
extern ControlHandle CreateTriangle( WindowRef window );
extern ControlHandle CreateFinderHeader( WindowRef window );
extern ControlHandle CreateIconCDEF( WindowRef window );
extern ControlHandle CreatePictureCDEF( WindowRef window );
extern ControlHandle CreateProgressBar( WindowRef window );
extern ControlHandle CreateLittleArrows( WindowRef window );
extern ControlHandle CreateGroupBox( WindowRef window );
extern ControlHandle CreatePlacard( WindowRef window );
extern ControlHandle CreatePopupArrow( WindowRef window );
extern ControlHandle CreateScrollBar( WindowRef window );
extern ControlHandle CreateImageWell( WindowRef window );
extern ControlHandle CreatePushButton( WindowRef window );
extern ControlHandle CreateCheckBox( WindowRef window );
extern ControlHandle CreateRadioButton( WindowRef window );
extern ControlHandle CreateEditText(WindowRef window);
extern ControlHandle CreateStaticText(WindowRef window);
extern ControlHandle CreateSlider(WindowRef window);
extern ControlHandle CreateClock(WindowRef window);
extern ControlHandle CreateTabs(WindowRef window);
extern ControlHandle CreateUserPane(WindowRef window);
extern ControlHandle CreateList(WindowRef window);

extern pascal ControlKeyFilterResult NumericFilter( ControlHandle control, SInt16* keyCode, SInt16* charCode, EventModifiers* modifiers );
