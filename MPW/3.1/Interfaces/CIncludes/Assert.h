/************************************************************

	Assert.h
	Diagnostics
	
	Copyright Apple Computer,Inc.  1987-1989
	All rights reserved

************************************************************/


#undef assert

#ifdef NDEBUG

#define assert(ignore) ((void) 0)

#else

#ifndef __STDIO__
#include <StdIO.h>
#endif __STDIO__

#ifdef __cplusplus
void __abort();
#define assert(expression) \
	( (expression) ? (void) 0 : \
		(fprintf(stderr, "File %s; Line %d ## Assertion failed: " #expression "\n", \
		__FILE__, __LINE__), __abort()))
#else
void abort(void);
#define assert(expression) \
	( (expression) ? (void) 0 : \
		(fprintf(stderr, "File %s; Line %d ## Assertion failed: " #expression "\n", \
		__FILE__, __LINE__), abort()))
#endif

#endif NDEBUG

