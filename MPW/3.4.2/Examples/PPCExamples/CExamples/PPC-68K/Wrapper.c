/*
	File:		Wrapper.c

	Contains:	Single entry-point code resource that sets up a series
				of pointers to library functions.
				A key part of the "calling 68K code from PowerPC" demo

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 2/15/94	RC		Released

	To Do:
*/

#include "Library.h"
#include "WrapperTable.h"
#include <TextUtils.h>
#include <CodeFragments.h>



pascal void Wrapper(void)
// Build a table of pointers to functions in our linked library
{
	OSErr			err;
	ConnectionID	connID = 0;
	Ptr				mainAddr;
	Str255 			errName, appName, tableName;
	SymClass 		symClass;
	JumpTablePtr	myTablePointer;

	_DataInit();
	
	// Locate the application that called us
	GetIndString( (unsigned char *)&appName, 128, 1);
	err = GetSharedLibrary( (unsigned char *)&appName, kPowerPCArch, 0, &connID, &mainAddr, (unsigned char *)&errName);
	if (err) goto done;
	
	// Now, locate the table that is shared between the 68K code and the PowerPC code
	// (it's a pointer stored in a global variable)
	GetIndString( (unsigned char *)&tableName, 128, 2);
	err = FindSymbol(connID, (unsigned char *)&tableName, (Ptr*)&myTablePointer, &symClass);
	// We could check to see that symClass == dataSymbol, but I'm in a trusting mood today
	if (err) goto done;
	
	// Fill in the table with pointers to each library function
	myTablePointer->routine1 = NewMyRoutineProc(LibFunction);
	
done:
	if (connID)
		CloseConnection(&connID);
}


// Link the library on after this...
