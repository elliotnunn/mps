/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	TESample.h	-	C++ source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			CPlusTESample.make		July 9, 1989
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TDocument.h				July 9, 1989
#			TECommon.h				July 9, 1989
#			TESample.h				July 9, 1989
#			TEDocument.h			July 9, 1989
#			TApplication.cp			July 9, 1989
#			TDocument.cp			July 9, 1989
#			TESample.cp				July 9, 1989
#			TEDocument.cp			July 9, 1989
#			TESampleGlue.a			July 9, 1989
#			TApplication.r			July 9, 1989
#			TESample.r				July 9, 1989
#
#	CPlusTESample is an example application that demonstrates
#	how to initialize the commonly used toolbox managers,
#	operate successfully under MultiFinder, handle desk
#	accessories and create, grow, and zoom windows. The
#	fundamental TextEdit toolbox calls and TextEdit autoscroll
#	are demonstrated. It also shows how to create and maintain
#	scrollbar controls. 
#
#	This version of TESample has been substantially reworked in
#	C++ to show how a "typical" object oriented program could
#	be written. To this end, what was once a single source code
#	file has been restructured into a set of classes which
#	demonstrate the advantages of object-oriented programming.
#
------------------------------------------------------------------------------*/

#ifndef TESample_Defs
#define TESample_Defs

// we need resource definitions
#include "TECommon.h"

// Since we are based on the Application class, we need its class definitions
#include "TApplication.h"

// TESample is our application class. It is a subclass of TApplication,
// so it only needs to specify its behaviour in areas where it is different
// from the default.
class TESample : public TApplication {
public:
	TESample(void);				// Our constructor

private:
	// routines from TApplication we are overriding
	long HeapNeeded(void);
	unsigned long SleepVal(void);
	void DoIdle(void);
	void AdjustCursor(void);
	void AdjustMenus(void);
	void DoMenuCommand(short menuID, short menuItem);

	// routines for our own devious purposes
	void DoNew(void);
	void Terminate(void);
};

#endif TESample_Defs