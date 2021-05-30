/*
 *------------------------------------------------------------------------
 * Copyright:
 *      © 1993 by Apple Computer Inc.  all rights reserved.
 *
 * Project:
 *      PowerPC C++ Streams Library
 *
 * Filename:
 *      generic.h
 *
 * Created:
 *      (unknown)
 *
 * Modified:
 *      Date     Engineer       Comment
 *      -------- -------------- ------------------------------------------
 *      12/17/93 Rudy Wang      Made this file universal.
 *------------------------------------------------------------------------
 */
#ifndef __GENERICH__
#define __GENERICH__        1

/*
 * macros to paste tokens together to form new names
 */

#if defined(applec) || defined(powerc)

/*
 * ANSI C preprocessors will not expand the arguments to a macro;
 * so we need to add a level of indirection to allow macro expansion of
 * arguments.  (Reiser preprocessors allowed the first arg to be expanded;
 * this method will allow both to be expanded, which is better than none.)
 */
#define name2(a,b)           _name2_aux(a,b)
#define _name2_aux(a,b)      a##b
#define name3(a,b,c)         _name3_aux(a,b,c)
#define _name3_aux(a,b,c)    a##b##c
#define name4(a,b,c,d)       _name4_aux(a,b,c,d)
#define _name4_aux(a,b,c,d)  a##b##c##d

#else 

#os bsd3 svr2 svr3 sunos3 sunos4 hpux uts
#define name2(a,b)      a/**/b
#define name3(a,b,c)    a/**/b/**/c
#define name4(a,b,c,d)  a/**/b/**/c/**/d
#endos
#os bsd2 alliant
#define name2(a,b) a\
b
#define name3(a,b,c) a\
b\
c
#define name4(a,b,c,d) a\
b\
c\
d
#endos

#endif

#ifdef applec 

// Alas, MPW C++ doesn't have an ANSI C conformant preprocessor, so
//  the AT&T code as given doesn't work. The code below will work for 
//  MPW C++, but **NOT** for a compiler with an ANSI C conformant
//  preprocessor because the preprocessor isn't supposed to expand 
//  operands of ##. Undefine applec to use this header with other
//  compilers. Thanks to Allen Cecil for the suggested "fix". 
# define declare(a,t)        a##declare(t)
# define implement(a,t)      a##implement(t)
# define declare2(a,t1,t2)   a##declare2(t1,t2)
# define implement2(a,t1,t2) a##implement2(t1,t2)
#else /* applec */
#define declare(a,t) name2(a,declare)(t)
#define implement(a,t) name2(a,implement)(t)
#define declare2(a,t1,t2) name2(a,declare2)(t1,t2)
#define implement2(a,t1,t2) name2(a,implement2)(t1,t2)

#endif

extern genericerror(int, char*);
typedef int (*GPT)(int, char*);
#define set_handler(generic,type,x) name4(set_,type,generic,_handler)(x)
#define errorhandler(generic,type) name3(type,generic,handler)
#define callerror(generic,type,a,b) (*errorhandler(generic,type))(a,b)

#endif
