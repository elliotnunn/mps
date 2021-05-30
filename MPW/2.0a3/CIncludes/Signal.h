/*
 * Signal.h -- sigset(), sighold(), sigrelease(), sigpause()
 *
 * version	2.0a3
 *
 * Copyright 1985,1986 Apple Computer
 * All rights reserved.
 */
# ifndef __SIGNAL__
# define __SIGNAL__

typedef unsigned short	SignalMap;
typedef int 				SignalHandler();

# define NSIG				 (sizeof(SignalMap) * 8 /*bits*/)

# define SIGKILL			 0x0001	/* A "sure" kill, cannot be held or ignored. */
# define SIGINT			 0x0002	/* User Interrupt, typically CMD-. */
# define SIGUPDATE		 0x0004	/* Not implemented yet */
# define SIGADDRERR		 0x0008	/* Illegal address error */

# define SIGALLSIGS		 ((SignalMap) -1)

/*
 * Signal Managment functions
 */
extern SignalHandler *
	  sigset(/*SignalMap sigMap, SignalHandler *newHandler*/);
extern int
	 _sig_dfl(/*SignalMap signo, SignalMap sigState, SignalMap sigEnabled*/);
extern SignalMap
	  sighold(/*SignalMap sigMap*/);
extern void
	  sigrelease(/*SignalMap sigMap, SignalMap prevEnabled*/);
extern void
	  sigpause(/*SignalMap sigMap*/);

/*
 * Special parameters to sigset()
 * Ignoring a signal will set its handler to NIL
 */
# define 	SIG_IGN		((SignalHandler *) 0)
# define 	SIG_DFL		_sig_dfl

# endif __SIGNAL__
