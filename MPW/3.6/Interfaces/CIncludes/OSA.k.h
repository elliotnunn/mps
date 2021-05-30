/*
     File:       OSA.k.h
 
     Contains:   Open Scripting Architecture Client Interfaces.
 
     Version:    Technology: AppleScript 1.4
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1992-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __OSA_K__
#define __OSA_K__

#include <OSA.h>

#if CALL_NOT_IN_CARBON
#endif  /* CALL_NOT_IN_CARBON */

/*
	Example usage:

		#define OSA_BASENAME()	Fred
		#define OSA_GLOBALS()	FredGlobalsHandle
		#include <OSA.k.h>

	To specify that your component implementation does not use globals, do not #define OSA_GLOBALS
*/
#ifdef OSA_BASENAME
	#ifndef OSA_GLOBALS
		#define OSA_GLOBALS() 
		#define ADD_OSA_COMMA 
	#else
		#define ADD_OSA_COMMA ,
	#endif
	#define OSA_GLUE(a,b) a##b
	#define OSA_STRCAT(a,b) OSA_GLUE(a,b)
	#define ADD_OSA_BASENAME(name) OSA_STRCAT(OSA_BASENAME(),name)

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerCreateSession) (OSA_GLOBALS() ADD_OSA_COMMA OSAID  inScript, OSAID  inContext, OSADebugSessionRef * outSession);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetSessionState) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, AERecord * outState);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerSessionStep) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, OSADebugStepKind  inKind);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerDisposeSession) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetStatementRanges) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, AEDescList * outStatementRangeArray);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetBreakpoint) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, UInt32  inSrcOffset, OSAID * outBreakpoint);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerSetBreakpoint) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, UInt32  inSrcOffset, OSAID  inBreakpoint);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetDefaultBreakpoint) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, OSAID * outBreakpoint);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetCurrentCallFrame) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugSessionRef  inSession, OSADebugCallFrameRef * outCallFrame);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetCallFrameState) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugCallFrameRef  inCallFrame, AERecord * outState);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetVariable) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugCallFrameRef  inCallFrame, const AEDesc * inVariableName, OSAID * outVariable);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerSetVariable) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugCallFrameRef  inCallFrame, const AEDesc * inVariableName, OSAID  inVariable);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerGetPreviousCallFrame) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugCallFrameRef  inCurrentFrame, OSADebugCallFrameRef * outPrevFrame);

	EXTERN_API( OSAError  ) ADD_OSA_BASENAME(DebuggerDisposeCallFrame) (OSA_GLOBALS() ADD_OSA_COMMA OSADebugCallFrameRef  inCallFrame);


	/* MixedMode ProcInfo constants for component calls */
	enum {
		uppOSADebuggerCreateSessionProcInfo = 0x00003FF0,
		uppOSADebuggerGetSessionStateProcInfo = 0x00000FF0,
		uppOSADebuggerSessionStepProcInfo = 0x00000FF0,
		uppOSADebuggerDisposeSessionProcInfo = 0x000003F0,
		uppOSADebuggerGetStatementRangesProcInfo = 0x00000FF0,
		uppOSADebuggerGetBreakpointProcInfo = 0x00003FF0,
		uppOSADebuggerSetBreakpointProcInfo = 0x00003FF0,
		uppOSADebuggerGetDefaultBreakpointProcInfo = 0x00000FF0,
		uppOSADebuggerGetCurrentCallFrameProcInfo = 0x00000FF0,
		uppOSADebuggerGetCallFrameStateProcInfo = 0x00000FF0,
		uppOSADebuggerGetVariableProcInfo = 0x00003FF0,
		uppOSADebuggerSetVariableProcInfo = 0x00003FF0,
		uppOSADebuggerGetPreviousCallFrameProcInfo = 0x00000FF0,
		uppOSADebuggerDisposeCallFrameProcInfo = 0x000003F0
	};

#endif	/* OSA_BASENAME */


#endif /* __OSA_K__ */

