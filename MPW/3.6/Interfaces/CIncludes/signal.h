/*
	Signal.h -- Signal handling
	
	Copyright Apple Computer,Inc.	1988, 1990, 1995, 2000-2001
	All rights reserved.

*/

#ifndef __SIGNAL__
#define __SIGNAL__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif
	
	typedef int sig_atomic_t;
	
	typedef void ( *__sigfun )( int __sig );
	
	/*
	 *	Special signal handlers, compatible with the second argument to signal()
	 *	or, in the case of SIG_ERR, the return value from signal().
	 */
	
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#define SIG_DFL (( __sigfun ) 1)
	#define SIG_ERR (( __sigfun ) -1)
	#define SIG_IGN (( __sigfun ) 0)
	#define SIG_HOLD (( __sigfun ) 3)
	#define SIG_RELEASE (( __sigfun ) 5)
#else
	#define SIG_DFL (( __sigfun ) 0)
	#define SIG_ERR (( __sigfun ) -1)
	#define SIG_IGN (( __sigfun ) 1)
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */
	
	
	/*
	 *	Signal numbers for specific conditions.
	 */
	
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#define SIGABRT		(1<<0)	/* Abnormal termination e.g. by the abort() function */
	#define SIGFPE		(1<<2)	/* Arithmetic exception -- not currently implemented */
	#define SIGILL		(1<<3)	/* Illegal instruction -- not currently implemented */
	#define SIGINT		(1<<1)	/* Interactive attention signal -- User interrupt via CMD-. */
	#define SIGSEGV		(1<<4)	/* Segmentation violation -- not currently implemented */
	#define SIGTERM		(1<<5)	/* Termination request -- not currently implemented */
#else
	#define SIGABRT			 6	/* Abnormal termination e.g. by the abort() function */
	#define SIGFPE			 8	/* Arithmetic exception -- not currently implemented */
	#define SIGILL			 4	/* Illegal instruction -- not currently implemented */
	#define SIGINT			 2	/* Interactive attention signal -- User interrupt via CMD-. */
	#define SIGSEGV			11	/* Segmentation violation -- not currently implemented */
	#define SIGTERM			15	/* Termination request -- not currently implemented */
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */
	
	
	#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
		#pragma import on
	#endif
		
		/*
		 *	Specify a signal handling function.
		 */
		
		extern __sigfun signal(int sig, __sigfun func);
		
		
		/*
		 *	Send a signal.
		 */
		
		extern int raise (int sig);
		
	#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
		#pragma import off
	#endif
	
#ifdef __cplusplus
}
#endif

#endif
