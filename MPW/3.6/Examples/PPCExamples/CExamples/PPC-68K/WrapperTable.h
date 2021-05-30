/*
	File:		WrapperTable.h

	Contains:	Table of code pointers which will correspond with the functions exported
				from the 68K library
				Part of the "calling 68K code from PowerPC" demo

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 2/15/94	RC		Released

	To Do:
*/


#include <ConditionalMacros.h>
#include <MixedMode.h>

typedef pascal short (*MyRoutineProcPtr)(long);

enum {
	uppMyRoutineProcInfo = kPascalStackBased
		 | RESULT_SIZE (SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
};

#if TARGET_RT_MAC_CFM
// Use these definitions if we're compiling for Power Macintosh or another
// Macintosh system which supports Mixed Mode
typedef UniversalProcPtr MyRoutineUPP;

#define CallMyRoutineProc(userRoutine, longValue)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMyRoutineProcInfo, \
						  longValue)
#define NewMyRoutineProc(userRoutine)		\
		(MyRoutineUPP) NewRoutineDescriptor((ProcPtr)userRoutine, \
					   uppMyRoutineProcInfo, GetCurrentISA())
#else
// Use these definitions if we're compiling for a 68K-based Macintosh
typedef MyRoutineProcPtr MyRoutineUPP;

#define CallMyRoutineProc(userRoutine, longValue)		\
		(*(userRoutine))(longValue)
#define NewMyRoutineProc(userRoutine)		\
		(MyRoutineUPP)(userRoutine)
#endif

	
// Here's the list of Universal Procedure Pointers
struct JumpTable {
	MyRoutineUPP	routine1;
};

typedef struct JumpTable JumpTable, *JumpTablePtr;