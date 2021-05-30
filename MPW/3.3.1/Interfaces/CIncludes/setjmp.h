/*
   SetJmp.h

   Copyright Apple Computer, Inc.	1986-1990, 1993, 1994
   All rights reserved.
 */

#ifndef __SETJMP__
#define __SETJMP__

#ifdef __CFM68K__
	/* We MUST use the new, larger jmp_buf for CFM-68K */
	#undef OLD_JMPBUF
#endif

#if defined (powerc)
	typedef long *jmp_buf[64];      /*  PowerPC  */
#elif defined (OLD_JMPBUF)
	typedef long *jmp_buf[12];		/*	old 68K:  D2-D7,PC,A2-A4,A6,SP  */
#else
	typedef long *jmp_buf[16];		/*	new 68K:  D2-D7,PC,A2-A4,A6,SP,FLAGS,A5,RESVD,RESVD  */
#endif

#ifdef __cplusplus
extern "C" {
#endif

int __setjmp(jmp_buf env);
#define setjmp(env) __setjmp(env)
void longjmp(jmp_buf, int);

#ifdef __cplusplus
}
#endif

#endif
