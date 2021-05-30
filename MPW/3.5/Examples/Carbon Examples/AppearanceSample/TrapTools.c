/*
	File:		TrapTools.c

	Contains:	Trap utility functions.

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-1999 by Apple Computer, Inc. All rights reserved.
*/

//------------------------------------------------------------------------------
//	Includes
//------------------------------------------------------------------------------

#include "AppearanceSamplePrefix.h"

#include <Traps.h>
#include "TrapTools.h"

//------------------------------------------------------------------------------
//	Private prototypes
//------------------------------------------------------------------------------

static int NumToolboxTraps();

//------------------------------------------------------------------------------
//	Implementation
//------------------------------------------------------------------------------

int NumToolboxTraps()
{
	if (NGetTrapAddress(_InitGraf,ToolTrap) == NGetTrapAddress(0xAA6E,ToolTrap))
		return(0x200);
	else
		return(0x400);
}


TrapType GetTrapType(short theTrap)
{
	return((theTrap & 0x0800) ? ToolTrap : OSTrap);
}

Boolean TrapAvailable(short theTrap)
{
	TrapType	tType;
	
	tType = GetTrapType(theTrap);
	if (tType == ToolTrap) {
		theTrap = theTrap & 0x07FF;
		if (theTrap >= NumToolboxTraps())
			theTrap = _Unimplemented;
	}
	return(NGetTrapAddress(theTrap,tType) != NGetTrapAddress(_Unimplemented,ToolTrap));
}