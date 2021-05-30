/*
	File:		ToolAPI.c

	Contains:	Interface to external tools

	Written by:	Brian Strull

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

			8/17/94		bls		New file.  
								
	To Do:
*/

#ifndef __TOOLAPI___
	#include "ToolAPI.h"
#endif

#ifndef __MODAPP__
	#include "ModApp.h"
#endif

// === Mixed Mode definitions for our callback routines
// We're creating these so we can have 68K tools and PowerPC tools work together
// in the application without needing multiple calling sequences

enum { 
	uppToolStartupProcInfo = kCStackBased 
							| RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolShutdownProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolMenuAdjustProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolMenuDispatchProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
							| STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short))),

	uppToolIdleProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolUpdateProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolWindowClickProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*))),

	uppToolWindowKeyProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*))),

	uppToolWindowMovedProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolWindowResizedProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolWindowActivateProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
};

// In the following functions, we compare the architecture of the tool with that
// of the application.  If they are the same, we do a direct call.  If not, we
// use mixedMode.  In a production application, you may want to cache the mixedMode
// discriptors, rather than re-creating them each time.


OSErr CallToolStartupProc (ToolStartupProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	OSErr err;
	
	if (typeCode == GetCurrentArchitecture())
	{
		err = (*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolStartupProcInfo, typeCode);
		err = CallUniversalProc (upp, uppToolStartupProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
	
	return err;
	
}


void  CallToolShutdownProc (ToolShutdownProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolShutdownProcInfo, typeCode);
		CallUniversalProc (upp, uppToolShutdownProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
		
}


void  CallToolMenuAdjustProc (ToolMenuAdjustProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolMenuAdjustProcInfo, typeCode);
		CallUniversalProc (upp, uppToolMenuAdjustProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
		
}

void  CallToolMenuDispatchProc (ToolMenuDispatchProcPtr proc, WindowPtr wp, short menuID, short itemID)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp, menuID, itemID);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolMenuDispatchProcInfo, typeCode);
		CallUniversalProc (upp, uppToolMenuDispatchProcInfo, wp, menuID, itemID);
		DisposeRoutineDescriptor (upp);
	}
		
}


void  CallToolIdleProc (ToolIdleProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolIdleProcInfo, typeCode);
		CallUniversalProc (upp, uppToolIdleProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
}


void  CallToolUpdateProc (ToolUpdateProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolUpdateProcInfo, typeCode);
		CallUniversalProc (upp, uppToolUpdateProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
}


void  CallToolWindowClickProc (ToolWindowClickProcPtr proc, WindowPtr wp, EventRecord *theEvent)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp, theEvent);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolWindowClickProcInfo, typeCode);
		CallUniversalProc (upp, uppToolWindowClickProcInfo, wp, theEvent);
		DisposeRoutineDescriptor (upp);
	}
}



void  CallToolWindowKeyProc(ToolWindowClickProcPtr proc, WindowPtr wp, EventRecord *theEvent)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp, theEvent);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolWindowKeyProcInfo, typeCode);
		CallUniversalProc (upp, uppToolWindowKeyProcInfo, wp, theEvent);
		DisposeRoutineDescriptor (upp);
	}
}

void  CallToolWindowMovedProc(ToolWindowMovedProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolWindowMovedProcInfo, typeCode);
		CallUniversalProc (upp, uppToolWindowMovedProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
}

void  CallToolWindowResizedProc(ToolWindowResizedProcPtr proc, WindowPtr wp)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolWindowResizedProcInfo, typeCode);
		CallUniversalProc (upp, uppToolWindowResizedProcInfo, wp);
		DisposeRoutineDescriptor (upp);
	}
}

void  CallToolWindowActivateProc(ToolWindowActivateProcPtr proc, WindowPtr wp, Boolean activeFlag)
{
	short typeCode = ((DrawingWindowPeek)wp)->toolCodeType;
	
	if (typeCode == GetCurrentArchitecture())
	{
		(*proc) (wp, activeFlag);
	}
	else
	{		
		UniversalProcPtr upp  = NewRoutineDescriptor((ProcPtr) proc, uppToolWindowActivateProcInfo, typeCode);
		CallUniversalProc (upp, uppToolWindowActivateProcInfo, wp, activeFlag);
		DisposeRoutineDescriptor (upp);
	}
}
