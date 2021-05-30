/*
   SetJmp.h

   Copyright Apple Computer, Inc.	1986-1990, 1993-1995
   All rights reserved.
 */


#ifndef __SETJMP__
#define __SETJMP__

#ifdef __CFM68K__
	/* We MUST use the new, larger jmp_buf for CFM-68K */
	#undef OLD_JMPBUF
#endif

#if defined (powerc)
	typedef long *jmp_buf[64];      /*  PowerPC:  LR,CR,SP,TOC,RESVD,R13-R31,FP14-FP31,FPSCR,RESVD,RESVD  */
#elif defined (OLD_JMPBUF)
	typedef long *jmp_buf[12];		/*	old 68K:  D2-D7,PC,A2-A4,A6,SP  */
#else
	typedef long *jmp_buf[16];		/*	new 68K:  D2-D7,PC,A2-A4,A6,SP,FLAGS,A5,RESVD,RESVD  */
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif

int __setjmp(jmp_buf env);
#define setjmp(env) __setjmp(env)
void longjmp(jmp_buf env, int val);

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif
