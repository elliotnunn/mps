/*
	Assert.h -- Diagnostics
	
	Copyright Apple Computer,Inc.	1987, 1988
	All rights reserved.

*/

#ifndef __STDIO__
#include <stdio.h>
#endif __STDIO__

#ifndef __STDLIB__
#include <stdlib.h>
#endif __STDLIB__

#undef assert

#ifdef NDEBUG
#define assert(ignore) ((void) 0)
#else
#define assert(expression) \
	if (!(expression)) { \
		fprintf(stderr, "File %s; Line %d ## Assertion failed: " #expression "\n", \
				__FILE__, __LINE__); \
		abort(); \
	}
#endif NDEBUG
