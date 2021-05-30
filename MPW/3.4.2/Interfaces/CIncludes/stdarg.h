/*
	StdArg.h -- Variable arguments
	
	Copyright Apple Computer,Inc.	1987, 1990, 1994, 1995
	All rights reserved.

*/


#ifndef __STDARG__
#define __STDARG__

/*
 * Get common declarations 
 */

#include <NullDef.h>
#include <SizeTDef.h>
#include <VaListTDef.h>

#if __spillargs
	/*	"__spillargs" needed for PowerMac register-based calling conventions.  */
	/*	When using other preprocessors other than MrC, simply define "__spillargs".  */
	#undef __spillargs
	extern int __spillargs;
	#define va_start(ap, parmN) ap = (__spillargs, (va_list)((unsigned int)&(parmN) + (((sizeof(parmN)+3)/4)*4)))

#elif !defined (__SC__) || defined (__CFM68K__) || defined(__MRC__)
	/*	most normal compilers are long-word aligned…  */
	#define va_start(ap, parmN) ap = (va_list)((unsigned int)&(parmN) + (((sizeof(parmN)+3)/4)*4))

#else
	/*	…but Symantec C is word aligned.  */
	#define va_start(ap, parmN) ap = (va_list)((char*)&parmN + (((sizeof(parmN)+1)/2)*2))
#endif

#define va_arg(ap, type) ((type *)(ap += sizeof (type)))[-1]
#define va_end(ap)	/* do nothing */


#endif
