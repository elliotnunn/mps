/*
 *	MacRuntime.h
 *	C Interface to the Macintosh Programmer's Workshop Libraries
 *
 * © Copyright Apple Computer Inc. 1993-1995, 2000-2001
 * All rights reserved.
 *
 * Warning:  This interface is NOT a part of the ANSI C standard.
 *			 We do NOT claim to be POSIX compliant.  If you want
 *			 your code to be portable, don't use this interface.
 */


#ifndef __MACRUNTIME__
#define __MACRUNTIME__	1


#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#if defined(__CFM68K__) || defined(__powerc)
#include <CodeFragments.h>		/* For "CFragInitBlockPtr". */
#endif /* __CFM68K__ || __powerc */

#if defined(__powerc)
#include <MacMemory.h>				/* For "THz". */
#endif /* __powerc */

#ifdef __cplusplus
extern "C" {
#endif

#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	
	/* Program Initialization and Termination */
	
	int _RTInit(ProcPtr retPC, int *pArgC, char ***pArgV, char ***pEnvP, int forPascal);
	void _RTExit(int status);
	
	/* Utility Routine */
	
	pascal Boolean TrapAvailable (short TrapNumber);
	
	#if defined(__CFM68K__) || defined(__powerc)
	
	/* Default code fragment initialization and termination entry points.		*/
	/* Needed for CFM applications or shared libraries containing C++ code.		*/
	
	extern OSErr	__init_app(CFragInitBlockPtr initBlockPtr);
	extern void		__term_app(void);
	extern OSErr	__init_lib(CFragInitBlockPtr initBlockPtr);
	extern void		__term_lib(void);
	
	#endif /* __CFM68K__ || __powerc */
	
	#if defined(__powerc)
	/* Types and functions for use in PowerMac CFM termination routines. */
	
	struct CFragWorld {
		THz heapZone;
		long emulatorA5;
		int unused;
	};
	
	typedef struct CFragWorld CFragWorld, *CFragWorldPtr;
	
	extern void __RestoreInitialCFragWorld(CFragWorldPtr oldCFragWorld);
	extern void __RevertCFragWorld(CFragWorldPtr oldCFragWorld);
	
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

#endif /* __powerc */

#ifdef __cplusplus
}
#endif
#endif

