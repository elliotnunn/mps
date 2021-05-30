/*
	File:		Assertions.c

	Contains:	Assertion routines.

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

#include "AppearanceSamplePrefix.h"

#define DEBUG_MSG_TYPE 0

#include "Assertions.h"
#include <stdio.h>
#include <MacTypes.h>
#include <TextUtils.h>

void AssertMsg( char* msg, char* file, int line )
{

	char	newMsg[256];
	
	sprintf( newMsg, "%s, File: %s, Line: %d", msg, file, line );
	DebugStr( c2pstr( newMsg ) );
}
